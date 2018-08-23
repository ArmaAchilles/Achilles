////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_LV
//	DATE: 10/11/2017
//	VERSION: 2.0
//	FILE: Achilles\functions\events\fn_LaunchCM.sqf
//  DESCRIPTION: function that forces vehicles to lauch countermeasures (CM).
//
//	ARGUMENTS:
//	_this select 0: - ARRAY of OBJECTs - Vehicles that launches the CM.
//  _this select 1: - ARRAY of SCALARs - [number of deployments, delay]; for flares only; default [6, 0.1].
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_vehicle] call Achilles_fnc_LaunchCM;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ALL_SL_WEAP_CLASSES ["SmokeLauncher","rhs_weap_smokegen","rhs_weap_902a","rhs_weap_902b","rhsusf_weap_M259"]
#define ALL_CM_WEAP_CLASSES ["CMFlareLauncher", "CMFlareLauncher_Singles", "CMFlareLauncher_Triples", "rhs_weap_CMFlareLauncher","rhsusf_weap_CMFlareLauncher"]

params[["_vehicle", objNull, [objNull]], ["_flareParams", [6, 0.1], [[]], 2]];

private _isVehicleAir = _vehicle isKindOf "Air";
private _smokeType = ["smokeshell", "magazine"] select _isVehicleAir;
private _weaponClasses = [ALL_SL_WEAP_CLASSES, ALL_CM_WEAP_CLASSES] select _isVehicleAir;

// Get all smokes and countermeasures from a vehicle's inventory
private _allSmokeMagazines =
[
	magazinesAllTurrets _vehicle,
	[],
	{_x select 0},
	"ASCEND",
	{((getText (configfile >> "CfgMagazines" >> (_x select 0) >> "nameSound")) == _smokeType) && ((_x select 2) > 0)}
] call BIS_fnc_sortBy;

if (_allSmokeMagazines isEqualTo [] && !_isVehicleAir) exitWith {[format ["Smoke dispensers unavailable for %1!", name _vehicle]] call Achilles_fnc_showZeusErrorMessage};
if (_allSmokeMagazines isEqualTo [] && _isVehicleAir) exitWith {[format ["Countermeasures unavailable for %1!", name _vehicle]] call Achilles_fnc_showZeusErrorMessage};

private _turretPath = (_allSmokeMagazines select 0) select 1;
private _weapons = _vehicle weaponsTurret _turretPath;
private _CMWeapons = _weapons arrayIntersect _weaponClasses;
private _CMWeapon = _CMWeapons select 0;

// If the vehicle is any kind of land vehicle (cars, tanks, trucks etc.)
if (_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Ship") then
{
	[_vehicle, _CMWeapon] call BIS_fnc_fire;
};

// If the vehicle is an aircraft
if (_isVehicleAir) then
{
	[_vehicle,_CMWeapon, _flareParams] spawn
	{
		params["_vehicle", "_CMWeapon", "_flareParams"];
		_flareParams params ["_flareCounts", "_delay"];
		for "_i" from 0 to _flareCounts do
		{
			[_vehicle, _CMWeapon] call BIS_fnc_fire;
			sleep _delay;
		};
	};
};