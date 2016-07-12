#include "\ares_zeusExtensions\Ares\module_header.hpp"

// find unit to perform suppressiove fire
_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// get list of possible targest
_allTargetsUnsorted = allMissionObjects "Achilles_Module_Fire_Support_Create_Suppression_Target";
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
		[format [localize "STR_SUPPRESS_X", " "], _targetChoices]
	]
] call Ares_fnc_ShowChooseDialog;
if (count _dialogResult == 0) exitWith {};

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
	[_x, _units , _selectedTarget, _placeholder] spawn 
	{
		_unit = gunner (_this select 0);
		_units = _this select 1;
		_target = _this select 2;
		_placeholder = _this select 3;
		_old_group = group _placeholder;
		_aiming = _unit skill "aimingAccuracy";
		_unit setSkill ["aimingAccuracy", 0.2];
		_unit setUnitPos "DOWN";
		
		_new_group = createGroup (side _unit);
		[_unit] join _new_group;
		_new_group setBehaviour "COMBAT";
		
		_unit lookAt _target;
		sleep 3;
		
		if ((vehicle _unit) isEqualTo _unit) then
		{
			_muzzle = (weaponState _unit) select 1;
			//hint str _muzzle;
			_mode = weaponState _unit select 2;
			for "_i" from 0 to 100 step 1 do
			{
				_unit doTarget _target;
				sleep 0.1;
				_unit forceWeaponFire [_muzzle, _mode];
				_unit setvehicleammo 1;
			};
		} else
		{
			_vehicle = vehicle _unit;
			if (_unit == gunner _vehicle) then 
			{
				_turrets_path = (assignedVehicleRole _unit) select 1;		
				_muzzle = weaponState [_vehicle, _turrets_path] select 1;
				systemChat str [_turrets_path,_muzzle];
				for "_i" from 0 to 100 step 1 do
				{
					_unit lookAt _target;
					sleep 0.1;
					_unit fireAtTarget [_vehicle, _muzzle];
					_vehicle setvehicleammo 1;
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

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
