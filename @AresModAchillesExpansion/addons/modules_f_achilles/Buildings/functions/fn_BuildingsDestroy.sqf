////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Buildings\fn_BuildingsDestroy.sqf
//  DESCRIPTION: Function for destroing buildings
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _center_pos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_DAMAGE_BUILDINGS",
	[
		[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_NEAREST", localize "STR_AMAE_RANGE_NO_SI"]],
		[localize "STR_AMAE_MEAN_DAMAGE",[localize "STR_AMAE_NO_DAMAGE",localize "STR_AMAE_LIGHT_DAMAGE",localize "STR_AMAE_SEVERE_DAMAGE",localize "STR_AMAE_FULL_DAMAGE"],2],
		[localize "STR_AMAE_DISTRIBUTION",[localize "STR_AMAE_DELTA_DISTRIBUTION",localize "STR_AMAE_UNIFORM", localize "STR_AMAE_NORMAL_DISTRIBUTION"]],
		[localize "STR_AMAE_RANGE","","100"]
	],
	"Achilles_fnc_RscDisplayAttributes_BuildingsDestroy"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

private _buildings = [];
switch (_dialogResult select 0) do
{
	case 0:
	{
		_buildings = nearestObjects [_center_pos, ["Building"], 50, true];
		_buildings resize 1;
	};
	case 1:
	{
		_buildings = nearestObjects [_center_pos, ["Building"], parseNumber (_dialogResult select 3), true];
	};
};

private _mean_damage_type = _dialogResult select 1;
private _distribution_type = _dialogResult select 2;

[_buildings,_mean_damage_type,_distribution_type] call Achilles_fnc_damageBuildings;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
