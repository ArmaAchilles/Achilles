class CfgPatches
{
	class achilles_data_f_achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.1;
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
		
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