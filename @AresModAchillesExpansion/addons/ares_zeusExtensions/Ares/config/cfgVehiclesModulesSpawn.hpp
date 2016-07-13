
class Ares_Module_Spawn_Submarine : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "Submarine";
	function = "Ares_fnc_SpawnSubmarine";
};

class Ares_Module_Spawn_Trawler : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "Trawler";
	function = "Ares_fnc_SpawnTrawler";
};

class Ares_Module_Spawn_Effects : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EFFECT";
	function = "Ares_fnc_SpawnEffect";
};

class Ares_Module_Spawn_Intel : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_CREATE_EDIT_INTEL";
	function = "Ares_fnc_SpawnCreateEditIntel";
	icon = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
	portrait = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
};

class Ares_Module_Spawn_Advanced_Composition : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_ADVANCED_COMPOSITION";
	function = "Ares_fnc_SpawnAdvancedCompositions";
};

class Ares_Module_Spawn_Explosives : Ares_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_MINES_EXPLOSIVES";
	function = "Ares_fnc_SpawnExplosives";
};
