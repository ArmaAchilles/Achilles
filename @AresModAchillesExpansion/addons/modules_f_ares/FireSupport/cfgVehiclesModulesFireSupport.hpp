class Ares_Fire_Support_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_AMAE_FIRE_SUPPORT";
	category = "Ordnance";
};

class Ares_Artillery_Fire_Mission_Module : Ares_Fire_Support_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Ares_Artillery_Fire_Mission_Module";
	displayName = "$STR_AMAE_ARTILLERY_FIRE_MISSION";
	function = "Ares_fnc_FireSupportArtilleryFireMission";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

/*class Ares_Create_Artillery_Target_Module : Ares_Fire_Support_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Ares_Create_Artillery_Target_Module";
	displayName = "$STR_AMAE_CREATE_ARTILLERY_TARGET";
	function = "Ares_fnc_FireSupportCreateArtilleryTarget";
	icon = "\achilles\data_f_ares\icons\icon_artillery_target.paa";
	portrait = "\achilles\data_f_ares\icons\icon_artillery_target.paa";
};*/