class Achilles_Arsenal_Module_Base : Achilles_Module_Base
{
	Category = "Achilles_fac_Arsenal";	
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};

class Achilles_Module_Arsenal_AddFull : Achilles_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ADD_FULL";
	function = "Achilles_fnc_ArsenalAddFull";
};

class Achilles_Module_Arsenal_CreateCustom : Achilles_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ARSENAL_CREATE_CUSTOM";
	function = "Achilles_fnc_ArsenalCreateCustom";
	icon = "\achilles\data_f_ares\icons\icon_default.paa";
	portrait = "\achilles\data_f_ares\icons\icon_default.paa";
};

class Achilles_Module_Arsenal_CopyToClipboard : Achilles_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_COPY_TO_CLIPBOARD";
	function = "Achilles_fnc_ArsenalCopyToClipboard";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Achilles_Module_Arsenal_Paste : Achilles_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ARSENAL_PASTE";
	function = "Achilles_fnc_ArsenalPaste";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Achilles_Module_Arsenal_Remove : Achilles_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_AMAE_ARSENAL_REMOVE";
	function = "Achilles_fnc_ArsenalRemove";
};