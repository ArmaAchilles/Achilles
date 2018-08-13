class Achilles_Ambient_Module_Base : Achilles_Module_Base
{
	Category = "Ambient";
};

class Achilles_Ambient_CivilianPresence : Achilles_Ambient_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Ambient_CivilianPresence";
	displayName = "$STR_a3_to_basicCivilianPresence19";
	function = "Achilles_fnc_AmbientCivilianPresenceModule";
	icon = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
	portrait = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
};

class Achilles_Ambient_CivilianSafeSpot : Achilles_Ambient_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Ambient_CivilianSafeSpot";
	displayName = "$STR_a3_to_basicCivilianPresence9";
	function = "Achilles_fnc_AmbientCivilianSafeSpotModule";
	icon = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
	portrait = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
};

class Achilles_Ambient_CivilianSpawn : Achilles_Ambient_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Ambient_CivilianSpawn";
	displayName = "$STR_a3_to_basicCivilianPresence7";
	function = "Achilles_fnc_AmbientCivilianSpawnModule";
	icon = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
	portrait = "A3\Modules_F_Tacops\Data\CivilianPresence\icon32_ca.paa";
};
