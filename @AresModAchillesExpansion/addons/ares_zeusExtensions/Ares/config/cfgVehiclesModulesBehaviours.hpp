class Ares_Module_SurrenderSingleUnit : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SURRENDER_UNIT";
	function = "Ares_fnc_SurrenderUnits";
};

class Ares_Module_Garrison_Nearest : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_GARRISON_INSTANT";
	function = "Ares_fnc_GarrisonNearest";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

class Ares_Module_UnGarrison : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_UN_GARRISON";
	function = "Ares_fnc_UnGarrison";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

class Ares_Module_Behaviour_Search_Nearby_Building : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SEARCH_BUILDING";
	function = "Ares_fnc_BehaviourSearchNearbyBuilding";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

class Ares_Module_Behaviour_Search_Nearby_And_Garrison : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SEARCH_AND_GARRISON_BUILDING";
	function = "Ares_fnc_BehaviourSearchNearbyAndGarrison";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

class Ares_Module_Behaviour_Patrol : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_PATROL";
	function = "Ares_fnc_BehaviourPatrol";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

/*
class Ares_Module_Behaviour_Land_Helicopter : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "Land Helicopter";
	function = "Ares_fnc_BehaviourLandHelicopter";
};
*/