class Achilles_Buildings_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_BUILDINGS";
	Category = "Achilles_fac_Buildings";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	picture = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";		
};

class Achilles_Buildings_Destroy_Module : Achilles_Buildings_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Buildings_Destroy_Module";
	displayName = "$STR_DAMAGE_BUILDINGS";
	function = "Achilles_fnc_BuildingsDestroy";
};

class Achilles_Buildings_LockDoors_Module : Achilles_Buildings_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Buildings_LockDoors_Module";
	displayName = "$STR_LOCK_DOORS";
	function = "Achilles_fnc_LockDoors";
	icon = "\achilles\data_f_achilles\icons\icon_door.paa";
	picture = "\achilles\data_f_achilles\icons\icon_door.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_door.paa";
};

class Achilles_Buildings_ToggleLight_Module : Achilles_Buildings_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Buildings_ToggleLight_Module";
	displayName = "$STR_TOGGLE_LAMPS";
	function = "Achilles_fnc_ToggleLamps";
};