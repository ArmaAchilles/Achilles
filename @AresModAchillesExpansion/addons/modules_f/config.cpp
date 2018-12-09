class CfgPatches
{
	class Achilles_Modules_F
	{
		weapons[] = {};
		requiredVersion = 1.88;
		author = "Achilles Dev Team";
		authorUrl = "https://github.com/ArmaAchilles/Achilles";
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {1,0,0};

		units[] =
		{
		};

		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"A3_Modules_F_Bootcamp_Misc",
			"Achilles_language_F",
			"Achilles_modules_F_ares",
			"Achilles_Functions_F_ares",
			"Achilles_Functions_F_Achilles",
			"Achilles_Data_F_Achilles",
			"Achilles_Data_F_Ares"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgFactionClasses.hpp"
#include "cfgVehiclesModuleBase.hpp"
