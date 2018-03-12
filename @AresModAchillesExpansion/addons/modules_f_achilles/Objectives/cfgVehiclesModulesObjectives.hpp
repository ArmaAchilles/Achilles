class Achilles_Objectives_Module_Base : Achilles_Module_Base
{
	Category = "Objectives";
};

class Achilles_Objectives_Custom_Objective_Module : Achilles_Objectives_Module_Base
{
	scopeCurator = 2;
	displayName = "Custom Objective";
	function = "Achilles_fnc_ObjectivesCustomObjective";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
    curatorCanAttach = 1;
    achillesDialog = "Achilles_fnc_customObjectivesEdit";
};