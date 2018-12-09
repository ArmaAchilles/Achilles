class CfgPatches
{
	class Achilles_Data_F_Achilles
	{
		weapons[] = {};
		requiredVersion = 1.88;
		author = "Achilles Dev Team";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 1.0.0;
		versionStr = "1.0.0";
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