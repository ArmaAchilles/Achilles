////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			12/26/17
// VERSION: 		AMAE.0.1.0
// DESCRIPTION:		Teleports units to random positions in nearby buildings.
//					Preferably orients them in such that they look out of windows.
//					They won't be able to move away till forceSpeed is set to -1.
//
// ARGUMENTS:		0: ARRAY - 3D position from where the building search starts.
//					1: ARRAY - Array of units which are used for the occupation.
//					2: SCALAR - Building search radius in meter (default: 150).
//					3: BOOLEAN - Only use positions inside buildings (default: false).
//					4: BOOLEAN - Distribute units evenly over closest buildings (default: false).
//
// RETURNS:			nothing
//
// Example:			[position leader _group, units _group] call Achilles_fnc_instantBuildingGarrison;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define GOOD_LOS			10
#define MEDIOCRE_LOS		3
#define EYE_HEIGHT			1.53
#define REL_REF_POS_LIST_HORIZONTAL		[[25,0,0],[0,25,0],[-25,0,0],[0,-25,0]]
#define REL_REF_POS_VERTICAL			[0,0,25]

// get arguments
params ["_center", "_units", ["_searchRadius",150,[0]], ["_insideOnly",false,[false]], ["_fillEvenly",false,[false]]];

private _errorOccured = false;

// local function for checking whether positions are inside a building
private _fnc_isInsideBuilding =
{
	params ["_pos","_building"];
	_pos = ATLToASL _pos;
	_pos set [2, EYE_HEIGHT + (_pos select 2)];
	
	// if we have at least 3 walls and a roof, we are inside
	if (_building in (lineIntersectsObjs [_pos, _pos vectorAdd REL_REF_POS_VERTICAL])) then
	{
		{_building in (lineIntersectsObjs [_pos, _pos vectorAdd _x])} count REL_REF_POS_LIST_HORIZONTAL >= 3;
	}
	else
	{
		false;
	};
};

// get all near buildings and their positions inside
private _nearestBuildings = nearestObjects [_center, ["building"], _searchRadius, true];
private _buildings = if (_searchRadius < 0) then {[_nearestBuildings select 0]} else {_nearestBuildings};
private _pos_nestedList = [];
{
	private _building = _x;
	private _pos_list = [_building] call BIS_fnc_buildingPositions;

	// filter positions that are already occupied or not inside if "inside only" is true.
	for "_i_pos" from (count _pos_list - 1) to 0 step -1 do
	{
		private _pos = _pos_list select _i_pos;
		if (count (_pos nearEntities [["Man"], 0.5]) > 0 or {_insideOnly and {not ([_pos, _building] call _fnc_isInsideBuilding)}}) then 
		{
			_pos_list deleteAt _i_pos;
		};
	};

	// filter buildings that do not offer valid positions
	if (not (_pos_list isEqualTo [])) then
	{
		_pos_nestedList pushBack _pos_list;
	};
} forEach _buildings;

for "_i_unit" from 0 to (count _units - 1) do
{
	private _unit = _units select _i_unit;
	private "_pos";
	private _n_building = count _pos_nestedList;
	
	if (_n_building > 0) then
	{
		if (_fillEvenly) then
		{
			// fill closest buildings by distributing the units randomly
			private _i_building = floor random _n_building;
			private _pos_list = _pos_nestedList select _i_building;
			private _i_pos = floor random count _pos_list;
			_pos = +(_pos_list select _i_pos);
			_pos_list deleteAt _i_pos;
			if (count _pos_list == 0) then {_pos_nestedList deleteAt _i_building};
		}
		else
		{
			// fill closest buildings one by one
			private _i_building = 0;
			private _pos_list = _pos_nestedList select _i_building;
			private _i_pos = floor random count _pos_list;
			_pos = +(_pos_list select _i_pos);
			_pos_list deleteAt _i_pos;
			if (count _pos_list == 0) then {_pos_nestedList deleteAt _i_building};
		};
		_unit setPosATL _pos;
		
		// rotate unit for a good line of sight
		private _eyePosASL = (ATLToASL _pos) vectorAdd [0,0,EYE_HEIGHT];
		private _startAngle = (round random 360);
        for "_angle" from _startAngle to (_startAngle + 360) step 10 do
		{
			// use angle finally if the line of sight is good
			private _relRefPos = [GOOD_LOS*sin(_angle), GOOD_LOS*cos(_angle), 0];
			if (not lineIntersects [_eyePosASL, _eyePosASL vectorAdd _relRefPos]) exitWith
			{
				_unit doWatch (_pos vectorAdd _relRefPos);
			};

			// use angle provisionally if the line of sight is mediocre
			private _relRefPos = [MEDIOCRE_LOS*sin(_angle), MEDIOCRE_LOS*cos(_angle), 0];
			if (not lineIntersects [_eyePosASL, _eyePosASL vectorAdd _relRefPos]) then
			{
				_unit doWatch (_pos vectorAdd _relRefPos);
			};
		};
	}
	else
	{
		// if we don't have sufficient building positions
		_errorOccured = true;
	};
	_unit forceSpeed 0;
};

if (_errorOccured) then
{
	[localize "STR_AMAE_DID_NOT_FIND_SUFFICIENT_FREE_POSITIONS"] call Achilles_fnc_showZeusErrorMessage;
};


