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
		
		units[] = {"Land_BluntStone_26"};

		requiredAddons[] = {"A3_Structures_F","A3_Structures_F_Mil","A3_Rocks_F"};
		
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
	class Static : All {};
	class Rocks_base_F : Static {};
	class Land_BluntStone_26: FloatingStructure_F 
	{
		author = "$STR_A3_Bohemia_Interactive";
		mapSize = 3.800000;
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_BluntStone_02.jpg";
		_generalMacro = "Land_BluntStone_02";
		scope = 2;
		scopeCurator = 2;
		displayName = "Land_BluntStone_020";
		model = "\A3\Rocks_F\Blunt\BluntStone_02.p3d";
		icon = "iconObject_elipse_H";
		accuracy = 1000;
	};
};


















#include "cfgMusic.hpp"