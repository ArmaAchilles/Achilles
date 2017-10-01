////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/25/17
//	VERSION: 1.0
//  DESCRIPTION: Function for lock door module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private ["_buildings","_mode","_group_logic"];

_center_pos = position _logic;

// if (not isMultiplayer) exitWith {[localize "STR_MODULE_DOES_NOT_SUPPORT_SP"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

_dialogResult = 
[
	localize "STR_LOCK_DOORS",
	[
		[localize "STR_SELECTION", [localize "STR_NEAREST", localize "STR_RANGE"]],
		[(localize "STR_RANGE") + " [m]","","100"],
		[localize "STR_MODE", [localize "STR_UNBREACHABLE", localize "STR_BREACHABLE", localize "STR_OPEN"]]
	],
	"Achilles_fnc_RscDisplayAttributes_LockDoors"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

switch (_dialogResult select 0) do
{
	case 0:	
	{
		_buildings = nearestObjects [_center_pos, ["Building"], 50, true];
		_buildings resize 1;
	};
	case 1: 
	{
		_buildings = nearestObjects [_center_pos, ["Building"], parseNumber (_dialogResult select 1), true];
	};
};

_mode = _dialogResult select 2;
_logic_list = [];
_sourceObject_list = [];

if (_mode == 1 and {isNil "Achilles_var_breachableDoors"}) then
{
	Achilles_var_breachableDoors = [];
	publicVariable "Achilles_var_breachableDoors";
	publicVariable "Achilles_fnc_breachStun";
	publicVariable "Achilles_fnc_addBreachDoorAction";
	
	[[],
	{
		while {isNull player} do {uiSleep 1};
		call Achilles_fnc_addBreachDoorAction;
		player addEventHandler ["Respawn",{call Achilles_fnc_addBreachDoorAction}];
	}, 0, "Achilles_id_breachInit"] call Achilles_fnc_spawn;
};

if (_mode < 2) then
{
	_group_logic = createGroup sideLogic;
	_group_logic deleteGroupWhenEmpty true;
};

{
	_building = _x;
	_source_cfg = [(configFile >> "cfgVehicles" >> typeOf _building  >> "AnimationSources"), 0] call BIS_fnc_subClasses;
	{
		_source = configName _x;
		_content = _source splitString "_";
		if (toLower (_content select 2) == "sound") then
		{
			_door_name = (_content select [0,2]) joinString "_";
			_trigger_pos = _building modelToWorld (_building selectionPosition (_door_name + "_trigger"));
			if (_trigger_pos isEqualTo [0,0,0]) exitWith {};
			// _trigger_pos = if (surfaceIsWater _trigger_pos) then {_trigger_pos} else {ATLToASL _trigger_pos};

			// remove old logic
			_close_logics = _trigger_pos nearObjects ["module_f", 1];
			if(count _close_logics > 0) then 
			{
				_logic = _close_logics select 0;
				{deleteVehicle _x} forEach (attachedObjects _logic);
				deleteVehicle _logic;
			};
			
			_lock_var = "bis_disabled_" + _door_name;
		
			if (_mode == 2) then
			{
				// open door
				_building animateSource [_source, 1, true];
				_building setVariable [_lock_var, 0, true];
			} else
			{
				// close and lock door
				_building animateSource [_source, 0, true];
				_building setVariable [_lock_var, 1, true];
				
				// add door control logic
				_logic = _group_logic createUnit ["module_f", _trigger_pos, [], 0, "CAN_COLLIDE"];
				_logic setVariable ["lock_params", [_building, _lock_var, _trigger_pos, _source], true];
				_logic_list pushBack _logic;
				
				if (_mode == 1) then
				{
					_sourceObject = "Land_ClutterCutter_small_F" createVehicle [0,0,0];
					_sourceObject attachTo [_logic, [0,0,0]];
					_sourceObject_list pushBack _sourceObject;
					Achilles_var_breachableDoors pushBack _sourceObject;
					[_sourceObject, ["Deleted", 
					{
						_sourceObject = _this select 0;
						{deleteVehicle _x} forEach (attachedObjects _sourceObject);
						Achilles_var_breachableDoors = Achilles_var_breachableDoors - [_sourceObject];
						publicVariable "Achilles_var_breachableDoors";
					}]] remoteExec ["addEventHandler", 2];
				};
			};
		};
	} forEach _source_cfg;
} forEach _buildings;

if (_mode < 2) then 
{
	private _allocation_error_cases = 0;
	// critical delay for proper name setting of game logics
	waitUntil {sleep 0.5; {name _x != "" and {not isNull _x}} count _logic_list == 0};
	
	{
		if (not isNull _x) then
		{
			[_x, "Hodor"] remoteExecCall ["setName", 0, _x];
		} else
		{
			_allocation_error_cases = _allocation_error_cases + 1;
			if (_mode == 1) then
			{
				// handle incorrect cases
				deleteVehicle (_sourceObject_list select _forEachIndex);
			};
		};
	} forEach _logic_list;
	
	if (_allocation_error_cases > 0) then {hint format ["Allocation error: Could not create a door lock logic! (occured in %1/%2 cases)", _allocation_error_cases, count _logic_list]};
	
	[_logic_list + _sourceObject_list, true] call Ares_fnc_AddUnitsToCurator;
	if (_mode == 1) then {publicVariable "Achilles_var_breachableDoors"};
};

[objNull, format [localize "STR_DOOR_STATUS_CHANGED", count _logic_list]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
