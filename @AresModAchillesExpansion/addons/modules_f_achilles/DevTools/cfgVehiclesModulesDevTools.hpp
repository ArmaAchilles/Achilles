class Achilles_Dev_Tools_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_DEV_TOOLS";
	Category = "DevTools";
}

class Achilles_Bind_Variable_Module : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Bind_Variable_Module";
	displayName = "$STR_BIND_VAR";
	function = "Achilles_fnc_DevToolsBindVariable";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Achilles_Module_Manage_Advanced_Compositions : Achilles_Dev_Tools_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADVANCED_COMPOSITION";
	function = "Achilles_fnc_DevTools_manageAdvancedCompositions";
};
