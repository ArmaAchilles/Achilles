class Achilles_Zeus_Module_Base : Achilles_Module_Base
{
	Category = "Curator";
};

class Enyo_Zeus_Module_Base : Enyo_Module_Base
{
	Category = "Curator";
};

class Achilles_Module_Zeus_SwitchUnit : Achilles_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SWITCH_UNIT";
	function = "Achilles_fnc_ZeusSwitchUnit";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_Module_Zeus_AssignZeus : Enyo_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ASSIGN_ZEUS";
	function = "Achilles_fnc_ZeusAssignZeus";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};
