//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\config\cfgWaypoints.hpp 
//  DESCRIPTION: Define new scripted waypoints for Zeus
//	NOTE: The classes defined here are children of cfgWaypoints
//////////////////////////////////////////////////////////////////////////////////

class Achilles
{
	displayName = "Achilles";
	class Fastroping
	{
		displayName = "$STR_ACE_FASTROPING";
		displayNameDebug = "FASTROPING";
		file = "ares_zeusExtensions\Achilles\scripts\fn_wpFastrope.sqf";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Land
	{
		displayName = "$STR_A3_CfgWaypoints_Land";
		displayNameDebug = "LAND";
		file = "ares_zeusExtensions\Achilles\scripts\fn_wpLand.sqf";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class SearchBuilding
	{
		displayName = "$STR_SEARCH_BUILDING";
		displayNameDebug = "SearchBuilding";
		file = "ares_zeusExtensions\Achilles\scripts\fn_wpSearchBuilding.sqf";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
};