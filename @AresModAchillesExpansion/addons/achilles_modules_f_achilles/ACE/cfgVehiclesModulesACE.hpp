class Achilles_ACE_Module_Base : Achilles_Module_Base
{
	//subCategory = "ACE";
	category = "ACE";
	icon = "achilles\data_f_achilles\icons\icon_default_unit.paa";
	picture = "achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Achilles_ACE_Injury_Module : Achilles_ACE_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_ACE_Injury_Module";
	displayName = "$STR_INJURY";
	function = "Achilles_fnc_ACEInjury";
};

class Achilles_ACE_Heal_Module : Achilles_ACE_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_ACE_Heal_Module";
	displayName = "$STR_HEAL";
	function = "Achilles_fnc_ACEHeal";
};