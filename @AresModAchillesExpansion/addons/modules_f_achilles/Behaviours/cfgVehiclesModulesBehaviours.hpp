class Achilles_Behaviours_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_AI_BEHAVIOUR";
	Category = "Achilles_fac_Behaviours";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Enyo_Behaviours_Module_Base : Enyo_Module_Base
{
	Category = "Achilles_fac_Behaviours";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_Animation_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Animation_Module";
	displayName = "$STR_AMAE_AMBIENT_ANIMATION";
	function = "Achilles_fnc_BehaviourAnimation";
};

class Achilles_Chatter_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Chatter_Module";
	displayName = "$STR_AMAE_CHATTER";
	function = "Achilles_fnc_BehaviourChatter";
};

class Achilles_Sit_On_Chair_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Sit_On_Chair_Module";
	displayName = "$STR_AMAE_SIT_ON_CHAIR";
	function = "Achilles_fnc_BehaviourSitOnChair";
	icon = "\achilles\data_f_achilles\icons\icon_chair.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_chair.paa";
};

class Achilles_Change_Ability_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Change_Ability_Module";
	displayName = "$STR_AMAE_CHANGE_ABILITIES";
	function = "Achilles_fnc_BehaviourChangeAbility";
};

class Achilles_Change_Altitude_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Change_Altitude_Module";
	displayName = "$STR_AMAE_CHANGE_ALTITUDE";
	function = "Achilles_fnc_BehaviourAltitude";
};

class Achilles_SuicideBomber_Module : Enyo_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Enyo_SuicideBomber_Module";
	displayName = "$STR_AMAE_ENYO_SET_SUICIDE_BOMBER";
	function = "Achilles_fnc_BehaviourSuicideBomber";
};
