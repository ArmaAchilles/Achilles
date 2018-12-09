class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ModuleDescription;
	};
	class MODULE_BASE_ACHIL : Module_F
	{
		mapSize = 1;
		author = "Achilles Dev Team";
		vehicleClass = "Modules";
		category = "Achilles";
		side = 7;

		scope = 1;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
		scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.

		displayName = "Achilles Module Base";	// Name displayed in the menu
		icon = "\achilles\data_f_ares\icons\icon_default.paa";		// Map icon. Delete this entry to use the default icon
		picture = "\achilles\data_f_ares\icons\icon_default.paa";
		portrait = "\achilles\data_f_ares\icons\icon_default.paa";

		function = "";			// Name of function triggered once conditions are met
		functionPriority = 1;	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)

        dlc = "Achilles";

		class ModuleDescription
		{
			description = "Achilles Module Base";
		};
	};
};
