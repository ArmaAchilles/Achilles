#define ACHILLES_CONFIG_ENV
#include "includes\macros.inc.sqf"

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
			"Achilles_Language_F",
			"Achilles_Modules_F_Ares",
			"Achilles_Functions_F_Ares",
			"Achilles_Functions_F_Achilles",
			"Achilles_Data_F_Achilles",
			"Achilles_Data_F_Ares"
		};
	};
};

#include "cfgFunctions.hpp"
#include "cfgVehicles.hpp"
