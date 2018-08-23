/*
	Author: Kex, CreepPork_LV

	Description:
		Makes units throw a smoke grenade.

	Parameters:
		_this select 0: OBJECT - The unit to throw the smoke grenade.

	Returns:
		Nothing
*/

params[["_unit", objNull, [objNull]]];

// Get all of our smokes in the inventory
private _allSmokeMagazines =
[
	magazinesAmmoFull _unit,
	[],
	{_x select 0},
	"ASCEND",
	{
		((getText (configfile >> "CfgMagazines" >> (_x select 0) >> "nameSound")) == "smokeshell") && (_x select 2)
	}
] call BIS_fnc_sortBy;

// Display different messages if the unit doesn't have any smokes
if (_allSmokeMagazines isEqualTo []) exitWith {[format [localize "STR_AMAE_SMOKE_GRENADES_UNAVAILABLE", name _unit]] call Achilles_fnc_showZeusErrorMessage};

// Make the unit throw the smoke grenade
private _smokeMuzzle = (_allSmokeMagazines select 0) select 4;
[_unit, _smokeMuzzle] call BIS_fnc_fire;