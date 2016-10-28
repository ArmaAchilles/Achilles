class Achilles_Objects_Module_Base : Achilles_Module_Base
{
	subCategory = "$STR_OBJECTS";
	//Category = "Objects";
};

class Achilles_Toggle_Simulation_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Toggle_Simulation_Module";
	displayName = "$STR_TOGGLE_SIMULATION";
	function = "Achilles_fnc_ObjectsToggleSimulation";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Achilles_Attach_To_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Attach_To_Module";
	displayName = "$STR_ATTACH_TO";
	function = "Achilles_fnc_ObjectsAttachTo";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};
class Achilles_Set_Height_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Set_Height_Module";
	displayName = "$STR_CHANGE_HEIGHT";
	function = "Achilles_fnc_ObjectsSetHeight";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};
class Achilles_Transfer_Ownership_Module : Achilles_Objects_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Transfer_Ownership_Module";
	displayName = "$STR_TRANSFER_OWNERSHIP";
	function = "Achilles_fnc_ObjectsTransferOwnership";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};