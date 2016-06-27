#include "\ares_zeusExtensions\Ares\module_header.hpp"

// find target position
_target_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
_target_pos = position _logic;
_target_pos = if (isNull _target_unit) then {_target_pos} else {position _target_unit};

// get fire support group
_unit = ["group",true] call Achilles_fnc_SelectUnits;
if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {["No group selected!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

_old_group = group _unit;
_units = units _old_group;

// store original group in place holder
[] spawn {{if (count units _x==0) then {deleteGroup _x}} forEach allGroups};
_placeholder = _old_group createUnit ["B_Story_Protagonist_F", [0,0,0], [], 0, "NONE"];
_placeholder setPos [0,0,0];

// Old version: search enemy ///////////////////
/*
_targets = _target_pos nearEntities [["Man","Car"], 20];
_possible_targets = [_targets ,[],{(_unit targetKnowledge _x) select 0}, "DESCEND", {((side _x) getFriend (side _unit)) < 0.6} ] call BIS_fnc_sortBy;
if (count _possible_targets == 0) then {_possible_targets=[_logic]};
*/
////////////////////////////////////////////////

// new version: target logic ///////////////////
_target=_logic;
////////////////////////////////////////////////

{
	// Old version: assign enemies ///////////////////
	/*
	_n = floor ((_forEachIndex) / (count _possible_targets));
	_target = _possible_targets select (_forEachIndex - _n * (count _possible_targets));
	diag_log str [_forEachIndex,_n, (_forEachIndex - _n * (count _possible_targets))];
	*/
	////////////////////////////////////////////////
	
	[_x, _units , _target, _placeholder] spawn 
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
			hint str _muzzle;
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
