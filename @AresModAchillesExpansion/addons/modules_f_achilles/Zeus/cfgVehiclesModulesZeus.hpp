class Achilles_Zeus_Module_Base : Achilles_Module_Base
{
	Category = "Curator";
};

class Achilles_Module_Zeus_SwitchUnit : Achilles_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_SWITCH_UNIT";
	function = "Achilles_fnc_ZeusSwitchUnit";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};

class Achilles_Module_Zeus_AssignZeus : Achilles_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ASSIGN_ZEUS";
	function = "Achilles_fnc_ZeusAssignZeus";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};
class ModuleHint_F : Module_F
{
	scopeCurator = 2;
	Category = "Curator";
	displayName = "$STR_AMAE_ADVANCED_HINT";
};
