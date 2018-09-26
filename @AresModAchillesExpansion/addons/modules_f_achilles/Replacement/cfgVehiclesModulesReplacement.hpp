class ModuleMine_F : ModuleEmpty_F
{
	function = "Achilles_fnc_moduleMine";
};

class ModuleRemoteControl_F : Module_F
{
	function = "Achilles_fnc_moduleRemoteControl";
};

class ModuleCAS_F : Module_F {};
class ModuleCASGun_F : ModuleCAS_F 
{
	scopeCurator = 0;
};
class ModuleCASBomb_F : ModuleCASGun_F
{
	scopeCurator = 0;
};

class Achilles_Module_FireSupport_CASGun : ModuleCASGun_F 
{
	_generalMacro = "Achilles_Module_FireSupport_CASGun";
	scope = 1;
	scopeCurator = 1;
	displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_Gun";
	function = "";
	functionPriority = 1;	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	isGlobal = 2;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
	isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
	isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
};

class Achilles_Module_FireSupport_CASMissile : Achilles_Module_FireSupport_CASGun 
{
	_generalMacro = "Achilles_Module_FireSupport_CASMissile";
	displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_Missiles";
	portrait = "\a3\Modules_F_Curator\Data\portraitCASMissile_ca.paa";
	model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
	curatorCost = 3;
	moduleCAStype = 1;
};

class Achilles_Module_FireSupport_CASGunMissile : Achilles_Module_FireSupport_CASGun 
{
	_generalMacro = "Achilles_Module_FireSupport_CASGunMissile";
	displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_GunMissiles";
	portrait = "\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa";
	model = "\a3\Modules_F_Curator\CAS\surfaceGunMissile.p3d";
	curatorCost = 4;
	moduleCAStype = 2;
};

class Achilles_Module_FireSupport_CASBomb : Achilles_Module_FireSupport_CASGun
{
	_generalMacro = "Achilles_Module_FireSupport_CASBomb";
	displayName = "$STR_AMAE_CAS_BOMB_STRIKE";
	portrait = "\a3\Modules_F_Curator\Data\portraitCASBomb_ca.paa";
	model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
	curatorCost = 5;
	moduleCAStype = 3;
};