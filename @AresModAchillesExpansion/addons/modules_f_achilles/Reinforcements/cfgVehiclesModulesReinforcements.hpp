class Achilles_Reinforcements_Module_Base : Achilles_Module_Base
{
	Category = "Achilles_fac_Reinforcements";
};

class Achilles_Module_Supply_Drop : Achilles_Reinforcements_Module_Base
{
	scopeCurator = 2;
	curatorCanAttach = 1;
	displayName = "$STR_SUPPLY_DROP";
	function = "Achilles_fnc_ReinforcementsSupplyDrop";
	icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_unit.paa";
};