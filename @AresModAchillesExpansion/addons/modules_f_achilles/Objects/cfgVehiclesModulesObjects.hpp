class Achilles_Objects_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_OBJECTS";
	Category = "Achilles_fac_Objects";
};

class Enyo_Objects_Module_Base : Enyo_Module_Base
{
	category = "Achilles_fac_Objects";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Achilles_Toggle_Simulation_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Toggle_Simulation_Module";
	displayName = "$STR_AMAE_TOGGLE_SIMULATION";
	function = "Achilles_fnc_ObjectsToggleSimulation";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Achilles_Attach_To_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Attach_To_Module";
	displayName = "$STR_AMAE_ATTACH_TO";
	function = "Achilles_fnc_ObjectsAttachTo";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};
class Achilles_Make_Invincible_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Make_Invincible_Module";
	displayName = "$STR_AMAE_MAKE_INVINCIBLE";
	function = "Achilles_fnc_ModuleObjectsMakeInvincible";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Achilles_Set_Height_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Set_Height_Module";
	displayName = "$STR_AMAE_CHANGE_HEIGHT";
	function = "Achilles_fnc_ObjectsSetHeight";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Achilles_Transfer_Ownership_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Transfer_Ownership_Module";
	displayName = "$STR_AMAE_TRANSFER_OWNERSHIP";
	function = "Achilles_fnc_ObjectsTransferOwnership";
	icon = "\achilles\data_f_achilles\icons\icon_transferOwnership.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_transferOwnership.paa";
};
class Achilles_IED_Module : Enyo_Objects_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_IED_Module";
	displayName = "$STR_AMAE_ENYO_CREATE_IED";
	function = "Achilles_fnc_ObjectsIED";
	icon = "\achilles\data_f_achilles\icons\icon_createIED.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_createIED.paa";
};

class Achilles_AddECM_Module : Enyo_Objects_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	_generalMacro = "Achilles_AddECM_Module";
	displayName = "$STR_AMAE_ENYO_ADD_ECM_TO_VEHICLE";
	function = "Achilles_fnc_ObjectsAddECM";
};
class Achilles_Module_Rotation : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ROTATION_MODULE";
	function = "Achilles_fnc_ObjectsRotation";
	icon = "\achilles\data_f_achilles\icons\icon_rotateObjects.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_rotateObjects.paa";
};
class Achilles_Hide_Objects_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_HIDE_OBJECTS";
	function = "Achilles_fnc_ObjectsHide";
	icon = "\achilles\data_f_achilles\icons\icon_hideZeus.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_hideZeus.paa";
};