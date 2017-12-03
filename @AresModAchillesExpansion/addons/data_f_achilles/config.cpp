class CfgPatches
{
	class achilles_data_f_achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "ArmA 3 Achilles Mod Inc.";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 0.1.0;
		versionStr = "0.1.0";
		versionAr[] = {0,1,0};
		
		units[] = {};

		requiredAddons[] = {"A3_Structures_F"};
		
		// this prevents any patched class from requiring this addon
        addonRootClass = "A3_Structures_F";
	};
};

class CfgVehicles 
{
	class All;
	class FloatingStructure_F : All {};
	class RoadCone_L_F : FloatingStructure_F
	{
		scopeCurator = 2;
	};
};

#include "cfgMusic.hpp"