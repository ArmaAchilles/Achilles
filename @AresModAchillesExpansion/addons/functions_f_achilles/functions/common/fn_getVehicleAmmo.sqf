/*
	Authors:
    	NeilZar

	Description:
    	Calculate the amount of ammo left relative to the full loadout. (Includes empty magazines and allows altering the loadout)

	Parameters:
		_this:	OBJECT - Vehicle for which the ammo is counted

	Returns:
		_this:	SCALAR	- number between 0 and 1 corresponding to the relative ammo count

	Examples:
    	(begin example)
		_vehicle call Achilles_fnc_getVehicleAmmoDef;
        (end)
*/
private _vehicle = _this;

// Get current state of all magazines
private _currentMagazines = magazinesAllTurrets _vehicle;

private _allAmmoPercentages = [];
private _magazineConfig = configFile >> "CfgMagazines";

// Calculate the remaining ammo percentage for each magazine.
{
    _x params ["_name", "", "_ammo"];
    private _magMaxAmmo = getNumber (_magazineConfig >> _name >> "count");
    _allAmmoPercentages pushBack (_ammo / _magMaxAmmo);
} forEach _currentMagazines;

// Return the overall mean of all percentages
if (!(_allAmmoPercentages isEqualTo [])) exitWith
{
	_allAmmoPercentages call BIS_fnc_arithmeticMean
};
0
