class Achilles_Spawn_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_SPAWN";
	Category = "Spawn";
};

class Achilles_Module_Spawn_Effects : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EFFECT";
	function = "Achilles_fnc_SpawnEffect";
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

class Achilles_Module_Spawn_Empty_Object : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EMPTY_OBJECT";
	function = "Achilles_fnc_SpawnEmptyObject";
};
