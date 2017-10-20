class Achilles_Reinforcements_Module_Base : Achilles_Module_Base
{
	Category = "Achilles_fac_Reinforcements";
};

class Achilles_Module_Supply_Drop : Achilles_Reinforcements_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SUPPLY_DROP";
	function = "Achilles_fnc_ReinforcementsSupplyDrop";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};