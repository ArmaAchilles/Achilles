////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/15/17
//	VERSION: 2.0
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


private _vehicle = _this;
private _vehicleType = typeOf _vehicle;

// get current state of all turret magazines
private _AllTurretCurrentMagazinesClassName = [];
private _AllTurretCurrentMagazinesAmmoCount = [];
{
	_AllTurretCurrentMagazinesClassName pushBack (_x select 0);
	_AllTurretCurrentMagazinesAmmoCount pushBack (_x select 2);
} forEach (magazinesAllTurrets _vehicle);

private _turretsCfg = [_vehicleType] call Achilles_fnc_getAllTurretConfig;

// append config path for driver magazines
_turretsCfg pushBack (configFile >> "CfgVehicles" >> _vehicleType);

private _AllTurretAmmoPercentages = [];

// get ammo percentages for all turrets
{
	private _TurretAmmoPercentages = [];
	private _cfgTurret = _x;
	private _MagazinesClassName = getArray (_cfgTurret >> "magazines");
	{
		// compare magazine count from config with current count
		private _CfgAmmoCount = getNumber (configFile >> "CfgMagazines" >> _x >> "count");
		private _index = _AllTurretCurrentMagazinesClassName find _x;
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

// handle dynamic loadout
if (isClass (configFile >> "cfgVehicles" >> _vehicleType >> "Components" >> "TransportPylonsComponent")) then
{
	private _TurretAmmoPercentages = [];
	{
		if (_x != "") then
		{
			private _current_ammoCount = _vehicle ammoOnPylon (_forEachIndex + 1);
			if (typeName _current_ammoCount == "BOOL") then
			{
				if (_current_ammoCount) then {_TurretAmmoPercentages pushBack 1} else {_TurretAmmoPercentages pushBack 0};
			} else
			{
				private _cfg_ammoCount = getNumber (configfile >> "CfgMagazines" >> _x >> "count");
				if (_cfg_ammoCount == 0) then {_TurretAmmoPercentages pushBack 1} else {_TurretAmmoPercentages pushBack (_current_ammoCount / _cfg_ammoCount)};
			};
		};
	} forEach (getPylonMagazines _vehicle);
	_AllTurretAmmoPercentages pushBack (_TurretAmmoPercentages call Achilles_fnc_arrayMean);
};


// return the overall mean of all percentages
if (count _AllTurretAmmoPercentages != 0) then
{
	(_AllTurretAmmoPercentages call Achilles_fnc_arrayMean);
} else
{
	0;
};