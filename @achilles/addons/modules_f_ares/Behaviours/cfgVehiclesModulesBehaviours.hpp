class Ares_Behaviours_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_AMAE_AI_BEHAVIOUR";
	Category = "Achilles_fac_Behaviours";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	picture = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Ares_Module_Bahaviour_SurrenderUnit : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_SURRENDER_UNIT";
	function = "Ares_fnc_BehaviourSurrenderUnits";
};

class Ares_Module_Bahaviour_Garrison_Nearest : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_GARRISON_INSTANT";
	function = "Ares_fnc_GarrisonNearest";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Ares_Module_Bahaviour_UnGarrison : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_UN_GARRISON";
	function = "Ares_fnc_UnGarrison";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Ares_Module_Behaviour_Search_Nearby_Building : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_SEARCH_BUILDING";
	function = "Ares_fnc_BehaviourSearchNearbyBuilding";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Ares_Module_Behaviour_Search_Nearby_And_Garrison : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_SEARCH_AND_GARRISON_BUILDING";
	function = "Ares_fnc_BehaviourSearchNearbyAndGarrison";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Ares_Module_Behaviour_Patrol : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_PATROL_LOITER";
	function = "Ares_fnc_BehaviourPatrol";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};
