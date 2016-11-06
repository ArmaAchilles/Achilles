class Ares_Zeus_Module_Base : Ares_Module_Base
{
	subCategory = "$STR_ZEUS";
	//Category = "Curator";
};

class Ares_Module_Zeus_Add_Remove_Editable_Objects : Ares_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADD_REMOVE_EDITABLE_OBJECTS";
	function = "Ares_fnc_ZeusAddRemoveEditableObjects";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";
};

class Ares_Module_Zeus_Visibility : Ares_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_HIDE_ZEUS";
	function = "Ares_fnc_ZeusVisibility";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

class Ares_Module_Zeus_Hint : Ares_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_Hint";
	function = "Ares_fnc_ZeusHint";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

class Ares_Module_Zeus_Switch_Side : Ares_Zeus_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SWITCH_SIDE_CHANNEL_OF_ZEUS";
	function = "Ares_fnc_ZeusSwitchSideChannel";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

