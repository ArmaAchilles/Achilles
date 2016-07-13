class Achilles_Module_Artillery_Fire_Mission : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ARTILLERY_FIRE_MISSION";
	function = "Achilles_fnc_FireSupportArtilleryFireMission";
	icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
};

class Achilles_Module_Suppressive_Fire : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SUPPRESIVE_FIRE";
	function = "Achilles_fnc_FireSupportSuppressiveFire";
	icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
};

class Achilles_Module_Fire_Support_Create_Artillery_Target : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_ARTILLERY_TARGET";
	function = "Achilles_fnc_FireSupportCreateArtilleryTarget";
	icon = "\ares_zeusExtensions\Ares\data\icon_artillery_target.paa";
	portrait = "\ares_zeusExtensions\Ares\data\icon_artillery_target.paa";
};

class Achilles_Module_Fire_Support_Create_Suppression_Target : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_SUPPRESSION_TARGET";
	function = "Achilles_fnc_FireSupportCreateSuppressionTarget";
	icon = "\ares_zeusExtensions\Achilles\data\icon_target.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_target.paa";
};