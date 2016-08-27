class Achilles_Spawn_Module_Base : Achilles_Module_Base
{
	subCategory = "$STR_SPAWN";
};

class Achilles_Module_Spawn_Effects : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EFFECT";
	function = "Achilles_fnc_SpawnEffect";
};

class Achilles_Module_Spawn_Intel : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_EDIT_INTEL";
	function = "Achilles_fnc_SpawnCreateEditIntel";
	icon = "\achilles\data_f_achilles\icons\icon_default_object.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_default_object.paa";
};

class Achilles_Module_Spawn_Advanced_Composition : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADVANCED_COMPOSITION";
	function = "Achilles_fnc_SpawnAdvancedCompositions";
};

class Achilles_Module_Spawn_Explosives : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_MINES_EXPLOSIVES";
	function = "Achilles_fnc_SpawnExplosives";
};


