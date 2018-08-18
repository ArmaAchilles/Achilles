class Achilles_mod_ace_base_f : Achilles_mod_base_f
{
	category = "Achilles_fac_ace";
	icon = "achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Achilles_mod_ace_injury_f : Achilles_mod_ace_base_f
{
	displayName = "$STR_AMAE_INJURY";
	scopeCurator = 2;
	function = "Achilles_fnc_ace_moduleInjury";
};

class Achilles_mod_ace_heal_f : Achilles_mod_ace_base_f
{
	displayName = "$STR_AMAE_HEAL";
	scopeCurator = 2;
	function = "Achilles_fnc_ace_moduleHeal";
};
