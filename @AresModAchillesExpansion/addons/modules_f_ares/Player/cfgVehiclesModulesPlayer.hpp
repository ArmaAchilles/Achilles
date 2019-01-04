class Ares_Player_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_AMAE_PLAYERS";
	Category = "Achilles_fac_Player";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	picture = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};

class Ares_Module_Player_Teleport : Ares_Player_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_TELEPORT";
	function = "Ares_fnc_PlayerTeleport";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";
};
class Ares_Module_Player_Create_Teleporter : Ares_Player_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_CREATE_TP";
	function = "Ares_fnc_PlayerCreateTeleporter";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";
};
class Ares_Module_Player_Change_Player_Side : Ares_Player_Module_Base
{
	scopeCurator = 1;
	displayName = "$STR_AMAE_CHANGE_SIDE_OF_PLAYER";
	function = "Ares_fnc_PlayerChangeSide";
	icon = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_unit.paa";
};
class ModuleBootcampStage_F : Module_F 
{
	scopeCurator = 1;
	Category = "Achilles_fac_Player";
};
class ModulePunishment_F : ModuleBootcampStage_F
{
	scopeCurator = 1;
	Category = "Achilles_fac_Player";
};
