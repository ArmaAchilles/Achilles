class CfgPatches
{
	class achilles_settings_f
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.3;
		versionStr = "0.0.3";
		versionAr[] = {0,0,3};

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
    class achilles
    {
        init = "call compile preProcessFileLineNumbers '\achilles\settings_f\scripts\XEH_preInit.sqf'";
    };
};

#include "cfgFunctions.hpp"
#include "cfgResources.hpp"