////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\fn_setUnitAmmoDef.sqf
//  DESCRIPTION: set vehicle's magazine count based on given percentage
//				 In contrast to setUnitAmmoDef, it can handle custom dynamic loadouts
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- vehicle for which the ammo is changed
//	_this select 1:		SCALAR	- ammo value in range [0,1]
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_vehicle, 0.9] call Achilles_fnc_setVehicleAmmoDef;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_vehicle",["_percentage",1,[1]]];

_pylonMags = getPylonMagazines _vehicle;

//Changing Pylon Loadouts and calling setVehicleAmmoDef can cause problems.
if (_pylonMags isEqualTo []) then {_vehicle setVehicleAmmoDef _percentage} else {_vehicle setVehicleAmmo _percentage};

{
	private _cfg_ammoCount = getNumber (configfile >> "CfgMagazines" >> _x >> "count");
	_addWeaponsTo = if (not isNull gunner _vehicle) then
	{
		_vehicle getVariable ["Achilles_var_changePylonAmmo_Assigned", [0]];
	} else {[]};
	_vehicle setPylonLoadOut [_forEachIndex + 1, _x, false, _addWeaponsTo];
	_vehicle setAmmoOnPylon [_forEachIndex + 1, round (_cfg_ammoCount * _percentage)];
} forEach _pylonMags;
