class Achilles_Behaviours_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AI_BEHAVIOUR";
	Category = "Behaviours";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Achilles_Animation_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Animation_Module";
	displayName = "$STR_AMBIENT_ANIMATION";
	function = "Achilles_fnc_BehaviourAnimation";
};

class Achilles_Chatter_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Chatter_Module";
	displayName = "$STR_CHATTER";
	function = "Achilles_fnc_BehaviourChatter";
};

class Achilles_Sit_On_Chair_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Sit_On_Chair_Module";
	displayName = "$STR_SIT_ON_CHAIR";
	function = "Achilles_fnc_BehaviourSitOnChair";
	icon = "\achilles\data_f_achilles\icons\icon_chair.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_chair.paa";
};

class Achilles_Change_Ability_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Change_Ability_Module";
	displayName = "$STR_CHANGE_ABILITIES";
	function = "Achilles_fnc_BehaviourChangeAbility";
};

class Achilles_Change_Altitude_Module : Achilles_Behaviours_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_Change_Altitude_Module";
	displayName = "$STR_CHANGE_ALTITUDE";
	function = "Achilles_fnc_BehaviourAltitude";
};