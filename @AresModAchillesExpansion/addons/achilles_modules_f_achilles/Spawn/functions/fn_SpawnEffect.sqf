#include "\achilles\modules_f_ares\module_header.hpp"

#define EFFECT_MODULES 		["ModuleFlare_F","ModuleSmoke_F","ModuleIRGrenade_F","ModuleChemlight_F","ModuleLightSource_F","ModulePersistentSmokePillar_F","ModuleTracers_F"]
#define NO_CHOICE_MODULES	["ModuleIRGrenade_F","ModuleTracers_F"]

_spawnPos = position _logic;

_category_names = EFFECT_MODULES apply {getText (configfile >> "CfgVehicles" >> _x >> "displayName")};

_dialogResult = 
[
	localize "STR_SPAWN_EFFECT",
	[
		[localize "STR_CATEGORY", _category_names],
		[localize "STR_TYPE", ["..."]]
	],
	"Achilles_fnc_RscDisplayAtttributes_SpawnEffect"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};


_module_category = EFFECT_MODULES select (_dialogResult select 0);

_module_type = if (_module_category in NO_CHOICE_MODULES) then
{
	_module_category;
} else
{
	_modules = (configfile >> "CfgVehicles" >> _module_category) call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
	_modules select (_dialogResult select 1);
};

_group = group _logic;
_effect_logic = _group createUnit [_module_type, _spawnPos, [], 0, "NONE"];
_effect_logic setPos _spawnPos;
[[_effect_logic]] call Ares_fnc_AddUnitsToCurator;

_logic setVariable ["effect_class",_module_type];

#include "\achilles\modules_f_ares\module_footer.hpp"
