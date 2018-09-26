class Ares_Equipment_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_AMAE_EQUIPMENT";
	Category = "Achilles_fac_Equipment";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Ares_Module_Equipment_Turret_Optics : Ares_Equipment_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_ADD_REMOVE_TURRET_OPTICS";
	function = "Ares_fnc_EquipmentTurretOptics";
};

class Ares_Module_Equipment_Flashlight_IR_ON_OFF : Ares_Equipment_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_TOGGLE_TACLIGHT_IR";
	function = "Ares_fnc_EquipmentFlashlightIRLaserOnOff";
};

class Ares_Module_Equipment_NVD_TACLIGHT_IR : Ares_Equipment_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_ADD_NVD_TACLIGHT_IR";
	function = "Ares_fnc_EquipmentNVDRailAttachment";
};
