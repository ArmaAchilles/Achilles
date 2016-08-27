class Ares_Reinforcements_Module_base : Ares_Module_Base
{
	subCategory = "$STR_REINFORCEMENTS";
};

class Ares_Module_Reinforcements_Create_Lz : Ares_Reinforcements_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_NEW_LZ";
	function = "Ares_fnc_ReinforcementsCreateLz";
	icon = "\achilles\data_f_ares\icons\icon_lz.paa";
	portrait = "\achilles\data_f_ares\icons\icon_lz.paa";
};

class Ares_Module_Reinforcements_Create_Rp : Ares_Reinforcements_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_NEW_RP";
	function = "Ares_fnc_ReinforcementsCreateRp";
	icon = "\achilles\data_f_ares\icons\icon_rp.paa";
	portrait = "\achilles\data_f_ares\icons\icon_rp.paa";
};

class Ares_Module_Reinforcements_Spawn_Units : Ares_Reinforcements_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_UNITS";
	function = "Ares_fnc_ReinforcementsCreateUnits";
};

