/*
	Author: Kex, CreepPork_LV

	Description:
		Makes units throw a frag grenade.

	Parameters:
		_this select 0: OBJECT - The unit to throw the frag grenade.

	Returns:
		Nothing
*/

// Temporary list of grenades that are not frag grenades (see http://feedback.rhsmods.org/view.php?id=4485).
#define BLACKLIST_GRENADES ["rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_m18_yellow", "rhs_mag_m18_smoke_base"]

params[["_unit", objNull, [objNull]]];

private _allFragMagazines =
[
	magazinesAmmoFull _unit,
	[],
	{_x select 0},
	"ASCEND",
	{
		((getText (configfile >> "CfgMagazines" >> (_x select 0) >> "nameSound")) == "handgrenade") && !((_x select 0) in BLACKLIST_GRENADES) && (_x select 2) 
	}
] call BIS_fnc_sortBy;

if (_allFragMagazines isEqualTo []) exitWith {[format [localize "STR_AMAE_FRAG_GRENADES_UNAVAILABLE", name _unit]] call Achilles_fnc_showZeusErrorMessage};

private _fragMuzzle = (_allFragMagazines select 0) select 4;
[_unit, _fragMuzzle] call BIS_fnc_fire;
