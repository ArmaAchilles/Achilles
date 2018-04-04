////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/25/17
//	VERSION: 1.0
//  DESCRIPTION: Function for lock door module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private ["_buildings","_group_logic"];

private _center_pos = position _logic;

// if (not isMultiplayer) exitWith {[localize "STR_AMAE_MODULE_DOES_NOT_SUPPORT_SP"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

private _dialogResult =
[
	localize "STR_AMAE_LOCK_DOORS",
	[
		[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_NEAREST", localize "STR_AMAE_RANGE_NO_SI"]],
		[localize "STR_AMAE_RANGE","","100"],
		[localize "STR_AMAE_MODE", [localize "STR_AMAE_UNBREACHABLE", localize "STR_AMAE_BREACHABLE", localize "STR_AMAE_OPEN"]]
	],
	"Achilles_fnc_RscDisplayAttributes_LockDoors"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

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

if (_buildings isEqualTo []) exitWith {[localize "STR_AMAE_NO_BUILDINGS_FOUND"] call Achilles_fnc_showZeusErrorMessage};

private _mode = _dialogResult select 2;
private _logic_list = [];
private _sourceObject_list = [];

if (_mode == 1 and {isNil "Achilles_var_breachableDoors"}) then
{
	Achilles_var_breachableDoors = [];
	publicVariable "Achilles_var_breachableDoors";
	publicVariable "Achilles_fnc_breachStun";
	publicVariable "Achilles_fnc_addBreachDoorAction";
	STR_AMAE_SET_A_BREACHING_CHARGE = localize "STR_AMAE_SET_A_BREACHING_CHARGE";
	publicVariable "STR_AMAE_SET_A_BREACHING_CHARGE";
	STR_AMAE_TOUCH_OFF_BREACH = localize "STR_AMAE_TOUCH_OFF_BREACH";
	publicVariable "STR_AMAE_TOUCH_OFF_BREACH";
	Achilles_var_zeusLanguage = language player;
	publicVariable "Achilles_var_zeusLanguage";
	
	[[],
	{
		while {isNull player} do {uiSleep 1};
		player call Achilles_fnc_addBreachDoorAction;
		player addEventHandler ["Respawn",{player call Achilles_fnc_addBreachDoorAction}];
	}, 0, "Achilles_id_breachInit"] call Achilles_fnc_spawn;
};

if (_mode < 2) then
{
	_group_logic = createGroup sideLogic;
	_group_logic deleteGroupWhenEmpty true;
};

{
	private _building = _x;
	private _source_cfg = [(configFile >> "cfgVehicles" >> typeOf _building  >> "AnimationSources"), 0] call BIS_fnc_subClasses;
	{
		private _source = configName _x;
		private _content = _source splitString "_";
		if (toLower (_content select 2) == "sound") then
		{
			private _door_name = (_content select [0,2]) joinString "_";
			private _trigger_pos = _building modelToWorld (_building selectionPosition (_door_name + "_trigger"));
			if (_trigger_pos isEqualTo [0,0,0]) exitWith {};
			// _trigger_pos = if (surfaceIsWater _trigger_pos) then {_trigger_pos} else {ATLToASL _trigger_pos};

			// remove old logic
			private _close_logics = _trigger_pos nearObjects ["module_f", 1];
			if(count _close_logics > 0) then
			{
				private _logic = _close_logics select 0;
				{deleteVehicle _x} forEach (attachedObjects _logic);
				deleteVehicle _logic;
			};

			private _lock_var = "bis_disabled_" + _door_name;

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
				private _logic = _group_logic createUnit ["module_f", _trigger_pos, [], 0, "CAN_COLLIDE"];
				_logic setVariable ["lock_params", [_building, _lock_var, _trigger_pos, _source], true];
				_logic_list pushBack _logic;

				if (_mode == 1) then
				{
					private _sourceObject = "Land_ClutterCutter_small_F" createVehicle [0,0,0];
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
		if (!isNull _x) then
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

	if (_allocation_error_cases > 0) then {hint format [localize "STR_AMAE_LOCKS_ALLOCATION_ERROR", _allocation_error_cases, count _logic_list]};

	[_logic_list + _sourceObject_list, true] call Ares_fnc_AddUnitsToCurator;
	if (_mode == 1) then {publicVariable "Achilles_var_breachableDoors"};
};

[objNull, format [localize "STR_AMAE_DOOR_STATUS_CHANGED", count _logic_list]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
