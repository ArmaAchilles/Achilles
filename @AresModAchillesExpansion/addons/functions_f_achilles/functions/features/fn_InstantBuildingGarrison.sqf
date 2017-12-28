EYE_HEIGHT = 1.53;
REL_REF_POS_LIST_HORIZONTAL = [[25,0,0],[0,25,0],[-25,0,0],[0,-25,0]];
REL_REF_POS_VERTICAL = [0,0,25];

private _fnc_isInsideBuilding =
{
	params ["_pos","_building"];
	_pos = ATLToASL _pos;
	_pos set [2, EYE_HEIGHT + (_pos select 2)];
	if (_building in (lineIntersectsObjs [_pos, _pos vectorAdd REL_REF_POS_VERTICAL])) then
	{
		if ({_building in (lineIntersectsObjs [_pos, _pos vectorAdd _x])} count REL_REF_POS_LIST_HORIZONTAL >= 3) then {true} else {false};
	} else {false};
};

[param[0],units group param[1], 150, true, true] params ["_center", "_units", "_searchRadius", "_insideOnly", "_fillEvenly"];
private _errorOccured = false;
private _buildings = if (_searchRadius < 0) then {[nearestBuilding _center]} else {nearestObjects [_center, ["building"], _searchRadius, true]};
private _pos_nestedList = [];
{
	private _building = _x;
	private _pos_list = [_building] call BIS_fnc_buildingPositions;
	for "_i_pos" from (count _pos_list - 1) to 0 step -1 do
	{
		private _pos = _pos_list select _i_pos;
		if (count (_pos nearEntities [["Man"], 0.5]) > 0 or {_insideOnly and {not ([_pos, _building] call _fnc_isInsideBuilding)}}) then 
		{
			_pos_list deleteAt _i_pos;
		};
	};
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
			private _i_building = floor random [0,0, _n_building];
			private _pos_list = _pos_nestedList select _i_building;
			private _i_pos = floor random count _pos_list;
			_pos = +(_pos_list select _i_pos);
			_pos_list deleteAt _i_pos;
			if (count _pos_list == 0) then {_pos_nestedList deleteAt _i_building};
		} else
		{
			private _i_building = 0;
			private _pos_list = _pos_nestedList select _i_building;
			private _i_pos = floor random count _pos_list;
			_pos = +(_pos_list select _i_pos);
			_pos_list deleteAt _i_pos;
			if (count _pos_list == 0) then {_pos_nestedList deleteAt _i_building};
		};
		_unit setPosATL _pos;
	} else
	{
		_errorOccured = true;
	};
	_unit forceSpeed 0;
};
if (_errorOccured) then
{
	[localize "STR_AMAE_DID_NOT_FOUNT_SUFFICIENT_FREE_POSITIONS"] call Achilles_fnc_showZeusErrorMessage;
};


