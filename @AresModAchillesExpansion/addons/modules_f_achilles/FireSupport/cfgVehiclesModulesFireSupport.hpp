class Achilles_FireSupport_ModuleBase : Achilles_Module_Base
{
	//subCategory = "$STR_FIRE_SUPPORT";
	category = "Ordnance";
};

class Achilles_Suppressive_Fire_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Suppressive_Fire_Module";
	displayName = "$STR_SUPPRESIVE_FIRE";
	function = "Achilles_fnc_ModuleFireSupportSuppressiveFire";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_Create_Suppression_Target_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Create_Suppression_Target_Module";
	displayName = "$STR_CREATE_SUPPRESSION_TARGET";
	function = "Achilles_fnc_ModuleFireSupportCreateSuppressionTarget";
	icon = "\achilles\data_f_achilles\icons\icon_target.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_target.paa";
};

class Achilles_CAS_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_CAS_Module";
	displayName = "$STR_ADVANCED_CAS";
	function = "Achilles_fnc_ModuleFireSupportCAS";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_Create_CAS_Target_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Create_CAS_Target_Module";
	displayName = "$STR_CREATE_CAS_TARGET";
	function = "Achilles_fnc_ModuleFireSupportCreateCASTarget";
	icon = "\achilles\data_f_achilles\icons\icon_cas_target.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_cas_target.paa";
};