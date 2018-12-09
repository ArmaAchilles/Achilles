class CfgPatches
{
	class Achilles_Functions_F_Achilles
	{
		weapons[] = {};
		requiredVersion = 1.88;
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
			"A3_Functions_F_Mark",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"Achilles_Language_F",
			"Achilles_Functions_F_Ares"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgWaypoints.hpp"