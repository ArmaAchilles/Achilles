[
	"Achilles_var_iconSelection",
	"LIST",
	localize "STR_AMAE_SETTINGS_ICON_SELECTION",
	[format ["%1 - %2", localize "STR_AMAE_ACHILLES", localize "STR_AMAE_USER_INTERFACE"], localize "STR_AMAE_WHEN_INTERFACE_IS_HIDDEN"],
	[["Achilles_var_iconSelection_Ares", "Achilles_var_iconSelection_Achilles", "Achilles_var_iconSelection_Enyo", "Achilles_var_iconSelection_Default"], ["Ares", "Achilles", "Enyo", localize "STR_AMAE_DEFAULT"], 0],
	false,
	{Achilles_var_reloadDisplay = true}
] call cba_settings_fnc_init;

[
	"Achilles_var_moduleTreeHelmet",
	"CHECKBOX",
	localize "STR_AMAE_MODULE_ICONS_HELMET",
	[format ["%1 - %2", localize "STR_AMAE_ACHILLES", localize "STR_AMAE_USER_INTERFACE"], localize "STR_AMAE_CREATION_PANEL"],
	false,
	false,
	{Achilles_var_reloadDisplay = true}
] call cba_settings_fnc_init;

[
    "Achilles_var_moduleTreeDLC",
    "CHECKBOX",
    localize "STR_AMAE_MODULE_ICONS_DLC",
    [format ["%1 - %2", localize "STR_AMAE_ACHILLES", localize "STR_AMAE_USER_INTERFACE"], localize "STR_AMAE_CREATION_PANEL"],
    true,
	false,
	{Achilles_var_reloadDisplay = true}
] call cba_settings_fnc_init;

[
    "Achilles_var_moduleTreeCollapse",
    "CHECKBOX",
    localize "STR_AMAE_COLLAPSE_TREE_BY_DEFAULT",
    [format ["%1 - %2", localize "STR_AMAE_ACHILLES", localize "STR_AMAE_USER_INTERFACE"], localize "STR_AMAE_CREATION_PANEL"],
    true,
	false,
	{Achilles_var_reloadDisplay = true}
] call cba_settings_fnc_init;

[
    "Achilles_var_moduleTreeSearchPatch",
    "CHECKBOX",
    localize "STR_AMAE_ENABLE_DZN_SEARCH_PATCH",
    [format ["%1 - %2", localize "STR_AMAE_ACHILLES", localize "STR_AMAE_USER_INTERFACE"], localize "STR_AMAE_SEARCH_BOX"],
    false,
	false,
	{Achilles_var_reloadDisplay = true}
] call cba_settings_fnc_init;