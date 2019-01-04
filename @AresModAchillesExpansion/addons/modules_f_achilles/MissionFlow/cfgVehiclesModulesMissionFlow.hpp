class Achilles_Mission_Flow_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_OBJECTS";
	Category = "MissionFlow";
};

class Achilles_Module_Spawn_Intel : Achilles_Mission_Flow_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_CREATE_EDIT_INTEL";
	function = "Achilles_fnc_SpawnCreateEditIntel";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};

class Achilles_Module_Change_Side_Relations : Achilles_Mission_Flow_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_CHANGE_SIDE_RELATIONS";
	function = "Achilles_fnc_changeSideRelations";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};