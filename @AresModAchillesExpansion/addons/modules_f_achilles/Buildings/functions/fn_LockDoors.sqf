////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/25/17
//	VERSION: 1.0
//  DESCRIPTION: Function for lock door module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private ["_buildings","_mode"];

_center_pos = position _logic;

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
		_buildings = nearestObjects [_center_pos, ["Building"], 50];
		_buildings resize 1;
	};
	case 1: 
	{
		_buildings = nearestObjects [_center_pos, ["Building"], parseNumber (_dialogResult select 1)];
	};
};

_mode = _dialogResult select 2;
_logic_group = createGroup sideLogic;
_logics = [];

if (_mode == 1 and {isNil "Achilles_var_breachableDoors"}) then
{
	Achilles_var_breachableDoors = [];
	publicVariable "Achilles_var_breachableDoors";
	publicVariable "Achilles_fnc_addBreachDoorAction";
	
	[[],
	{
		while {isNull player} do {uiSleep 1};
		call Achilles_fnc_addBreachDoorAction;
		player addEventHandler ["Respawn",{call Achilles_fnc_addBreachDoorAction}];
	}] remoteExec ["spawn",0,true];
};

{
	_building = _x;
	systemChat typeOf _building;
	_source_cfg = [(configFile >> "cfgVehicles" >> typeOf _building  >> "AnimationSources"), 0] call BIS_fnc_subClasses;
	{
		_source = configName _x;
		_content = _source splitString "_";
		if (toLower (_content select 2) == "sound") then
		{
			_door_name = (_content select [0,2]) joinString "_";
			_trigger_pos = _building modelToWorld (_building selectionPosition (_door_name + "_trigger"));
			systemChat str [_door_name + "_trigger", _trigger_pos];
			if (_trigger_pos isEqualTo [0,0,0]) exitWith {};
		
			if (_mode == 2) then
			{
				comment '// open door';
				_building animateSource [_source, 1, true];
				_logics pushBack _trigger_pos;
			} else
			{
				comment '// close and lock door';
				_building animateSource [_source, 0, true];
				_lock_var = "bis_disabled_" + _door_name;
				_building setVariable [_lock_var, 1, true];
				
				comment '// add door control logic';
				_logic = _logic_group createUnit ["Module_f", [0,0,0], [], 0, "NONE"];
				
				_logic setVariable ["lock_params", [_building, _lock_var, _trigger_pos, _source], true];

				[_logic, ["Deleted",
				{
					_logic = _this select 0;
					(_logic getVariable "lock_params") params ["_building", "_lock_var"];
					_building setVariable [_lock_var, 0, true];
					{deleteVehicle _x} forEach (attachedObjects _logic);
					_logic_group = group _logic;
					deleteGroup _logic_group;
				}]] remoteExec ["addEventHandler", 2];
				_logics pushBack _logic;
			};
		};
	} forEach _source_cfg;
} forEach _buildings;

if (_mode == 2) then 
{
	{
		_logic = _x nearObjects ["Module_f", 1];
		if(not isNull _logic) then {deleteVehicle _x};
	} forEach _logics;
} else
{
	comment '// delayed post modifications are curucial!';
	uiSleep 5;
	if (count _logics == 0) exitWith {deleteGroup _logic_group};
	_sourceObjects = [];
	
	{
		[_x, "Hodor"] remoteExecCall ["setName", 0, _x];
		(_x getVariable "lock_params") params ["_building", "_lock_var", "_trigger_pos"];
		_x setPos _trigger_pos;
		if (_mode == 1) then
		{
			_sourceObject = "Land_ClutterCutter_small_F" createVehicle [0,0,0];
			_sourceObject attachTo [_x, [0,0,0]];
			_sourceObjects pushBack _sourceObject;
			Achilles_var_breachableDoors pushBack _sourceObject;
			[_sourceObject, ["Deleted", 
			{
				_sourceObject = _this select 0;
				{deleteVehicle _x} forEach (attachedObjects _sourceObject);
				Achilles_var_breachableDoors = Achilles_var_breachableDoors - [_sourceObject];
				publicVariable "Achilles_var_breachableDoors";
			}]] remoteExec ["addEventHandler", 2];
		};
	} forEach _logics;
	
	[_logics + _sourceObjects, true] call Ares_fnc_AddUnitsToCurator;
	if (_mode == 1) then {publicVariable "Achilles_var_breachableDoors"};
};

[objNull, format ["CHANGED STATUS OF %1 DOORS!", count _logics]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
