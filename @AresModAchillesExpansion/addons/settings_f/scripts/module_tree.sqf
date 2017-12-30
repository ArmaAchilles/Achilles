/**
 *
 */
[
    "Achilles_var_moduleTreeHelmet",
    "CHECKBOX",
    localize "STR_AMAE_MODULE_ICONS_HELMET",
    localize "STR_AMAE_MODULE_INTERFACE",
    false,
	false,
	{Achilles_var_reloadDisplay = true}	
] call cba_settings_fnc_init;

[
    "Achilles_var_moduleTreeDLC",
    "CHECKBOX",
    localize "STR_AMAE_MODULE_ICONS_DLC",
    localize "STR_AMAE_MODULE_INTERFACE",
    true,
	false,
	{Achilles_var_reloadDisplay = true}	
] call cba_settings_fnc_init;

[
    "Achilles_var_moduleTreeCollapse",
    "CHECKBOX",
    localize "STR_AMAE_COLLAPSE_TREE_BY_DEFAULT",
    localize "STR_AMAE_MODULE_INTERFACE",
    true,
	false,
	{Achilles_var_reloadDisplay = true}	
] call cba_settings_fnc_init;