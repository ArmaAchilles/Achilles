class Achilles_Fire_Support_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_FIRE_SUPPORT";
	category = "Ordnance";
};

class Achilles_Suppressive_Fire_Module : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Suppressive_Fire_Module";
	displayName = "$STR_SUPPRESIVE_FIRE";
	function = "Achilles_fnc_FireSupportSuppressiveFire";
	icon = "\achilles\data_f\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f\icons\icon_default_unit.paa";
};

class Achilles_Create_Suppression_Target_Module : Achilles_Fire_Support_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Create_Suppression_Target_Module";
	displayName = "$STR_CREATE_SUPPRESSION_TARGET";
	function = "Achilles_fnc_FireSupportCreateSuppressionTarget";
	icon = "\achilles\data_f\icons\icon_target.paa";
	portrait = "\achilles\data_f\icons\icon_target.paa";
};