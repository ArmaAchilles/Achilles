class Achilles_Mission_Flow_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_OBJECTS";
	Category = "MissionFlow";
};

class Achilles_Module_Spawn_Intel : Achilles_Mission_Flow_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_EDIT_INTEL";
	function = "Achilles_fnc_SpawnCreateEditIntel";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};