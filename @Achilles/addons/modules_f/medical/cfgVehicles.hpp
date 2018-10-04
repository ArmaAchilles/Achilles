class MODULE_CAT_BASE(medical) : MODULE_BASE_ACHIL
{
	category = "Achilles_fac_ace";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class MODULE(medical,heal) : MODULE_CAT_BASE(medical)
{
	displayName = "$STR_AMAE_HEAL";
	function = MODULE_FUNC_ACHIL(medical,heal);
};

class MODULE(medical,injury) : MODULE_CAT_BASE(medical)
{
	displayName = "$STR_AMAE_INJURY";
	function = MODULE_FUNC_ACHIL(medical,injury);
};

