////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 12/18/16
//	VERSION: 5.0
//	FILE: achilles\modules_f_achilles\FireSupport\functions\fn_FireSupportSuppressiveFire.sqf
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

// find unit to perform suppressiove fire
_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// get list of possible targest
_allTargetsUnsorted = allMissionObjects "Achilles_Create_Suppression_Target_Module";
if (count _allTargetsUnsorted == 0) exitWith {[localize "STR_NO_TARGET_MARKER"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
_allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
_targetChoices = [localize "STR_RANDOM", localize "STR_NEAREST", localize "STR_FARTHEST"];
{
	_targetChoices pushBack (name _x);
} forEach _allTargets;
if (count _targetChoices == 3) exitWith {[localize "STR_NO_TARGET_AVAIABLE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

// select parameters
_dialogResult = 
[
	localize "STR_SUPPRESIVE_FIRE",
	[
		[format [localize "STR_SUPPRESS_X", " "], _targetChoices],
		[localize "STR_STANCE", [localize "STR_PRONE",localize "STR_CROUCH",localize "STR_STAND"]],
		[localize "STR_FIRE_MODE", [localize "STR_AUTOMATIC", localize "STR_BURST", localize "STR_SINGLE_SHOT"]],
		[localize "STR_DURATION", "", "10"]
	]
] call Ares_fnc_ShowChooseDialog;
if (count _dialogResult == 0) exitWith {};

_stanceIndex = _dialogResult select 1;
_fireModeIndex = _dialogResult select 2;
_duration = parseNumber (_dialogResult select 3);
_targetChooseAlgorithm = _dialogResult select 0;

// Choose a target to fire at
_selectedTarget = objNull;
switch (_targetChooseAlgorithm) do
{
	case 0: // Random
	{
		_selectedTarget = _allTargets call BIS_fnc_selectRandom;
	};
	case 1: // Nearest
	{
		_selectedTarget = [position _logic, _allTargets] call Ares_fnc_GetNearest;
	};
	case 2: // Furthest
	{
		_selectedTarget = [position _logic, _allTargets] call Ares_fnc_GetFarthest;
	};
	default // Specific target
	{
		_selectedTarget = _allTargets select (_targetChooseAlgorithm - 3);
	};
};

// activate unit selection mode if module was not dropped on a unit
if (isNull _unit) then
{
	_unit = ["group",true] call Achilles_fnc_SelectUnits;
};
if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {[localize "STR_NO_GROUP_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};


_old_group = group _unit;
_units = units _old_group;

//save and remove waypoints
_current_wp = [_old_group,(currentWaypoint _old_group) - 1];
_waypoints = waypoints _old_group;
//_waypoint_storage

// force unit to change formation if not in combat
if (behaviour leader _old_group != "COMBAT") then
{
	// set formation
	_old_group setBehaviour "AWARE";
	_units apply {_x setUnitPos "MIDDLE"};
	if (formation _old_group != "LINE") then
	{
		_old_group setFormation "LINE";
		// wait until unit is in formation
		sleep 2;
		waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _units == 0};
	};
	// orientate line perpendicular to target
	_old_group setFormDir ([leader _old_group,_selectedTarget] call BIS_fnc_dirTo);
	// wait until unit is in formation
	sleep 2;
	waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _units == 0};
	_units apply {_x setUnitPos "AUTO"};
};

// get rid of vehicle crew except gunner
_units = _units select {gunner vehicle _x == _x};

// store original group in place holder
_placeholder = _old_group createUnit ["B_Story_Protagonist_F", [0,0,0], [], 0, "NONE"];
_placeholder setPos [0,0,0];

{
	[_x, _units, _selectedTarget, _stanceIndex, _fireModeIndex, _duration, _placeholder] spawn 
	{
		_unit = gunner (_this select 0);
		_units = _this select 1;
		_target = _this select 2;
		_stanceIndex = _this select 3;
		_fireModeIndex = _this select 4;
		_duration = _this select 5;
		_placeholder = _this select 6;
		
		// cease fire if group mate is too close to line of fire
		if (not ([_unit, _target, _units - [_unit], 2] call Achilles_fnc_checkLineOfFire2D)) exitWith {};
		
		_old_group = group _placeholder;
		_aiming = _unit skill "aimingAccuracy";
		_unit setSkill ["aimingAccuracy", 0.2];
		_unit setUnitPos (["DOWN","MIDDLE","UP"] select _stanceIndex);
		
		// get fire mode parameters
		_params = [[10,0],[3,0.7],[1,0.9]] select _fireModeIndex;
		_fireRepeater = _params select 0;
		_ceaseFireTime = _params select 1;
		
		_new_group = createGroup (side _unit);
		[_unit] join _new_group;
		_new_group setBehaviour "COMBAT";
		
		_unit doTarget _target;
		
		//ensure asynchronous fire within a group
		sleep (random [2,3,4]);
		
		if ((vehicle _unit) isEqualTo _unit) then
		{
			_muzzle = (weaponState _unit) select 1;
			_mode = weaponState _unit select 2;
			for "_" from 1 to _duration do
			{
				for "_" from 1 to _fireRepeater do
				{
					sleep 0.1;
					_unit forceWeaponFire [_muzzle, _mode];
					_unit setvehicleammo 1;
				};
				_unit doTarget _target;
				sleep _ceaseFireTime;
			};
		} else
		{
			_vehicle = vehicle _unit;
			if (_unit == gunner _vehicle) then 
			{
				_turrets_path = (assignedVehicleRole _unit) select 1;		
				_muzzle = weaponState [_vehicle, _turrets_path] select 1;
				for "_" from 0 to _duration do
				{
					for "_" from 1 to _fireRepeater do
					{
						_unit lookAt _target;
						sleep 0.1;
						_unit fireAtTarget [_vehicle, _muzzle];
						_vehicle setvehicleammo 1;
					};
					sleep _ceaseFireTime;
				};
			};
		};
		_unit setSkill ["aimingAccuracy", _aiming];
		_unit setUnitPos "AUTO";
		_units joinSilent _old_group;
		_old_group setBehaviour "AWARE";
		deleteVehicle _placeholder;
	};
} forEach _units;

//clean up
sleep _duration;
[] spawn {{if (count units _x==0) then {deleteGroup _x}} forEach allGroups};
#include "\achilles\modules_f_ares\module_footer.hpp"
