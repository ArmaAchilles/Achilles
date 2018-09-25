class CfgPatches
{
	class achilles_settings_f
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "ArmA 3 Achilles Mod Inc.";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {0,1,0};

		units[] = {};
		requiredAddons[] = 
		{
			"A3_UI_F",
            "cba_main",
            "cba_xeh"
        };
	};
};

class Extended_PreInit_EventHandlers
{
    class achilles_fnc_settingsPreInit
    {
        init = "call compile preProcessFileLineNumbers '\achilles\settings_f\scripts\XEH_preInit.sqf'";
    };
};

#include "cfgFunctions.hpp"
#include "cfgResources.hpp"