
class Ares_Module_Teleport : Ares_Player_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_TELEPORT";
	function = "Ares_fnc_PlayerTeleport";
	icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
};
class Ares_Module_Create_Teleporter : Ares_Player_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_TP";
	function = "Ares_fnc_PlayerCreateTeleporter";
	icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
};
class Ares_Module_Change_Player_Side : Ares_Player_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CHANGE_SIDE_OF_PLAYER";
	function = "Ares_fnc_PlayerChangeSide";
	icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
};


