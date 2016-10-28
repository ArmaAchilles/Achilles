class Ares_Arsenal_Module_Base : Ares_Module_base
{
	subCategory = "$STR_ARSENAL";
	//Category = "Arsenal";	
};

class Ares_Module_Arsenal_AddFull : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADD_FULL";
	function = "Ares_fnc_ArsenalAddFull";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Ares_Module_Arsenal_AddCustom : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADD_FILTERED";
	function = "Ares_fnc_ArsenalAddCustom";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Ares_Module_Arsenal_Copy_To_Clipboard : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_COPY_TO_CLIPBOARD";
	function = "Ares_fnc_ArsenalCopyToClipboard";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Ares_Module_Arsenal_Paste_Replace: Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_PASTE_N_REPLACE";
	function = "Ares_fnc_ArsenalPasteReplace";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Ares_Module_Arsenal_Paste_Combine : Ares_Arsenal_Module_base
{
	scopeCurator = 2;
	displayName = "$STR_PASTE_N_COMBINE";
	function = "Ares_fnc_ArsenalPasteCombine";
	icon = "\achilles\data_f_achilles\icons\icon_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_object.paa";
};

class Ares_Module_Arsenal_Create_Nato : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_BASIC_NATO";
	function = "Ares_fnc_ArsenalCreateNato";
};

class Ares_Module_Arsenal_Create_Csat : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_BASIC_CSAT";
	function = "Ares_fnc_ArsenalCreateCsat";
};

class Ares_Module_Arsenal_Create_Aaf : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_BASIC_AAF";
	function = "Ares_fnc_ArsenalCreateAaf";
};

class Ares_Module_Arsenal_Create_Guerilla : Ares_Arsenal_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_BASIC_GUERILLA";
	function = "Ares_fnc_ArsenalCreateGuerilla";
};
