/*
	Function:
		Destroy building module function
	Authors:
		Kex
*/
#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _centerPos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_DAMAGE_BUILDINGS",
	[
		[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_NEAREST", localize "STR_AMAE_RANGE_NO_SI"]],
		[localize "STR_AMAE_MEAN_DAMAGE", [localize "STR_AMAE_NO_DAMAGE", localize "STR_AMAE_LIGHT_DAMAGE", localize "STR_AMAE_SEVERE_DAMAGE", localize "STR_AMAE_FULL_DAMAGE"], 2],
		[localize "STR_AMAE_DISTRIBUTION", [localize "STR_AMAE_DELTA_DISTRIBUTION", localize "STR_AMAE_UNIFORM", localize "STR_AMAE_NORMAL_DISTRIBUTION"]],
		[localize "STR_AMAE_RANGE", "", "100"],
		[localize "STR_AMAE_DISABLE_DESTRUCTION_EFFECT", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1]
	],
	"Achilles_fnc_RscDisplayAttributes_BuildingsDestroy"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_selectionMode",
	"_meanMode",
	"_distMode",
	"_selectionRange",
	"_doSimulate"
];

_selectionRange = parseNumber _selectionRange;
_doSimulate = _doSimulate isEqualTo 1;

private _buildings = [];
switch (_selectionMode) do
{
	case 0:
	{
		_buildings = nearestObjects [_centerPos, ["Building"], 50, true];
		_buildings resize 1;
	};
	case 1:
	{
		_buildings = nearestObjects [_centerPos, ["Building"], _selectionRange, true];
	};
};

[_buildings, _meanMode, _distMode, _doSimulate] call Achilles_fnc_damageBuildings;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
