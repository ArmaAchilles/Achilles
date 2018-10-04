class CfgVehicles
{
	#include "cfgVehiclesBase"
	
	class MODULE_BASE_ACHIL : Module_f
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
		isGlobal = 1; // execute on all machines (we will have to check for Zeus)
		isTriggerActivated = 0; // the modules ignores synced triggers
		isDisposable = 0;
		
		icon = "\achilles\data_f_ares\icons\icon_default.paa";
		portrait = "\achilles\data_f_ares\icons\icon_default.paa";	
	};
	
	#include "medical\cfgVehicles.hpp";
};
