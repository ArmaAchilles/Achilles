class Achilles_Spawn_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_SPAWN";
	Category = "Achilles_fac_Spawn";
};

class Achilles_Module_Spawn_Effects : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EFFECT";
	function = "Achilles_fnc_SpawnEffect";
	icon = "\achilles\data_f_achilles\icons\icon_spawnEffects.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_spawnEffects.paa";
};

class Achilles_Module_Spawn_Carrier : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "USS Freedom";
	function = "Achilles_fnc_SpawnCarrier";
	icon = "\achilles\data_f_achilles\icons\icon_freedom.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_freedom.paa";
};

class Achilles_Module_Spawn_Explosives : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_MINES_EXPLOSIVES";
	function = "Achilles_fnc_SpawnExplosives";
	icon = "\achilles\data_f_achilles\icons\icon_minesAndExplosives.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_minesAndExplosives.paa";
};

class Achilles_Module_Spawn_Empty_Object : Achilles_Spawn_Module_Base
{
	scopeCurator = 2;
	displayName = "$STR_SPAWN_EMPTY_OBJECT";
	function = "Achilles_fnc_SpawnEmptyObject";
};
