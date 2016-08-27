class Achilles_Buildings_Module_Base : Achilles_Module_Base
{
	subCategory = "$STR_BUILDINGS";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	picture = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";		
};

class Achilles_Buildings_Destroy_Module : Achilles_Buildings_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Buildings_Destroy_Module";
	displayName = "$STR_DESTROY_BUILDINGS";
	function = "Achilles_fnc_BuildingsDestroy";
};