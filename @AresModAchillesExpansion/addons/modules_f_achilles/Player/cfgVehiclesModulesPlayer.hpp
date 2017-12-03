class Achilles_Player_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_AMAE_PLAYERS";
	Category = "Achilles_fac_Player";
};

class Achilles_Module_Player_Set_Frequencies : Achilles_Player_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_SET_FREQUENCIES";
	function = "Achilles_fnc_PlayerSetFrequencies";
	icon = "\achilles\data_f_achilles\icons\icon_TFARFreqs.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_TFARFreqs.paa";
};