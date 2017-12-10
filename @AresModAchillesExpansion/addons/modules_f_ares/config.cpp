class CfgPatches
{
	class achilles_modules_f_ares
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Anton Struyk";
		authorUrl = "https://github.com/astruyk/";
		version = 1.8.1;
		versionStr = "1.8.1";
		versionAr[] = {1,8,1};
		
		units[] =
		{
			// "Ares_Module_Arsenal_AddFull",
			"Ares_Module_Arsenal_AddCustom",
			"Ares_Module_Arsenal_Copy_To_Clipboard",
			"Ares_Module_Arsenal_Paste_Replace",
			"Ares_Module_Arsenal_Paste_Combine",
			"Ares_Module_Arsenal_Create_Nato",
			"Ares_Module_Arsenal_Create_Csat",
			"Ares_Module_Arsenal_Create_Aaf",
			"Ares_Module_Arsenal_Create_Guerilla",
			"Ares_Module_Behaviour_Patrol",
			"Ares_Module_Behaviour_Search_Nearby_And_Garrison",
			"Ares_Module_Behaviour_Search_Nearby_Building",
			"Ares_Module_Bahaviour_SurrenderUnit",
			"Ares_Module_Bahaviour_Garrison_Nearest",
			"Ares_Module_Bahaviour_UnGarrison",
			"Ares_Module_Dev_Tools_Execute_Code",
			"Ares_Module_Dev_Tools_Create_Mission_SQF",
			"Ares_Module_Equipment_Turret_Optics",
			"Ares_Module_Equipment_Flashlight_IR_ON_OFF",
			"Ares_Module_Equipment_NVD_TACLIGHT_IR",
			"Ares_Artillery_Fire_Mission_Module",
			"Ares_Create_Artillery_Target_Module",
			"Ares_Module_Player_Teleport",
			"Ares_Module_Player_Create_Teleporter",
			"Ares_Module_Player_Change_Player_Side",
			"ModulePunishment_F",
			"Ares_Module_Reinforcements_Create_Lz",
			"Ares_Module_Reinforcements_Create_Rp",
			"Ares_Module_Reinforcements_Spawn_Units",
			"Ares_Module_Spawn_Submarine",
			"Ares_Module_Spawn_Trawler",
			"Ares_Module_Zeus_Add_Remove_Editable_Objects",
			"Ares_Module_Zeus_Visibility",
			"Ares_Module_Zeus_Hint",
			"Ares_Module_Zeus_Switch_Side"
		};
		
		requiredAddons[] = 
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
            "A3_Modules_F_Orange",
			"achilles_language_f",
			"achilles_functions_f_ares",
			"achilles_functions_f_achilles",
			"achilles_data_f_achilles",
			"achilles_data_f_ares",
			"cba_main"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgFactionClasses.hpp"
#include "cfgVehiclesModuleBase.hpp"