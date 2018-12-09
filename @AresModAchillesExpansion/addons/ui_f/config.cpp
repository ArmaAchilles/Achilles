class CfgPatches
{
	class Achilles_UI_F
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Achilles Dev Team";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {0,1,0};
		
		units[] = {};
		
		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"Achilles_Language_F",
			"Achilles_Functions_F",
			"Achilles_Functions_F_Ares",
			"Achilles_Functions_F_Achilles",
			"Achilles_Data_F_Achilles",
			"Achilles_Data_F_Ares",
            "Achilles_Settings_F"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgResources.hpp"
#include "cfgHints.hpp"
#include "cfgMods.hpp"
#include "ACE_ZeusActions.hpp"
