class CfgVehicles
{
	#include "cfgVehiclesBase"
	
	class Achilles_mod_base_f : Module_f
	{
		author = "Achilles Dev Team";
		category = "Achilles";
		dlc = "Achilles";
		displayName = "Achilles Module Base";
		
		// availability
		scope = 1; // not available for 3DEN
		scopeCurator = 1; // not available for Zeus
		
		// module function attributes
		function = "";
		is3DEN = 1; // enables the alternative module function parameter format
		isGlobal = 1; // execute on all machines (we will have to check for Zeus)
		isTriggerActivated = 0; // the modules ignores synced triggers
		isDisposable = 0;
		
		icon = "\achilles\data_f_ares\icons\icon_default.paa";
		portrait = "\achilles\data_f_ares\icons\icon_default.paa";	
	};
	
	#include "ace\cfgVehicles.hpp";
};
