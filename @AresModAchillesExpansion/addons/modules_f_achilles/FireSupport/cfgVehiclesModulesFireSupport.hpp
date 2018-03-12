class Achilles_FireSupport_ModuleBase : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_FIRE_SUPPORT";
	category = "Ordnance";
};

class Achilles_Suppressive_Fire_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Suppressive_Fire_Module";
	displayName = "$STR_AMAE_SUPPRESIVE_FIRE";
	function = "Achilles_fnc_ModuleFireSupportSuppressiveFire";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_CAS_Module : Achilles_FireSupport_ModuleBase
{
	scopeCurator = 2;
	_generalMacro = "Achilles_CAS_Module";
	displayName = "$STR_AMAE_ADVANCED_CAS";
	function = "Achilles_fnc_ModuleFireSupportCAS";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
	curatorCanAttach = 1;
};

class Achilles_Create_Universal_Target_Module : Achilles_FireSupport_ModuleBase
{
    scopeCurator = 2;
    _generalMacro = "Achilles_Create_Universal_Target_Module";
    displayName = "$STR_AMAE_CREATE_TARGET";
    function = "Achilles_fnc_ModuleFireSupportCreateUniversalTarget";
    icon = "\achilles\data_f_achilles\icons\icon_target.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_target.paa";
    curatorCanAttach = 1;
};