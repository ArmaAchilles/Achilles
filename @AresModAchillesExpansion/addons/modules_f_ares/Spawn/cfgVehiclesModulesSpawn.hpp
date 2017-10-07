class Ares_Spawn_Module_Base : Ares_Module_Base
{
	//subCategory = "$STR_SPAWN";
	Category = "Achilles_fac_Spawn";
};
	
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
