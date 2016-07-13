class Achilles_Module_Animation : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMBIENT_ANIMATION";
	function = "Achilles_fnc_BehaviourAnimation";
};

class Achilles_Module_Chatter : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CHATTER";
	function = "Achilles_fnc_BehaviourChatter";
};

class Achilles_Module_Sit_On_Chair : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SIT_ON_CHAIR";
	function = "Achilles_fnc_BehaviourSitOnChair";
	icon = "\ares_zeusExtensions\Achilles\data\icon_chair.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_chair.paa";
};

class Achilles_Module_Change_Ability : Ares_Behaviours_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CHANGE_ABILITIES";
	function = "Achilles_fnc_BehaviourChangeAbility";
};