////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Buildings\fn_BuildingsDestroy.sqf
//  DESCRIPTION: Function for destroing buildings
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_buildings","_damage_fnc","_mean_damage"];

_center_pos = position _logic;

_dialogResult = 
[
	localize "STR_DAMAGE_BUILDINGS",
	[
		[localize "STR_SELECTION", [localize "STR_NEAREST", localize "STR_RANGE"]],
		[localize "STR_MEAN_DAMAGE",[localize "STR_NO_DAMAGE",localize "STR_LIGHT_INJURY",localize "STR_SEVERE",localize "STR_FULL_DAMAGE"],2],
		[localize "STR_DISTRIBUTION",[localize "STR_DELTA",localize "STR_UNIFORM", localize "STR_NORMAL_DISTRIBUTION"]],
		[(localize "STR_RANGE") + " [m]","","100"]
	],
	"Achilles_fnc_RscDisplayAttributes_BuildingsDestroy"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

switch (_dialogResult select 0) do
{
	case 0:	
	{
		_buildings = nearestObjects [_center_pos, ["Building"], 50];
		_buildings resize 1;
	};
	case 1: 
	{
		_buildings = nearestObjects [_center_pos, ["Building"], parseNumber (_dialogResult select 3)];
	};
};

_mean_damage_type = _dialogResult select 1;
_distribution_type = _dialogResult select 2;

//Broadcast damage function to server
if (isNil "Achilles_var_damageBuildings_init_done") then
{
	publicVariableServer "Achilles_fnc_damageBuildings";
	Achilles_var_damageBuildings_init_done = true;
};

[_buildings,_mean_damage_type,_distribution_type] remoteExec ["Achilles_fnc_damageBuildings",2];


#include "\achilles\modules_f_ares\module_footer.hpp"
