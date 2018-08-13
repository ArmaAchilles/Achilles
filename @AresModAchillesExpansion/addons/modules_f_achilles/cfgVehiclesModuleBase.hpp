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
	class Achilles_Module_Base : Module_F
	{
		mapSize = 1;
		author = "Kex";
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
		isGlobal = 2;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		// curatorInfoType = "RscDisplayAttributeModuleNuke";	// Menu displayed when the module is placed or double-clicked on by Zeus

        dlc = "Achilles";

		class Arguments {};
		class ModuleDescription: ModuleDescription
		{
			description = "Achilles Module Base";
		};
	};

	class Enyo_Module_Base : Achilles_Module_Base
	{
		author = "CreepPork_LV";
		category = "Enyo";
		displayName = "Enyo Module Base";
		dlc = "Enyo";

		class ModuleDescription: ModuleDescription
		{
			description = "Enyo Module Base";
		};
	};

	class All;
	class Thing : All {};
	class ModuleEmpty_F : Thing {};

	#include "ACE\cfgVehiclesModulesACE.hpp"
	#include "Ambient\cfgVehiclesModulesAmbient.hpp"
	#include "Arsenal\cfgVehiclesModulesArsenal.hpp"
	#include "Behaviours\cfgVehiclesModulesBehaviours.hpp"
	#include "Buildings\cfgVehiclesModulesBuildings.hpp"
	#include "DevTools\cfgVehiclesModulesDevTools.hpp"
	#include "Effects\cfgVehiclesModuleEffects.hpp"
	#include "Equipment\cfgVehiclesModulesEquipment.hpp"
	#include "FireSupport\cfgVehiclesModulesFireSupport.hpp"
	#include "Environment\cfgVehiclesModulesEnvironment.hpp"
	#include "MissionFlow\cfgVehiclesModulesMissionFlow.hpp"
	#include "Objects\cfgVehiclesModulesObjects.hpp"
	#include "Player\cfgVehiclesModulesPlayer.hpp"
	#include "Reinforcements\cfgVehiclesModulesReinforcements.hpp"
	#include "Replacement\cfgVehiclesModulesReplacement.hpp"
	#include "Spawn\cfgVehiclesModulesSpawn.hpp"
	#include "Zeus\cfgVehiclesModulesZeus.hpp"
	
	// config replacement: remove vanilla effect modules
	class ModuleChemlight_F : Module_F {};
	class ModuleChemlightBlue_F : ModuleChemlight_F {scopeCurator = 1;};
	class ModuleChemlightGreen_F : ModuleChemlightBlue_F {scopeCurator = 1;};
	class ModuleChemlightRed_F : ModuleChemlightBlue_F {scopeCurator = 1;};
	class ModuleChemlightYellow_F : ModuleChemlightBlue_F {scopeCurator = 1;};

	class ModuleFlare_F : Module_F {};
	class ModuleFlareWhite_F : ModuleFlare_F {scopeCurator = 1;};
	class ModuleFlareGreen_F : ModuleFlareWhite_F {scopeCurator = 1;};
	class ModuleFlareRed_F : ModuleFlareWhite_F {scopeCurator = 1;};
	class ModuleFlareYellow_F : ModuleFlareWhite_F {scopeCurator = 1;};

	class ModuleSmoke_F : Module_F {};
	class ModuleSmokeWhite_F : ModuleSmoke_F {scopeCurator = 1;};
	class ModuleSmokeBlue_F : ModuleSmokeWhite_F {scopeCurator = 1;};
	class ModuleSmokeGreen_F : ModuleSmokeWhite_F {scopeCurator = 1;};
	class ModuleSmokeOrange_F : ModuleSmokeWhite_F {scopeCurator = 1;};
	class ModuleSmokePurple_F : ModuleSmokeWhite_F {scopeCurator = 1;};
	class ModuleSmokeRed_F : ModuleSmokeWhite_F {scopeCurator = 1;};
	class ModuleSmokeYellow_F : ModuleSmokeWhite_F {scopeCurator = 1;};

	class ModuleIRGrenade_F : Module_F {scopeCurator = 1;};
	class ModuleTracers_F : Module_F {scopeCurator = 1;};
	
};
