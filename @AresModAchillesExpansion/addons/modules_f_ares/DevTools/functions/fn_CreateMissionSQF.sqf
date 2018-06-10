#include "\achilles\modules_f_ares\module_header.hpp"

Ares_EditableObjectBlacklist =
[
	"ModuleCurator_F",
	"GroundWeaponHolder",
	"Salema_F",
	"Ornate_random_F",
	"Mackerel_F",
	"Tuna_F",
	"Mullet_F",
	"CatShark_F",
	"Rabbit_F",
	"Snake_random_F",
	"Turtle_F",
	"Hen_random_F",
	"Cock_random_F",
	"Cock_white_F",
	"Sheep_random_F"
];

private _radius = 100;
private _position = _this select 0;

private _dialogResult =
	[
		localize "STR_AMAE_COPY_MISSION_SQF",
		[
			[localize "STR_AMAE_RANGE", ["50m", "100m", "500m", "1km", "2km", "5km", localize "STR_AMAE_ENTIRE_MAP"], 6],
			[localize "STR_AMAE_INCLUDE_AI", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
			[localize "STR_AMAE_INCLUDE_EMPTY_VEHICLES", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
			[localize "STR_AMAE_INCLUDE_OBJECTS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
			[localize "STR_AMAE_INCLUDE_MARKERS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1]
		]
	] call Ares_fnc_ShowChooseDialog;
if (_dialogResult isEqualTo []) exitWith { "User cancelled dialog."; };

["User chose radius with index '%1'", _dialogResult] call Achilles_fnc_log;
_radius = 100;
_radius = switch (_dialogResult select 0) do
{
	case 0: { 50 };
	case 1: { 100 };
	case 2: { 500 };
	case 3: { 1000 };
	case 4: { 2000 };
	case 5: { 5000 };
	case 6: { -1 };
	default { 100 };
};
private _includeUnits = (_dialogResult select 1 == 0);
private _includeEmptyVehicles = (_dialogResult select 2 == 0);
private _includeEmptyObjects = (_dialogResult select 3 == 0);
private _includeMarkers = (_dialogResult select 4 == 0);

private _objectsToFilter = curatorEditableObjects (getAssignedCuratorLogic player);
private _emptyObjects = [];
private _emptyVehicles = [];
private _groups = [];
{
	private _ignoreFlag = ((typeOf _x) in Ares_EditableObjectBlacklist || isPlayer _x);

	if (!_ignoreFlag && ((_x distance _position <= _radius) || _radius == -1)) then
	{
		["Processing object: %1 - %2", _x, typeof(_x)] call Achilles_fnc_log;
		_ignoreFlag = true;
		private _isUnit = (_x isKindOf "CAManBase")
			|| (_x isKindOf "car")
			|| (_x isKindOf "tank")
			|| (_x isKindOf "air")
			|| (_x isKindOf "StaticWeapon")
			|| (_x isKindOf "ship");
		if (_isUnit) then
		{
			if (_x isKindOf "CAManBase") then
			{
				["Is a man."] call Achilles_fnc_log;
				if ((group _x) in _groups) then
				{
					["In an old group."] call Achilles_fnc_log;
				}
				else
				{
					["In a new group."] call Achilles_fnc_log;
					_groups pushBack (group _x);
				};

			}
			else
			{
				if (count crew _x > 0) then
				{
					["Is a vehicle with units."] call Achilles_fnc_log;
					if ((group _x) in _groups) then
					{
						["In an old group."] call Achilles_fnc_log;
					}
					else
					{
						["In a new group."] call Achilles_fnc_log;
						_groups pushBack (group _x);
					};
				}
				else
				{
					["Is an empty vehicle."] call Achilles_fnc_log;
					_emptyVehicles pushBack _x;
				};
			};
		}
		else
		{
			if (_x isKindOf "Logic") then
			{
				["Is a logic. Ignoring."] call Achilles_fnc_log;
			}
			else
			{
				["Is an empty vehicle."] call Achilles_fnc_log;
				_emptyObjects pushBack _x;
			};
		};
	}
	else
	{
		["Ignoring object: %1 - %2", _x, typeof(_x)] call Achilles_fnc_log;
	};
} forEach _objectsToFilter;

private _output = [];
if (!_includeUnits) then { _groups = []; };
if (!_includeEmptyVehicles) then { _emptyVehicles = []; };
if (!_includeEmptyObjects) then { _emptyObjects = []; };

private _totalUnitsProcessed = 0;
{
	_output pushBack format [
		"_newObject = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; _newObject setPosWorld %3; [_newObject, [%4, %5]] remoteExecCall [""setVectorDirAndUp"", 0, _newObject]; _newObject enableSimulationGlobal %6;",
		(typeOf _x),
		(position _x),
		(getPosWorld _x),
		(vectorDir _x),
		(vectorUp _x),
		(simulationEnabled _x)];
} forEach _emptyObjects + _emptyVehicles;

{
	private _sideString = "";
	switch (side _x) do
	{
		case east: { _sideString = "east"; };
		case west: { _sideString = "west"; };
		case resistance: { _sideString = "resistance"; };
		case civilian: { _sideString = "civilian"; };
		default { _sideString = "sideUnknown"; };
	};
	_output pushBack format [
		"_newGroup = createGroup %1; ",
		_sideString];
	private _groupVehicles = [];
	// Process all the infantry in the group
	{
		if (isNull objectParent _x) then
		{
			_output pushBack format [
				"_newUnit = _newGroup createUnit ['%1', %2, [], 0, 'CAN_COLLIDE']; _newUnit setSkill %3; _newUnit setRank '%4'; _newUnit setFormDir %5; _newUnit setDir %5; _newUnit setPosWorld %6;",
				(typeOf _x),
				(position _x),
				(skill _x),
				(rank _x),
				(getDir _x),
				(getPosWorld _x)];
		}
		else
		{
			if (!((vehicle _x) in _groupVehicles)) then
			{
				_groupVehicles pushBack (vehicle _x);
			};
		};
		_totalUnitsProcessed = _totalUnitsProcessed + 1;
	} forEach (units _x);

	// Create the vehicles that are part of the group.
    {
    	_output pushBack format [
    		"_newUnit = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; createVehicleCrew _newUnit; (crew _newUnit) join _newGroup; _newUnit setDir %3; _newUnit setFormDir %3; _newUnit setPosWorld %4;",
    	    (typeOf _x),
     		(position _x),
     		(getDir _x),
     		(getPosWorld _x)];
    } forEach _groupVehicles;

	// Set group behaviours
	_output pushBack format [
		"_newGroup setFormation '%1'; _newGroup setCombatMode '%2'; _newGroup setBehaviour '%3'; _newGroup setSpeedMode '%4';",
		(formation _x),
		(combatMode _x),
		(behaviour (leader _x)),
		(speedMode _x)];

	{
		if (_forEachIndex > 0) then
		{
			_output pushBack format [
				"_newWaypoint = _newGroup addWaypoint [%1, %2]; _newWaypoint setWaypointType '%3';%4 %5 %6",
				(waypointPosition _x),
				0,
				(waypointType _x),
				if ((waypointSpeed _x) != 'UNCHANGED') then { "_newWaypoint setWaypointSpeed '" + (waypointSpeed _x) + "'; " } else { "" },
				if ((waypointFormation _x) != 'NO CHANGE') then { "_newWaypoint setWaypointFormation '" + (waypointFormation _x) + "'; " } else { "" },
				if ((waypointCombatMode _x) != 'NO CHANGE') then { "_newWaypoint setWaypointCombatMode '" + (waypointCombatMode _x) + "'; " } else { "" }
				];
		};
	} forEach (waypoints _x)
} forEach _groups;

if (_includeMarkers) then
{
	{
		private _markerName = "Ares_Imported_Marker_" + str(_forEachIndex);
		_output pushBack format [
			"_newMarker = createMarker ['%1', %2]; _newMarker setMarkerShape '%3'; _newMarker setMarkerType '%4'; _newMarker setMarkerDir %5; _newMarker setMarkerColor '%6'; _newMarker setMarkerAlpha %7; %8 %9",
			_markerName,
			(getMarkerPos _x),
			(markerShape _x),
			(markerType _x),
			(markerDir _x),
			(getMarkerColor _x),
			(markerAlpha _x),
			if ((markerShape _x) == "RECTANGLE" ||(markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerSize " + str(markerSize _x) + ";"; } else { ""; },
			if ((markerShape _x) == "RECTANGLE" || (markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerBrush " + str(markerBrush _x) + ";"; } else { ""; }
			];
	} forEach allMapMarkers;
};

private _text = "";
{
	_text = _text + _x;
	[_x] call Achilles_fnc_log;
} forEach _output;
uiNamespace setVariable ['Ares_CopyPaste_Dialog_Text', _text];
private _dialog = createDialog "Ares_CopyPaste_Dialog";
[localize "STR_AMAE_GENERATED_SQF_FROM_MISSION_OBJECTS", count _emptyObjects, count _groups, _totalUnitsProcessed] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
