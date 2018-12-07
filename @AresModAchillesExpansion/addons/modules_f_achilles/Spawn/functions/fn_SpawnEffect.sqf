#include "\achilles\modules_f_ares\module_header.inc.sqf"

#define EFFECT_MODULES 		["ModuleFlare_F","ModuleSmoke_F","ModuleIRGrenade_F","ModuleChemlight_F","ModuleLightSource_F","ModulePersistentSmokePillar_F", "ModuleTracers_F"]
#define NO_CHOICE_MODULES	["ModuleIRGrenade_F","ModuleTracers_F"]

private _spawnPos = position _logic;

private _category_names = EFFECT_MODULES apply {getText (configfile >> "CfgVehicles" >> _x >> "displayName")};
_category_names pushBack (localize "STR_AMAE_EFFECTS_CUSTOM_FIRE");

_dialogResult =
[
	localize "STR_AMAE_SPAWN_EFFECT",
	[
		[localize "STR_AMAE_CATEGORY", _category_names],
		[localize "STR_AMAE_TYPE", [""]]
	],
	"Achilles_fnc_RscDisplayAtttributes_SpawnEffect"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

// If the module picked is the Custom Fire module
if ((_dialogResult select 0) == 7) exitWith {[_logic] call Achilles_fnc_moduleEffectsFire; _deleteModuleOnExit = false};
private _module_category = EFFECT_MODULES select (_dialogResult select 0);

private _module_type = if (_module_category in NO_CHOICE_MODULES) then
{
	_module_category;
} else
{
	_modules = (configfile >> "CfgVehicles" >> _module_category) call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
	_modules select (_dialogResult select 1);
};

private _group = group _logic;
private _effect_logic = _group createUnit [_module_type, _spawnPos, [], 0, "NONE"];
_effect_logic setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];
_effect_logic setPos _spawnPos;
[[_effect_logic]] call Ares_fnc_AddUnitsToCurator;

_logic setVariable ["effect_class",_module_type];

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
