class ModuleMine_F : ModuleEmpty_F
{
	function = "Achilles_fnc_moduleMine";
};

class ModuleCAS_F : Module_F 
{
	function = "Achilles_fnc_moduleCAS";
};
class ModuleCASGun_F : ModuleCAS_F {};
class ModuleCASBomb_F : ModuleCASGun_F
{
	scopeCurator = 2;
};