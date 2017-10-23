////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\fn_getAllTurretConfig.sqf
//  DESCRIPTION: inverse function of setVehicleAmmoDef command
//
//	ARGUMENTS:
//	_this:				OBJECT	- vehicle
//
//	RETURNS:
//	_this:				ARRAY	- array of vehicle turret configs
//
//	Example:
//	_vehicle call Achilles_fnc_getAllTurretConfig;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_parent_turret_path", "_cfgTurrets", "_output"];

if (count _this > 1) then 
{
	_parent_turret_path = _this select 1;
	_cfgTurrets = _this select 0;
} else
{
	private _vehicleType = _this select 0;
	_parent_turret_path = [];
	_cfgTurrets = configFile >> "CfgVehicles" >> _vehicleType >> "Turrets";
};

private _cfgTurrets_list = [_cfgTurrets, 0, true] call BIS_fnc_returnChildren;

_output = [];
{
	private _current_cfgTurret = _x;
	private _turret_path = _parent_turret_path + [_forEachIndex];
	_output pushBack _current_cfgTurret;
	private _cfgTurrets_children = _current_cfgTurret >> "Turrets";
	if (isClass _cfgTurrets_children) then
	{
		_output append ([_cfgTurrets_children, _turret_path] call Achilles_fnc_getAllTurretConfig);
	};
} forEach _cfgTurrets_list;
_output;