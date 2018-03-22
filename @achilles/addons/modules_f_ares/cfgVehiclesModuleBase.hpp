
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ModuleDescription
		{
			class AnyPlayer;
			class AnyBrain;
			class EmptyDetector;
		};
	};
	class Ares_Module_Base : Module_F
	{
		mapSize = 1;
		author = "Anton Struyk";
		vehicleClass = "Modules";
		category = "Ares";
		side = 7;

		scope = 1;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
		scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.

		displayName = "Ares Module Base";	// Name displayed in the menu
		icon = "\achilles\data_f_ares\icons\icon_default.paa";		// Map icon. Delete this entry to use the default icon
		picture = "\achilles\data_f_ares\icons\icon_default.paa";
		portrait = "\achilles\data_f_ares\icons\icon_default.paa";

		function = "";			// Name of function triggered once conditions are met
		functionPriority = 1;	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 2;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		// curatorInfoType = "RscDisplayAttributeModuleNuke";	// Menu displayed when the module is placed or double-clicked on by Zeus

		dlc = "Ares";

		class Arguments {};
		class ModuleDescription: ModuleDescription
		{
			description = "Ares Module Base";
		};
	};
	#include "Arsenal\cfgVehiclesModulesArsenal.hpp"
	#include "Behaviours\cfgVehiclesModulesBehaviours.hpp"
	#include "DevTools\cfgVehiclesModulesDevTools.hpp"
	#include "Equipment\cfgVehiclesModulesEquipment.hpp"
	#include "FireSupport\cfgVehiclesModulesFireSupport.hpp"
	#include "Player\cfgVehiclesModulesPlayer.hpp"
	#include "Reinforcements\cfgVehiclesModulesReinforcements.hpp"
	#include "Spawn\cfgVehiclesModulesSpawn.hpp"
	#include "Zeus\cfgVehiclesModulesZeus.hpp"
	#include "Custom\cfgVehiclesModulesUserDefined.hpp"
};