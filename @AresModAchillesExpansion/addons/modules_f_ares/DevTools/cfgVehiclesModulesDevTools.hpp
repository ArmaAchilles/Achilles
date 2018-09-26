class Ares_Dev_Tools_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_AMAE_DEV_TOOLS";
	Category = "Achilles_fac_DevTools";
};

class Ares_Module_Dev_Tools_Execute_Code : Ares_Dev_Tools_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_EXECUTE_CODE";
	function = "Ares_fnc_ExecuteCode";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Ares_Module_Dev_Tools_Create_Mission_SQF : Ares_Dev_Tools_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_COPY_MISSION_SQF";
	function = "Ares_fnc_CreateMissionSQF";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";
};
