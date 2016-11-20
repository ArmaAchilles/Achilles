class CfgPatches
{
	class achilles_modules_f_achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.3;
		versionStr = "0.0.3";
		versionAr[] = {0,0,3};
		
		units[] =
		{
			"Achilles_ACE_Injury_Module",
			"Achilles_ACE_Heal_Module",
			"Achilles_Animation_Module",
			"Achilles_Chatter_Module",
			"Achilles_Sit_On_Chair_Module",
			"Achilles_Change_Ability_Module",
			"Achilles_Buildings_Destroy_Module",
			"Achilles_Bind_Variable_Module",
			"Achilles_Set_Weather_Module",
			"Achilles_Earthquake_Module",
			"Achilles_Artillery_Fire_Mission_Module",
			"Achilles_Suppressive_Fire_Module",
			"Achilles_Create_Artillery_Target_Module",
			"Achilles_Create_Suppression_Target_Module",
			"Achilles_Toggle_Simulation_Module",
			"Achilles_Transfer_Ownership_Module",
			"Achilles_Attach_To_Module",
			"Achilles_Set_Height_Module",
			"Achilles_Module_Manage_Advanced_Compositions",
			"Achilles_Module_Spawn_Effects",
			"Achilles_Module_Spawn_Intel",
			"Achilles_Module_Spawn_Advanced_Composition",
			"Achilles_Module_Spawn_Explosives"
		};

		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"achilles_language_f",
			"achilles_functions_f_ares",
			"achilles_functions_f_achilles",
			"achilles_data_f_achilles",
			"achilles_data_f_ares"
		};
	};
	class AchillesEffects
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.1;
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
		
		units[] = 
		{
			"ModuleLightSource_F",
			"ModuleLightSourceWhite_F",
			"ModuleLightSourceBlue_F",
			"ModuleLightSourceRed_F",
			"ModuleLightSourceGreen_F",
			"ModuleLightSourceYellow_F",
			"ModulePersistentSmokePillar_F",
			"ModulePersistentSmokePillar000_F",
			"ModulePersistentSmokePillar001_F",
			"ModulePersistentSmokePillar002_F",
			"ModulePersistentSmokePillar003_F",
			"ModulePersistentSmokePillar004_F",
			"ModulePersistentSmokePillar005_F",
			"ModulePersistentSmokePillar006_F",
			"ModulePersistentSmokePillar007_F",
			"ModulePersistentSmokePillar008_F"
		};

		requiredAddons[] =
		{
			"A3_Modules_F"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgFactionClasses.hpp"
#include "cfgVehiclesModuleBase.hpp"