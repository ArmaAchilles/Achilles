class Achilles_Equipment_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_EQUIPMENT";
	Category = "Achilles_fac_Equipment";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Achilles_Module_Equipment_Attach_Dettach_Effect : Achilles_Equipment_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ATTACH_DETACH_EFFECT";
	function = "Achilles_fnc_attachDetachEffect";
};
