//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\config\cfgWaypoints.hpp 
//  DESCRIPTION: Define new scripted waypoints for Zeus
//////////////////////////////////////////////////////////////////////////////////

class cfgWaypoints
{
	class Achilles
	{
		displayName = "Achilles";
		class Fastroping
		{
			displayName = "$STR_ACE_FASTROPING";
			displayNameDebug = "FASTROPING";
			file = "\achilles\functions_f_achilles\scripts\fn_wpFastrope.sqf";
			icon = "\achilles\data_f\icons\icon_position.paa";
		};
		class Land
		{
			displayName = "$STR_A3_CfgWaypoints_Land";
			displayNameDebug = "LAND";
			file = "\achilles\functions_f_achilles\scripts\fn_wpLand.sqf";
			icon = "\achilles\data_f\icons\icon_position.paa";
		};
		class Paradrop
		{
			displayName = "$STR_PARADROP";
			displayNameDebug = "PARADROP";
			file = "\achilles\functions_f_achilles\scripts\fn_wpParadrop.sqf";
			icon = "\achilles\data_f\icons\icon_dropzone.paa";
		};
		class SearchBuilding
		{
			displayName = "$STR_SEARCH_BUILDING";
			displayNameDebug = "SearchBuilding";
			file = "\achilles\functions_f_achilles\scripts\fn_wpSearchBuilding.sqf";
			icon = "\achilles\data_f\icons\icon_position.paa";
		};
	};
};