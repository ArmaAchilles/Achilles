////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\fn_getVehicleAmmoDef.sqf
//  DESCRIPTION: estimate for inverse function of setVehicleAmmoDef command (not very accurate)
//
//	ARGUMENTS:
//	_this:				OBJECT	- vehicle for which the ammo is counted
//
//	RETURNS:
//	_this:				SCALAR	- number between 0 and 1 corresponding to the relative ammo count
//
//	Example:
//	_vehicle call Achilles_fnc_getVehicleAmmoDef;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_vehicle = _this;

// get current state of all turret magazines
_AllTurretCurrentMagazinesClassName = [];
_AllTurretCurrentMagazinesAmmoCount = [];
{
	_AllTurretCurrentMagazinesClassName pushBack (_x select 0);
	_AllTurretCurrentMagazinesAmmoCount pushBack (_x select 2);
} forEach (magazinesAllTurrets _vehicle);

_turretsCfg = [typeOf _vehicle] call Achilles_fnc_getAllTurretConfig;

// append config path for driver magazines
_turretsCfg pushBack (configFile >> "CfgVehicles" >> typeOf _vehicle);

_AllTurretAmmoPercentages = [];

// get ammo percentages for all turrets
{
	_TurretAmmoPercentages = [];
	_cfgTurret = _x;
	_MagazinesClassName = getArray (_cfgTurret >> "magazines");
	{
		// compare magazine count from config with current count
		_CfgAmmoCount = getNumber (configFile >> "CfgMagazines" >> _x >> "count");
		_index = _AllTurretCurrentMagazinesClassName find _x;
		if (_index != -1) then
		{
			_TurretAmmoPercentages pushBack ((_AllTurretCurrentMagazinesAmmoCount select _index) / _CfgAmmoCount);
			
			// remove the counted magazine from the list
			_AllTurretCurrentMagazinesClassName deleteAt _index;
			_AllTurretCurrentMagazinesAmmoCount deleteAt _index;
		} else
		{
			_TurretAmmoPercentages pushBack 0;
		};
	} forEach _MagazinesClassName;

	if (count _TurretAmmoPercentages != 0) then
	{
		_AllTurretAmmoPercentages pushBack (_TurretAmmoPercentages call Achilles_fnc_arrayMean);
	};
	
} forEach _turretsCfg;

// return the overall mean of all percentages
if (count _AllTurretAmmoPercentages != 0) then
{
	(_AllTurretAmmoPercentages call Achilles_fnc_arrayMean);
} else
{
	0;
};