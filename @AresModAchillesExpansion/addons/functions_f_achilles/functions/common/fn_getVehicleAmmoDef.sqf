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

// get current state of all magazines
private _currentMagazines = magazinesAllTurrets _vehicle;

private _allAmmoPercentages = [];
private _magazineConfig = configFile >> "CfgMagazines";

// Calculate the remaining ammo percentage for each magazine.
{
    _x params ["_name", "", "_ammo"];
    private _magMaxAmmo = getNumber (_magazineConfig >> _name >> "count");
    _allAmmoPercentages pushBack (_ammo / _magMaxAmmo);
} forEach _currentMagazines;

// return the overall mean of all percentages
if (!(_allAmmoPercentages isEqualTo [])) exitWith
{
	_allAmmoPercentages call BIS_fnc_arithmeticMean
};
0
