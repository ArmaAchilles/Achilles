class Achilles_Dev_Tools_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_DEV_TOOLS";
	Category = "Achilles_fac_DevTools";
}

class Achilles_Bind_Variable_Module : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Bind_Variable_Module";
	displayName = "$STR_AMAE_BIND_VAR";
	function = "Achilles_fnc_DevToolsBindVariable";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Achilles_Module_Manage_Advanced_Compositions : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ADVANCED_COMPOSITION";
	function = "Achilles_fnc_DevTools_manageAdvancedCompositions";
};

class Achilles_DevTools_ShowInAnimViewer : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_DevTools_ShowInAnimViewer";
	displayName = "$STR_AMAE_SHOW_IN_ANIM_VIEWER";
	function = "Achilles_fnc_DevToolsShowInAnimViewer";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_DevTools_ShowInConfig : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_DevTools_ShowInConfig";
	displayName = "$STR_AMAE_SHOW_IN_CONFIG";
	function = "Achilles_fnc_DevToolsShowInConfig";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};

class Achilles_DevTools_FunctionViewer : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_DevTools_ShowInConfig";
	displayName = "$STR_AMAE_FUNCTION_VIEWER";
	function = "Achilles_fnc_DevToolsFunctionViewer";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

class Achilles_DevTools_CopyFurnitureToClipboard : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_DevTools_CopyFurnitureToClipboard";
	displayName = "$STR_AMAE_COPY_FURNITURE_TO_CLIPBOARD";
	function = "Achilles_fnc_DevToolsCopyFurnitureToClipboard";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

class Achilles_DevTools_SpawnFurnishedBuildingFromClipboard : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_DevTools_SpawnFurnishedBuildingFromClipboard";
	displayName = "$STR_AMAE_SPAWN_FURNISHED_BUILDINGS_FROM_CLIPBOARD";
	function = "Achilles_fnc_DevToolsSpawnFurnishedBuildingFromClipboard";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};