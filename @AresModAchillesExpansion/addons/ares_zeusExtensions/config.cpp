//#include "BIS_AddonInfo.hpp"
class CfgPatches
{
	class Ares
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Anton Struyk";
		authorUrl = "https://github.com/astruyk/";
		version = 1.8.1;
		versionStr = "1.8.1";
		versionAr[] = {1,8,1};
		
		#include "Ares\config\units.hpp"

		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator"
		};
	};
	class Achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.2;
		versionStr = "0.0.2";
		versionAr[] = {0,0,2};
		
		#include "Achilles\config\units.hpp"

		requiredAddons[] =
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator"
		};
	};
	class AchillesEffects
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.1;
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
		
		units[] = 
		{
			"ModuleLightSource_F",
			"ModuleLightSourceWhite_F",
			"ModuleLightSourceBlue_F",
			"ModuleLightSourceRed_F",
			"ModuleLightSourceGreen_F",
			"ModuleLightSourceYellow_F",
			"ModulePersistentSmokePillar_F",
			"ModulePersistentSmokePillar000_F",
			"ModulePersistentSmokePillar001_F",
			"ModulePersistentSmokePillar002_F",
			"ModulePersistentSmokePillar003_F",
			"ModulePersistentSmokePillar004_F",
			"ModulePersistentSmokePillar005_F",
			"ModulePersistentSmokePillar006_F",
			"ModulePersistentSmokePillar007_F",
			"ModulePersistentSmokePillar008_F"
		};

		requiredAddons[] =
		{
			"A3_Modules_F"
		};
	};
};

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
		subCategory = "Behaviours";
		side = 7;

		scope = 1;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
		scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.

		displayName = "Ares Module Base";	// Name displayed in the menu
		icon = "\ares_zeusExtensions\Ares\data\icon_default.paa";		// Map icon. Delete this entry to use the default icon
		picture = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_default.paa";

		function = "";			// Name of function triggered once conditions are met
		functionPriority = 1;	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 2;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		// curatorInfoType = "RscDisplayAttributeModuleNuke";	// Menu displayed when the module is placed or double-clicked on by Zeus
		
		class Arguments {};
		class ModuleDescription: ModuleDescription
		{
			description = "Ares Module Base";
		};
	};
	
	class Ares_Arsenal_Module_Base : Ares_Module_base
	{
		subCategory = "$STR_ARSENAL";	
	};

	class Ares_Behaviours_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_AI_BEHAVIOUR";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	
	class Ares_Dev_Tools_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_DEV_TOOLS";
	}
	
	class Ares_Equipment_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_EQUIPMENT";
	};
	
	class Ares_Reinforcements_Module_base : Ares_Module_Base
	{
		subCategory = "$STR_REINFORCEMENTS";
	};
	
	class Ares_SaveLoad_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_SAVE_LOAD";
	};

	class Ares_Spawn_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_SPAWN";
	};
	
	class Ares_User_Defined_Module_Base : Ares_Module_Base
	{
		category = "User Defined"; // Keeps these from being added to the UI automatically.
		subCategory = "";
	};

	class Ares_Zeus_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_ZEUS";
	};

	class Ares_Player_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_PLAYER";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	
	class Achilles_ACE_Module_Base : Ares_Module_Base
	{
		subCategory = "ACE";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	
	class Achilles_Environment_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_ENVIRONMENT";
	};
	
	class Achilles_Fire_Support_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_FIRE_SUPPORT";
	};
	
	class Achilles_Buildings_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_BUILDINGS";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";		
	};
	
	class Achilles_Objects_Module_Base : Ares_Module_Base
	{
		subCategory = "$STR_OBJECTS";		
	};
	
	// Placeholder class that doesn't do anything. Used for generating categories in UI.
	class Ares_Module_Empty : Ares_Module_Base
	{
		category = "Curator";
		subCategory = "";
		
		mapSize = 0;
		displayName = "Ares Module Empty";
		//icon = "";
		function = "Ares_fnc_Empty";
	};

	#include "Ares\config\cfgVehiclesModulesBehaviours.hpp"
	#include "Ares\config\cfgVehiclesModulesEquipment.hpp"
	#include "Ares\config\cfgVehiclesModulesSpawn.hpp"
	#include "Ares\config\cfgVehiclesModulesArsenal.hpp"
	#include "Ares\config\cfgVehiclesModulesReinforcements.hpp"
	#include "Ares\config\cfgVehiclesModulesZeus.hpp"
	#include "Ares\config\cfgVehiclesModulesUserDefined.hpp"
	#include "Ares\config\cfgVehiclesSortingOVerrides.hpp"
	#include "Ares\config\cfgVehiclesModulesDevTools.hpp"
	#include "Ares\config\cfgVehiclesModulesPlayer.hpp"

	#include "Achilles\config\cfgVehiclesModulesBehaviours.hpp"
	#include "Achilles\config\cfgVehiclesModulesACE.hpp"
	#include "Achilles\config\cfgVehiclesModulesDevTools.hpp"
	#include "Achilles\config\cfgVehiclesModulesEnvironment.hpp"
	#include "Achilles\config\cfgVehiclesModulesFireSupport.hpp"
	#include "Achilles\config\cfgVehiclesModulesBuildings.hpp"
	#include "Achilles\config\cfgVehiclesModulesObjects.hpp"
	
	//#include "Achilles\config\cfgVehiclesCAS.hpp"
	#include "Achilles\config\cfgVehiclesModuleEffects.hpp"
	#include "Achilles\config\cfgVehiclesModuleAnimals.hpp"
};

class CfgFunctions
{
	#include "Ares\config\cfgFunctions.hpp"
	#include "Achilles\config\cfgFunctions.hpp"
};

class CfgGroups
{
	#include "Compositions\compositions.hpp"
};

class CfgWeapons
{
	#include "Ares\config\cfgWeaponsSortingOverrides.hpp"
	
	//#include "Achilles\config\cfgWeaponsCAS.hpp"
};

#include "Ares\ui\baseDialogs.hpp"
#include "Ares\ui\copyPasteDialog.hpp"
#include "Ares\ui\ExecuteCodeDialog.hpp"
#include "Ares\ui\dynamicDialog.hpp"
#include "Ares\ui\compositionsDialog.hpp"

// Achilles

class cfgHints
{
	#include "Achilles\config\cfgHints.hpp"
};

class cfgMusic
{
	#include "Achilles\config\cfgMusic.hpp"
};

class cfgWaypoints
{
	#include "Achilles\config\cfgWaypoints.hpp"
};

#include "Achilles\config\cfgResources.hpp"

/*
class CfgUnitInsignia
{
	class Ares
	{
		displayName = "Ares";
		author = "Anton Struyk";
		texture = "\ares_zeusExtensions\Ares\data\Ares_Insignia.paa"
	};
	class Achilles
	{
		displayName = "Achilles";
		author = "Kex";
		texture = "\ares_zeusExtensions\Achilles\data\Achilles_Insignia.paa"
	};
};
*/