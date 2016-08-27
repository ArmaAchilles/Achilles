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
if (count _allTargets == 3) exitWith {[localize "STR_NO_TARGET_AVAIABLE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

// select target
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

// get target logic
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

// store original group in place holder
[] spawn {{if (count units _x==0) then {deleteGroup _x}} forEach allGroups};
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
		
		
		_unit lookAt _target;
		sleep (random [2,3,4]);
		
		if ((vehicle _unit) isEqualTo _unit) then
		{
			_muzzle = (weaponState _unit) select 1;
			//hint str _muzzle;
			_mode = weaponState _unit select 2;
			for "_" from 1 to _duration do
			{
				for "_" from 1 to _fireRepeater do
				{
					_unit doTarget _target;
					sleep 0.1;
					_unit forceWeaponFire [_muzzle, _mode];
					_unit setvehicleammo 1;
				};
				sleep _ceaseFireTime;
			};
		} else
		{
			_vehicle = vehicle _unit;
			if (_unit == gunner _vehicle) then 
			{
				_turrets_path = (assignedVehicleRole _unit) select 1;		
				_muzzle = weaponState [_vehicle, _turrets_path] select 1;
				systemChat str [_turrets_path,_muzzle];
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
		deleteVehicle _placeholder;
	};
} forEach _units;
sleep 15;

#include "\achilles\modules_f_ares\module_footer.hpp"
