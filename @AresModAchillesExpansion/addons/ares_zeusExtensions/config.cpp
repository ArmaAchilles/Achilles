////////////////////////////////////////////////////////////////////
//DeRap: Produced from mikero's Dos Tools Dll version 5.24
//Produced on Tue Jul 12 15:08:02 2016 : Created on Tue Jul 12 15:08:02 2016
//http://dev-heaven.net/projects/list_files/mikero-pbodll
////////////////////////////////////////////////////////////////////

#define _ARMA_

//Class ares_zeusExtensions : config.bin{
class BIS_AddonInfo
{
	author = "76561198313323281";
	timepacked = "1468294896";
};
class CfgPatches
{
	class Ares
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Anton Struyk";
		authorUrl = "https://github.com/astruyk/";
		version = "1.8.1";
		versionStr = "1.8.1";
		versionAr[] = {1,8,1};
		units[] = {"Ares_Module_Arsenal_AddCustom","Ares_Module_Arsenal_Copy_To_Clipboard","Ares_Module_Arsenal_Paste_Replace","Ares_Module_Arsenal_Paste_Combine","Ares_Module_Arsenal_Create_Nato","Ares_Module_Arsenal_Create_Csat","Ares_Module_Arsenal_Create_Aaf","Ares_Module_Arsenal_Create_Guerilla","Ares_Module_Behaviour_Patrol","Ares_Module_Behaviour_Search_Nearby_And_Garrison","Ares_Module_Behaviour_Search_Nearby_Building","Ares_Module_Equipment_Lights","Ares_Module_Equipment_Nvgs","Ares_Module_Equipment_Thermals","Ares_Module_Execute_Code","Ares_Module_Garrison_Nearest","Ares_Module_Reinforcements_Create_Lz","Ares_Module_Reinforcements_Create_Rp","Ares_Module_Reinforcements_Spawn_Units","Ares_Module_Spawn_Submarine","Ares_Module_Spawn_Trawler","Ares_Module_SurrenderSingleUnit","Ares_Module_UnGarrison","Ares_Module_Teleport","Ares_Module_Add_Remove_Editable_Objects","Ares_Module_Zeus_Visibility","Ares_Module_Hint","Ares_Module_Switch_Side","Ares_Module_Change_Player_Side","Ares_Module_Create_Teleporter","Ares_Module_Spawn_Effects","Ares_Module_Spawn_Intel","Ares_Module_Arsenal_AddFull","Ares_Module_Create_Mission_SQF","Ares_Module_Spawn_Advanced_Composition","Ares_Module_Spawn_Explosives","ModulePunishment_F","Ares_Module_Manage_Advanced_Compositions"};
		requiredAddons[] = {"A3_UI_F","A3_UI_F_Curator","A3_Functions_F","A3_Functions_F_Curator","A3_Modules_F","A3_Modules_F_Curator"};
	};
	class Achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = "0.0.2";
		versionStr = "0.0.2";
		versionAr[] = {0,0,2};
		units[] = {"Achilles_Module_ACE_Injury","Achilles_Module_ACE_Heal","Achilles_Module_Animation","Achilles_Module_Chatter","Achilles_Module_Sit_On_Chair","Achilles_Module_Change_Ability","Achilles_Module_Bind_Variable","Achilles_Module_Set_Weather","Achilles_Module_Earthquake","Achilles_Module_Artillery_Fire_Mission","Achilles_Module_Fire_Support_Create_Artillery_Target","Achilles_Module_Suppressive_Fire","Achilles_Module_Fire_Support_Create_Suppression_Target","Achilles_Module_Buildings_Destroy","Achilles_Module_Toggle_Simulation","Achilles_Module_Attach_To","Achilles_Module_Set_Height"};
		requiredAddons[] = {"A3_UI_F","A3_UI_F_Curator","A3_Functions_F","A3_Functions_F_Curator","A3_Modules_F","A3_Modules_F_Curator"};
	};
	class AchillesEffects
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = "0.0.1";
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
		units[] = {"ModuleLightSource_F","ModuleLightSourceWhite_F","ModuleLightSourceBlue_F","ModuleLightSourceRed_F","ModuleLightSourceGreen_F","ModuleLightSourceYellow_F","ModulePersistentSmokePillar_F","ModulePersistentSmokePillar000_F","ModulePersistentSmokePillar001_F","ModulePersistentSmokePillar002_F","ModulePersistentSmokePillar003_F","ModulePersistentSmokePillar004_F","ModulePersistentSmokePillar005_F","ModulePersistentSmokePillar006_F","ModulePersistentSmokePillar007_F","ModulePersistentSmokePillar008_F"};
		requiredAddons[] = {"A3_Modules_F"};
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
	class Ares_Module_Base: Module_F
	{
		mapSize = 1;
		author = "Anton Struyk";
		vehicleClass = "Modules";
		category = "Ares";
		subCategory = "Behaviours";
		side = 7;
		scope = 1;
		scopeCurator = 1;
		displayName = "Ares Module Base";
		icon = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		picture = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		function = "";
		functionPriority = 1;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		class Arguments{};
		class ModuleDescription: ModuleDescription
		{
			description = "Ares Module Base";
		};
	};
	class Ares_Arsenal_Module_Base: Ares_Module_base
	{
		subCategory = "$STR_ARSENAL";
	};
	class Ares_Behaviours_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_AI_BEHAVIOUR";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	class Ares_Dev_Tools_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_DEV_TOOLS";
	};
	class Ares_Equipment_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_EQUIPMENT";
	};
	class Ares_Reinforcements_Module_base: Ares_Module_Base
	{
		subCategory = "$STR_REINFORCEMENTS";
	};
	class Ares_SaveLoad_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_SAVE_LOAD";
	};
	class Ares_Spawn_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_SPAWN";
	};
	class Ares_User_Defined_Module_Base: Ares_Module_Base
	{
		category = "User Defined";
		subCategory = "";
	};
	class Ares_Zeus_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_ZEUS";
	};
	class Ares_Player_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_PLAYER";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	class Achilles_ACE_Module_Base: Ares_Module_Base
	{
		subCategory = "ACE";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	class Achilles_Environment_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_ENVIRONMENT";
	};
	class Achilles_Fire_Support_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_FIRE_SUPPORT";
	};
	class Achilles_Buildings_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_BUILDINGS";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		picture = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Achilles_Objects_Module_Base: Ares_Module_Base
	{
		subCategory = "$STR_OBJECTS";
	};
	class Ares_Module_Empty: Ares_Module_Base
	{
		category = "Curator";
		subCategory = "";
		mapSize = 0;
		displayName = "Ares Module Empty";
		function = "Ares_fnc_Empty";
	};
	class Ares_Module_SurrenderSingleUnit: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SURRENDER_UNIT";
		function = "Ares_fnc_SurrenderUnits";
	};
	class Ares_Module_Garrison_Nearest: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_GARRISON_INSTANT";
		function = "Ares_fnc_GarrisonNearest";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Ares_Module_UnGarrison: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_UN_GARRISON";
		function = "Ares_fnc_UnGarrison";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Ares_Module_Behaviour_Search_Nearby_Building: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SEARCH_BUILDING";
		function = "Ares_fnc_BehaviourSearchNearbyBuilding";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Ares_Module_Behaviour_Search_Nearby_And_Garrison: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SEARCH_AND_GARRISON_BUILDING";
		function = "Ares_fnc_BehaviourSearchNearbyAndGarrison";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Ares_Module_Behaviour_Patrol: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_PATROL";
		function = "Ares_fnc_BehaviourPatrol";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Ares_Module_Equipment_Nvgs: Ares_Equipment_Module_Base
	{
		scopeCurator = 2;
		displayName = "Add/Remove NVG's";
		function = "Ares_fnc_EquipmentNvgs";
	};
	class Ares_Module_Equipment_Thermals: Ares_Equipment_Module_Base
	{
		scopeCurator = 2;
		displayName = "Add/Remove Thermals";
		function = "Ares_fnc_EquipmentThermals";
	};
	class Ares_Module_Equipment_Lights: Ares_Equipment_Module_Base
	{
		scopeCurator = 2;
		displayName = "Lights On/Off";
		function = "Ares_fnc_EquipmentLights";
	};
	class Ares_Module_Spawn_Submarine: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "Submarine";
		function = "Ares_fnc_SpawnSubmarine";
	};
	class Ares_Module_Spawn_Trawler: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "Trawler";
		function = "Ares_fnc_SpawnTrawler";
	};
	class Ares_Module_Spawn_Effects: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SPAWN_EFFECT";
		function = "Ares_fnc_SpawnEffect";
	};
	class Ares_Module_Spawn_Intel: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_EDIT_INTEL";
		function = "Ares_fnc_SpawnCreateEditIntel";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
	};
	class Ares_Module_Spawn_Advanced_Composition: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADVANCED_COMPOSITION";
		function = "Ares_fnc_SpawnAdvancedCompositions";
	};
	class Ares_Module_Spawn_Explosives: Ares_Spawn_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_MINES_EXPLOSIVES";
		function = "Ares_fnc_SpawnExplosives";
	};
	class Ares_Module_Arsenal_AddFull: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADD_FULL";
		function = "Ares_fnc_ArsenalAddFull";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Ares_Module_Arsenal_AddCustom: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADD_FILTERED";
		function = "Ares_fnc_ArsenalAddCustom";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Ares_Module_Arsenal_Copy_To_Clipboard: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_COPY_TO_CLIPBOARD";
		function = "Ares_fnc_ArsenalCopyToClipboard";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Ares_Module_Arsenal_Paste_Replace: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_PASTE_N_REPLACE";
		function = "Ares_fnc_ArsenalPasteReplace";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Ares_Module_Arsenal_Paste_Combine: Ares_Arsenal_Module_base
	{
		scopeCurator = 2;
		displayName = "$STR_PASTE_N_COMBINE";
		function = "Ares_fnc_ArsenalPasteCombine";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Ares_Module_Arsenal_Create_Nato: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_BASIC_NATO";
		function = "Ares_fnc_ArsenalCreateNato";
	};
	class Ares_Module_Arsenal_Create_Csat: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_BASIC_CSAT";
		function = "Ares_fnc_ArsenalCreateCsat";
	};
	class Ares_Module_Arsenal_Create_Aaf: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_BASIC_AAF";
		function = "Ares_fnc_ArsenalCreateAaf";
	};
	class Ares_Module_Arsenal_Create_Guerilla: Ares_Arsenal_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_BASIC_GUERILLA";
		function = "Ares_fnc_ArsenalCreateGuerilla";
	};
	class Ares_Module_Reinforcements_Create_Lz: Ares_Reinforcements_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_NEW_LZ";
		function = "Ares_fnc_ReinforcementsCreateLz";
		icon = "\ares_zeusExtensions\Ares\data\icon_lz.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_lz.paa";
	};
	class Ares_Module_Reinforcements_Create_Rp: Ares_Reinforcements_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_NEW_RP";
		function = "Ares_fnc_ReinforcementsCreateRp";
		icon = "\ares_zeusExtensions\Ares\data\icon_rp.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_rp.paa";
	};
	class Ares_Module_Reinforcements_Spawn_Units: Ares_Reinforcements_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SPAWN_UNITS";
		function = "Ares_fnc_ReinforcementsCreateUnits";
	};
	class Ares_Module_Add_Remove_Editable_Objects: Ares_Zeus_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADD_REMOVE_EDITABLE_OBJECTS";
		function = "Ares_fnc_ZeusAddRemoveEditableObjects";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Ares_Module_Zeus_Visibility: Ares_Zeus_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_HIDE_ZEUS";
		function = "Ares_fnc_ZeusVisibility";
		icon = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_default.paa";
	};
	class Ares_Module_Hint: Ares_Zeus_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_Hint";
		function = "Ares_fnc_ZeusHint";
		icon = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_default.paa";
	};
	class Ares_Module_Switch_Side: Ares_Zeus_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SWITCH_SIDE_CHANNEL_OF_ZEUS";
		function = "Ares_fnc_ZeusSwitchSideChannel";
		icon = "\ares_zeusExtensions\Ares\data\icon_default.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_default.paa";
	};
	class Ares_Module_User_Defined_0: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 0";
		function = "Ares_fnc_UserDefinedModule0";
	};
	class Ares_Module_User_Defined_1: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 1";
		function = "Ares_fnc_UserDefinedModule1";
	};
	class Ares_Module_User_Defined_2: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 2";
		function = "Ares_fnc_UserDefinedModule2";
	};
	class Ares_Module_User_Defined_3: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 3";
		function = "Ares_fnc_UserDefinedModule3";
	};
	class Ares_Module_User_Defined_4: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 4";
		function = "Ares_fnc_UserDefinedModule4";
	};
	class Ares_Module_User_Defined_5: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 5";
		function = "Ares_fnc_UserDefinedModule5";
	};
	class Ares_Module_User_Defined_6: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 6";
		function = "Ares_fnc_UserDefinedModule6";
	};
	class Ares_Module_User_Defined_7: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 7";
		function = "Ares_fnc_UserDefinedModule7";
	};
	class Ares_Module_User_Defined_8: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 8";
		function = "Ares_fnc_UserDefinedModule8";
	};
	class Ares_Module_User_Defined_9: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 9";
		function = "Ares_fnc_UserDefinedModule9";
	};
	class Ares_Module_User_Defined_10: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 10";
		function = "Ares_fnc_UserDefinedModule10";
	};
	class Ares_Module_User_Defined_11: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 11";
		function = "Ares_fnc_UserDefinedModule11";
	};
	class Ares_Module_User_Defined_12: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 12";
		function = "Ares_fnc_UserDefinedModule12";
	};
	class Ares_Module_User_Defined_13: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 13";
		function = "Ares_fnc_UserDefinedModule13";
	};
	class Ares_Module_User_Defined_14: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 14";
		function = "Ares_fnc_UserDefinedModule14";
	};
	class Ares_Module_User_Defined_15: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 15";
		function = "Ares_fnc_UserDefinedModule15";
	};
	class Ares_Module_User_Defined_16: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 16";
		function = "Ares_fnc_UserDefinedModule16";
	};
	class Ares_Module_User_Defined_17: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 17";
		function = "Ares_fnc_UserDefinedModule17";
	};
	class Ares_Module_User_Defined_18: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 18";
		function = "Ares_fnc_UserDefinedModule18";
	};
	class Ares_Module_User_Defined_19: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 19";
		function = "Ares_fnc_UserDefinedModule19";
	};
	class Ares_Module_User_Defined_20: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 20";
		function = "Ares_fnc_UserDefinedModule20";
	};
	class Ares_Module_User_Defined_21: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 21";
		function = "Ares_fnc_UserDefinedModule21";
	};
	class Ares_Module_User_Defined_22: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 22";
		function = "Ares_fnc_UserDefinedModule22";
	};
	class Ares_Module_User_Defined_23: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 23";
		function = "Ares_fnc_UserDefinedModule23";
	};
	class Ares_Module_User_Defined_24: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 24";
		function = "Ares_fnc_UserDefinedModule24";
	};
	class Ares_Module_User_Defined_25: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 25";
		function = "Ares_fnc_UserDefinedModule25";
	};
	class Ares_Module_User_Defined_26: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 26";
		function = "Ares_fnc_UserDefinedModule26";
	};
	class Ares_Module_User_Defined_27: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 27";
		function = "Ares_fnc_UserDefinedModule27";
	};
	class Ares_Module_User_Defined_28: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 28";
		function = "Ares_fnc_UserDefinedModule28";
	};
	class Ares_Module_User_Defined_29: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 29";
		function = "Ares_fnc_UserDefinedModule29";
	};
	class Ares_Module_User_Defined_30: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 30";
		function = "Ares_fnc_UserDefinedModule30";
	};
	class Ares_Module_User_Defined_31: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 31";
		function = "Ares_fnc_UserDefinedModule31";
	};
	class Ares_Module_User_Defined_32: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 32";
		function = "Ares_fnc_UserDefinedModule32";
	};
	class Ares_Module_User_Defined_33: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 33";
		function = "Ares_fnc_UserDefinedModule33";
	};
	class Ares_Module_User_Defined_34: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 34";
		function = "Ares_fnc_UserDefinedModule34";
	};
	class Ares_Module_User_Defined_35: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 35";
		function = "Ares_fnc_UserDefinedModule35";
	};
	class Ares_Module_User_Defined_36: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 36";
		function = "Ares_fnc_UserDefinedModule36";
	};
	class Ares_Module_User_Defined_37: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 37";
		function = "Ares_fnc_UserDefinedModule37";
	};
	class Ares_Module_User_Defined_38: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 38";
		function = "Ares_fnc_UserDefinedModule38";
	};
	class Ares_Module_User_Defined_39: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 39";
		function = "Ares_fnc_UserDefinedModule39";
	};
	class Ares_Module_User_Defined_40: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 40";
		function = "Ares_fnc_UserDefinedModule40";
	};
	class Ares_Module_User_Defined_41: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 41";
		function = "Ares_fnc_UserDefinedModule41";
	};
	class Ares_Module_User_Defined_42: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 42";
		function = "Ares_fnc_UserDefinedModule42";
	};
	class Ares_Module_User_Defined_43: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 43";
		function = "Ares_fnc_UserDefinedModule43";
	};
	class Ares_Module_User_Defined_44: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 44";
		function = "Ares_fnc_UserDefinedModule44";
	};
	class Ares_Module_User_Defined_45: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 45";
		function = "Ares_fnc_UserDefinedModule45";
	};
	class Ares_Module_User_Defined_46: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 46";
		function = "Ares_fnc_UserDefinedModule46";
	};
	class Ares_Module_User_Defined_47: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 47";
		function = "Ares_fnc_UserDefinedModule47";
	};
	class Ares_Module_User_Defined_48: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 48";
		function = "Ares_fnc_UserDefinedModule48";
	};
	class Ares_Module_User_Defined_49: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 49";
		function = "Ares_fnc_UserDefinedModule49";
	};
	class Ares_Module_User_Defined_50: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 50";
		function = "Ares_fnc_UserDefinedModule50";
	};
	class Ares_Module_User_Defined_51: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 51";
		function = "Ares_fnc_UserDefinedModule51";
	};
	class Ares_Module_User_Defined_52: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 52";
		function = "Ares_fnc_UserDefinedModule52";
	};
	class Ares_Module_User_Defined_53: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 53";
		function = "Ares_fnc_UserDefinedModule53";
	};
	class Ares_Module_User_Defined_54: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 54";
		function = "Ares_fnc_UserDefinedModule54";
	};
	class Ares_Module_User_Defined_55: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 55";
		function = "Ares_fnc_UserDefinedModule55";
	};
	class Ares_Module_User_Defined_56: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 56";
		function = "Ares_fnc_UserDefinedModule56";
	};
	class Ares_Module_User_Defined_57: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 57";
		function = "Ares_fnc_UserDefinedModule57";
	};
	class Ares_Module_User_Defined_58: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 58";
		function = "Ares_fnc_UserDefinedModule58";
	};
	class Ares_Module_User_Defined_59: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 59";
		function = "Ares_fnc_UserDefinedModule59";
	};
	class Ares_Module_User_Defined_60: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 60";
		function = "Ares_fnc_UserDefinedModule60";
	};
	class Ares_Module_User_Defined_61: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 61";
		function = "Ares_fnc_UserDefinedModule61";
	};
	class Ares_Module_User_Defined_62: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 62";
		function = "Ares_fnc_UserDefinedModule62";
	};
	class Ares_Module_User_Defined_63: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 63";
		function = "Ares_fnc_UserDefinedModule63";
	};
	class Ares_Module_User_Defined_64: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 64";
		function = "Ares_fnc_UserDefinedModule64";
	};
	class Ares_Module_User_Defined_65: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 65";
		function = "Ares_fnc_UserDefinedModule65";
	};
	class Ares_Module_User_Defined_66: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 66";
		function = "Ares_fnc_UserDefinedModule66";
	};
	class Ares_Module_User_Defined_67: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 67";
		function = "Ares_fnc_UserDefinedModule67";
	};
	class Ares_Module_User_Defined_68: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 68";
		function = "Ares_fnc_UserDefinedModule68";
	};
	class Ares_Module_User_Defined_69: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 69";
		function = "Ares_fnc_UserDefinedModule69";
	};
	class Ares_Module_User_Defined_70: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 70";
		function = "Ares_fnc_UserDefinedModule70";
	};
	class Ares_Module_User_Defined_71: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 71";
		function = "Ares_fnc_UserDefinedModule71";
	};
	class Ares_Module_User_Defined_72: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 72";
		function = "Ares_fnc_UserDefinedModule72";
	};
	class Ares_Module_User_Defined_73: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 73";
		function = "Ares_fnc_UserDefinedModule73";
	};
	class Ares_Module_User_Defined_74: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 74";
		function = "Ares_fnc_UserDefinedModule74";
	};
	class Ares_Module_User_Defined_75: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 75";
		function = "Ares_fnc_UserDefinedModule75";
	};
	class Ares_Module_User_Defined_76: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 76";
		function = "Ares_fnc_UserDefinedModule76";
	};
	class Ares_Module_User_Defined_77: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 77";
		function = "Ares_fnc_UserDefinedModule77";
	};
	class Ares_Module_User_Defined_78: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 78";
		function = "Ares_fnc_UserDefinedModule78";
	};
	class Ares_Module_User_Defined_79: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 79";
		function = "Ares_fnc_UserDefinedModule79";
	};
	class Ares_Module_User_Defined_80: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 80";
		function = "Ares_fnc_UserDefinedModule80";
	};
	class Ares_Module_User_Defined_81: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 81";
		function = "Ares_fnc_UserDefinedModule81";
	};
	class Ares_Module_User_Defined_82: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 82";
		function = "Ares_fnc_UserDefinedModule82";
	};
	class Ares_Module_User_Defined_83: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 83";
		function = "Ares_fnc_UserDefinedModule83";
	};
	class Ares_Module_User_Defined_84: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 84";
		function = "Ares_fnc_UserDefinedModule84";
	};
	class Ares_Module_User_Defined_85: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 85";
		function = "Ares_fnc_UserDefinedModule85";
	};
	class Ares_Module_User_Defined_86: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 86";
		function = "Ares_fnc_UserDefinedModule86";
	};
	class Ares_Module_User_Defined_87: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 87";
		function = "Ares_fnc_UserDefinedModule87";
	};
	class Ares_Module_User_Defined_88: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 88";
		function = "Ares_fnc_UserDefinedModule88";
	};
	class Ares_Module_User_Defined_89: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 89";
		function = "Ares_fnc_UserDefinedModule89";
	};
	class Ares_Module_User_Defined_90: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 90";
		function = "Ares_fnc_UserDefinedModule90";
	};
	class Ares_Module_User_Defined_91: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 91";
		function = "Ares_fnc_UserDefinedModule91";
	};
	class Ares_Module_User_Defined_92: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 92";
		function = "Ares_fnc_UserDefinedModule92";
	};
	class Ares_Module_User_Defined_93: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 93";
		function = "Ares_fnc_UserDefinedModule93";
	};
	class Ares_Module_User_Defined_94: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 94";
		function = "Ares_fnc_UserDefinedModule94";
	};
	class Ares_Module_User_Defined_95: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 95";
		function = "Ares_fnc_UserDefinedModule95";
	};
	class Ares_Module_User_Defined_96: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 96";
		function = "Ares_fnc_UserDefinedModule96";
	};
	class Ares_Module_User_Defined_97: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 97";
		function = "Ares_fnc_UserDefinedModule97";
	};
	class Ares_Module_User_Defined_98: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 98";
		function = "Ares_fnc_UserDefinedModule98";
	};
	class Ares_Module_User_Defined_99: Ares_User_Defined_Module_Base
	{
		scopeCurator = 2;
		displayName = "User Defined Module 99";
		function = "Ares_fnc_UserDefinedModule99";
	};
	class B_AssaultPack_Base;
	class B_Bergen_Base;
	class B_Carryall_Base;
	class B_FieldPack_Base;
	class B_Kitbag_Base;
	class B_TacticalPack_Base;
	class B_AssaultPack_mcamo: B_AssaultPack_Base
	{
		side = 1;
	};
	class B_Bergen_mcamo: B_Bergen_Base
	{
		side = 1;
	};
	class B_Carryall_mcamo: B_Carryall_Base
	{
		side = 1;
	};
	class B_Kitbag_mcamo: B_Kitbag_Base
	{
		side = 1;
	};
	class B_TacticalPack_mcamo: B_TacticalPack_Base
	{
		side = 1;
	};
	class B_AssaultPack_ocamo: B_AssaultPack_Base
	{
		side = 0;
	};
	class B_Carryall_ocamo: B_Carryall_Base
	{
		side = 0;
	};
	class B_Carryall_oucamo: B_Carryall_Base
	{
		side = 0;
	};
	class B_FieldPack_ocamo: B_FieldPack_Base
	{
		side = 0;
	};
	class B_FieldPack_oucamo: B_FieldPack_Base
	{
		side = 0;
	};
	class B_TacticalPack_ocamo: B_TacticalPack_Base
	{
		side = 0;
	};
	class B_AssaultPack_dgtl: B_AssaultPack_Base
	{
		side = 2;
	};
	class Ares_Module_Execute_Code: Ares_Dev_Tools_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_EXECUTE_CODE";
		function = "Ares_fnc_ExecuteCode";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
	};
	class Ares_Module_Create_Mission_SQF: Ares_Dev_Tools_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_COPY_MISSION_SQF";
		function = "Ares_fnc_CreateMissionSQF";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Ares_Module_Manage_Advanced_Compositions: Ares_Dev_Tools_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADVANCED_COMPOSITION";
		function = "Ares_fnc_DevTools_manageAdvancedCompositions";
	};
	class Ares_Module_Teleport: Ares_Player_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_TELEPORT";
		function = "Ares_fnc_PlayerTeleport";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Ares_Module_Create_Teleporter: Ares_Player_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_TP";
		function = "Ares_fnc_PlayerCreateTeleporter";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Ares_Module_Change_Player_Side: Ares_Player_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CHANGE_SIDE_OF_PLAYER";
		function = "Ares_fnc_PlayerChangeSide";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	class ModuleBootcampStage_F: Module_F{};
	class ModulePunishment_F: ModuleBootcampStage_F
	{
		category = "Ares";
		subCategory = "$STR_PLAYER";
	};
	class Achilles_Module_Animation: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_AMBIENT_ANIMATION";
		function = "Achilles_fnc_BehaviourAnimation";
	};
	class Achilles_Module_Chatter: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CHATTER";
		function = "Achilles_fnc_BehaviourChatter";
	};
	class Achilles_Module_Sit_On_Chair: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SIT_ON_CHAIR";
		function = "Achilles_fnc_BehaviourSitOnChair";
		icon = "\ares_zeusExtensions\Achilles\data\icon_chair.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_chair.paa";
	};
	class Achilles_Module_Change_Ability: Ares_Behaviours_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CHANGE_ABILITIES";
		function = "Achilles_fnc_BehaviourChangeAbility";
	};
	class Achilles_Module_ACE_Injury: Achilles_ACE_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_INJURY";
		function = "Achilles_fnc_ACEInjury";
	};
	class Achilles_Module_ACE_Heal : Achilles_ACE_Module_Base
	{
		scopeCurator = 2;
		displayName = "Heal";
		function = "Achilles_fnc_ACEHeal";
	};
	class Achilles_Module_Bind_Variable: Ares_Dev_Tools_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_BIND_VAR";
		function = "Achilles_fnc_DevToolsBindVariable";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Achilles_Module_Set_Weather: Achilles_Environment_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ADVANCED_WEATHER_CHANGE";
		function = "Achilles_fnc_EnvironmentSetWeatherModule";
		icon = "\a3\Modules_F_Curator\Data\portraitWeather_ca.paa";
		portrait = "\a3\Modules_F_Curator\Data\portraitWeather_ca.paa";
	};
	class Achilles_Module_Earthquake: Achilles_Environment_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_EARTHQUAKE";
		function = "Achilles_fnc_EnvironmentEarthquake";
		icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
	};
	class Achilles_Module_Artillery_Fire_Mission: Achilles_Fire_Support_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ARTILLERY_FIRE_MISSION";
		function = "Achilles_fnc_FireSupportArtilleryFireMission";
		icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
	};
	class Achilles_Module_Suppressive_Fire: Achilles_Fire_Support_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_SUPPRESIVE_FIRE";
		function = "Achilles_fnc_FireSupportSuppressiveFire";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_unit.paa";
	};
	class Achilles_Module_Fire_Support_Create_Artillery_Target: Achilles_Fire_Support_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_ARTILLERY_TARGET";
		function = "Achilles_fnc_FireSupportCreateArtilleryTarget";
		icon = "\ares_zeusExtensions\Ares\data\icon_artillery_target.paa";
		portrait = "\ares_zeusExtensions\Ares\data\icon_artillery_target.paa";
	};
	class Achilles_Module_Fire_Support_Create_Suppression_Target: Achilles_Fire_Support_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CREATE_SUPPRESSION_TARGET";
		function = "Achilles_fnc_FireSupportCreateSuppressionTarget";
		icon = "\ares_zeusExtensions\Achilles\data\icon_target.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_target.paa";
	};
	class Achilles_Module_Buildings_Destroy: Achilles_Buildings_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_DESTROY_BUILDINGS";
		function = "Achilles_fnc_BuildingsDestroy";
	};
	class Achilles_Module_Toggle_Simulation: Achilles_Objects_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_TOGGLE_SIMULATION";
		function = "Achilles_fnc_ObjectsToggleSimulation";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
	};
	class Achilles_Module_Attach_To: Achilles_Objects_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_ATTACH_TO";
		function = "Achilles_fnc_ObjectsAttachTo";
		icon = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_object.paa";
	};
	class Achilles_Module_Set_Height: Achilles_Objects_Module_Base
	{
		scopeCurator = 2;
		displayName = "$STR_CHANGE_HEIGHT";
		function = "Achilles_fnc_ObjectsSetHeight";
		icon = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
		portrait = "\ares_zeusExtensions\Achilles\data\icon_default_object.paa";
	};
	class ModuleLightSource_F: Module_F
	{
		author = "Kex";
		mapSize = 1;
		vehicleClass = "Modules";
		_generalMacro = "ModuleLightSource_F";
		side = 7;
		scope = 2;
		scopeCurator = 1;
		icon = "\a3\Modules_F_Curator\Data\iconFlare_ca.paa";
		portrait = "\a3\Modules_F_Curator\Data\portraitFlareWhite_ca.paa";
		displayName = "$STR_LIGHT_SOURCE";
		category = "Effects";
		function = "Achilles_fnc_ModuleLightSource";
		functionPriority = 1;
		is3DEN = 1;
		isGlobal = 2;
		isTriggerActivated = 1;
		class Arguments
		{
			class Type
			{
				displayName = "$STR_TYPE";
				description = "$STR_TYPE";
				class values
				{
					class White
					{
						default = 1;
						name = "$STR_WHITE_LIGHT";
						value = "white";
					};
					class Blue
					{
						name = "$STR_BLUE_LIGHT";
						value = "blue";
					};
					class Green
					{
						name = "$STR_GREEN_LIGHT";
						value = "green";
					};
					class Red
					{
						name = "$STR_RED_LIGHT";
						value = "red";
					};
					class Yellow
					{
						name = "$STR_YELLOW_LIGHT";
						value = "yellow";
					};
				};
			};
		};
		class ModuleDescription: ModuleDescription
		{
			description = "Achilles Light Source Module";
		};
	};
	class ModuleLightSourceWhite_F: ModuleLightSource_F
	{
		_generalMacro = "ModuleLightSourceWhite_F";
		displayName = "$STR_WHITE_LIGHT";
		color = "white";
		scope = 1;
	};
	class ModuleLightSourceBlue_F: ModuleLightSource_F
	{
		_generalMacro = "ModuleLightSourceBlue_F";
		displayName = "$STR_BLUE_LIGHT";
		color = "blue";
		scope = 1;
	};
	class ModuleLightSourceRed_F: ModuleLightSource_F
	{
		_generalMacro = "ModuleLightSourceRed_F";
		displayName = "$STR_RED_LIGHT";
		color = "red";
		scope = 1;
	};
	class ModuleLightSourceGreen_F: ModuleLightSource_F
	{
		_generalMacro = "ModuleLightSourceGreen_F";
		displayName = "$STR_GREEN_LIGHT";
		color = "green";
		scope = 1;
	};
	class ModuleLightSourceYellow_F: ModuleLightSource_F
	{
		_generalMacro = "ModuleLightSourceYellow_F";
		displayName = "$STR_YELLOW_LIGHT";
		color = "yellow";
		scope = 1;
	};
	class ModulePersistentSmokePillar_F: Module_F
	{
		author = "Kex";
		mapSize = 1;
		vehicleClass = "Modules";
		_generalMacro = "ModulePersistentSmokePillar_F";
		side = 7;
		scope = 2;
		scopeCurator = 1;
		icon = "\a3\Modules_F_Curator\Data\iconSmoke_ca.paa";
		portrait = "\a3\Modules_F_Curator\Data\portraitSmokeWhite_ca.paa";
		displayName = "$STR_PERSISTENT_SMOKE_PILLAR";
		category = "Effects";
		function = "Achilles_fnc_ModulePersistentSmokePillar";
		functionPriority = 1;
		is3DEN = 1;
		isGlobal = 2;
		isTriggerActivated = 1;
		class Arguments
		{
			class Type
			{
				displayName = "$STR_TYPE";
				description = "$STR_TYPE";
				typeName = "NUMBER";
				class values
				{
					class Smoke000
					{
						default = 1;
						name = "$STR_VEHICLE_FIRE";
						value = 0;
					};
					class Smoke001
					{
						name = "$STR_SMALL_OILY_SMOKE";
						value = 1;
					};
					class Smoke002
					{
						name = "$STR_MEDIUM_OILY_SMOKE";
						value = 2;
					};
					class Smoke003
					{
						name = "$STR_LARGE_OILY_SMOKE";
						value = 3;
					};
					class Smoke004
					{
						name = "$STR_SMALL_WOOD_SMOKE";
						value = 4;
					};
					class Smoke005
					{
						name = "$STR_MEDIUM_WOOD_SMOKE";
						value = 5;
					};
					class Smoke006
					{
						name = "$STR_LARGE_WOOD_SMOKE";
						value = 6;
					};
					class Smoke007
					{
						name = "$STR_SMALL_MIXED_SMOKE";
						value = 7;
					};
					class Smoke008
					{
						name = "$STR_LARGE_MIXED_SMOKE";
						value = 8;
					};
				};
			};
		};
		class ModuleDescription: ModuleDescription
		{
			description = "Achilles Light Source Module";
		};
	};
	class ModulePersistentSmokePillar000_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar000_F";
		displayName = "$STR_VEHICLE_FIRE";
		smokeType = 0;
		scope = 1;
	};
	class ModulePersistentSmokePillar001_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar001_F";
		displayName = "$STR_SMALL_OILY_SMOKE";
		smokeType = 1;
		scope = 1;
	};
	class ModulePersistentSmokePillar002_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar002_F";
		displayName = "$STR_MEDIUM_OILY_SMOKE";
		smokeType = 2;
		scope = 1;
	};
	class ModulePersistentSmokePillar003_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar003_F";
		displayName = "$STR_LARGE_OILY_SMOKE";
		smokeType = 3;
		scope = 1;
	};
	class ModulePersistentSmokePillar004_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar004_F";
		displayName = "$STR_SMALL_WOOD_SMOKE";
		smokeType = 4;
		scope = 1;
	};
	class ModulePersistentSmokePillar005_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar005_F";
		displayName = "$STR_MEDIUM_WOOD_SMOKE";
		smokeType = 5;
		scope = 1;
	};
	class ModulePersistentSmokePillar006_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar006_F";
		displayName = "$STR_LARGE_WOOD_SMOKE";
		smokeType = 6;
		scope = 1;
	};
	class ModulePersistentSmokePillar007_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar007_F";
		displayName = "$STR_SMALL_MIXED_SMOKE";
		smokeType = 7;
		scope = 1;
	};
	class ModulePersistentSmokePillar008_F: ModulePersistentSmokePillar_F
	{
		_generalMacro = "ModulePersistentSmokePillar008_F";
		displayName = "$STR_LARGE_MIXED_SMOKE";
		smokeType = 8;
		scope = 1;
	};
	class ModuleAnimals_F: Module_F
	{
		class Arguments
		{
			class Type
			{
				class values
				{
					class Turtles
					{
						name = "Turtles";
						value = "Turtle_F";
					};
					class Snakes
					{
						name = "Snakes";
						value = "Snake_random_F";
					};
					class Rabbits
					{
						name = "Rabbits";
						value = "Rabbit_F";
					};
					class CatSharks
					{
						name = "$STR_RED_LIGHT";
						value = "red";
					};
					class Tunas
					{
						name = "Tunas";
						value = "yellow";
					};
				};
			};
		};
	};
};
class CfgFunctions
{
	class Ares
	{
		class init
		{
			file = "\ares_zeusExtensions\Ares\functions\init";
			class InitAres
			{
				preInit = 1;
			};
		};
		class events
		{
			file = "\ares_zeusExtensions\Ares\functions\events";
			class OnModuleTreeLoad;
			class HandleCuratorObjectPlaced;
			class HandleCuratorObjectDoubleClicked;
			class HandleCuratorKeyPressed;
			class HandleCuratorKeyReleased;
			class HandleRemoteKeyPressed;
		};
		class util
		{
			file = "\ares_zeusExtensions\Ares\functions";
			class AddUnitsToCurator;
			class AppendToModuleTree;
			class ArsenalSetup;
			class BroadcastCode;
			class CompositionGrabber;
			class CreateLogic;
			class GenerateArsenalBlacklist;
			class GenerateArsenalDataList;
			class GetArrayDataFromUser;
			class GetFarthest;
			class GetGroupUnderCursor;
			class GetNearest;
			class GetPhoneticName;
			class GetSafePos;
			class GetUnitUnderCursor;
			class IsZeus;
			class LogMessage;
			class MakePlayerInvisible;
			class MonitorCuratorDisplay;
			class SearchBuilding;
			class ShowChooseDialog;
			class ShowZeusMessage;
			class StringContains;
			class TeleportPlayers;
			class WaitForZeus;
			class ZenOccupyHouse;
			class addIntel;
		};
		class ui
		{
			file = "\ares_zeusExtensions\Ares\ui\functions";
			class RscDisplayAttributes_selectPlayers;
			class RscDisplayAttributes_Create_Reinforcement;
			class RscDisplayAttributes_BuildingsDestroy;
			class RscDisplayAtttributes_SpawnEffect;
			class RscDisplayAttributes_SpawnAdvancedComposition;
			class RscDisplayAttributes_manageAdvancedComposition;
			class RscDisplayAttributes_createAdvancedComposition;
			class RscDisplayAttributes_SpawnExplosives;
			class RscDisplayAttributes_editAdvancedComposition;
		};
		class modules
		{
			file = "\ares_zeusExtensions\Ares\modules";
			class Empty;
		};
		class ArsenalModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Arsenal";
			class ArsenalAddCustom{};
			class ArsenalCopyToClipboard{};
			class ArsenalCreateAaf{};
			class ArsenalCreateCsat{};
			class ArsenalCreateGuerilla{};
			class ArsenalCreateNato{};
			class ArsenalPasteCombine{};
			class ArsenalPasteReplace{};
			class ArsenalAddFull{};
		};
		class BehaviourModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Behaviours";
			class BehaviourLandHelicopter{};
			class BehaviourPatrol{};
			class BehaviourSearchNearbyAndGarrison{};
			class BehaviourSearchNearbyBuilding{};
			class GarrisonNearest{};
			class SurrenderUnits{};
			class UnGarrison{};
		};
		class EquipmentModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Equipment";
			class EquipmentLights{};
			class EquipmentNvgs{};
			class EquipmentThermals{};
		};
		class DevToolModules
		{
			file = "\ares_zeusExtensions\Ares\modules\DevTools";
			class ExecuteCode{};
			class CreateMissionSQF{};
			class DevTools_manageAdvancedCompositions{};
		};
		class PlayerModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Player";
			class PlayerTeleport{};
			class PlayerCreateTeleporter{};
			class PlayerChangeSide{};
		};
		class ReinforcementsModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Reinforcements";
			class ReinforcementsCreateLz{};
			class ReinforcementsCreateRp{};
			class ReinforcementsCreateUnits{};
		};
		class SpawnModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Spawn";
			class SpawnSubmarine;
			class SpawnTrawler;
			class SpawnEffect;
			class SpawnCreateEditIntel;
			class SpawnAdvancedCompositions;
			class SpawnExplosives;
		};
		class ZeusModules
		{
			file = "\ares_zeusExtensions\Ares\modules\Zeus";
			class ZeusAddRemoveEditableObjects{};
			class ZeusVisibility{};
			class ZeusHint{};
			class ZeusSwitchSideChannel{};
		};
		class CustomModuleFunctions
		{
			file = "\ares_zeusExtensions\Ares\functions\customModules";
			class ExecuteCustomModuleCode;
			class RegisterCustomModule;
		};
		class CustomModules
		{
			file = "\ares_zeusExtensions\Ares\modules\userDefined";
			class UserDefinedModule0;
			class UserDefinedModule1;
			class UserDefinedModule2;
			class UserDefinedModule3;
			class UserDefinedModule4;
			class UserDefinedModule5;
			class UserDefinedModule6;
			class UserDefinedModule7;
			class UserDefinedModule8;
			class UserDefinedModule9;
			class UserDefinedModule10;
			class UserDefinedModule11;
			class UserDefinedModule12;
			class UserDefinedModule13;
			class UserDefinedModule14;
			class UserDefinedModule15;
			class UserDefinedModule16;
			class UserDefinedModule17;
			class UserDefinedModule18;
			class UserDefinedModule19;
			class UserDefinedModule20;
			class UserDefinedModule21;
			class UserDefinedModule22;
			class UserDefinedModule23;
			class UserDefinedModule24;
			class UserDefinedModule25;
			class UserDefinedModule26;
			class UserDefinedModule27;
			class UserDefinedModule28;
			class UserDefinedModule29;
			class UserDefinedModule30;
			class UserDefinedModule31;
			class UserDefinedModule32;
			class UserDefinedModule33;
			class UserDefinedModule34;
			class UserDefinedModule35;
			class UserDefinedModule36;
			class UserDefinedModule37;
			class UserDefinedModule38;
			class UserDefinedModule39;
			class UserDefinedModule40;
			class UserDefinedModule41;
			class UserDefinedModule42;
			class UserDefinedModule43;
			class UserDefinedModule44;
			class UserDefinedModule45;
			class UserDefinedModule46;
			class UserDefinedModule47;
			class UserDefinedModule48;
			class UserDefinedModule49;
			class UserDefinedModule50;
			class UserDefinedModule51;
			class UserDefinedModule52;
			class UserDefinedModule53;
			class UserDefinedModule54;
			class UserDefinedModule55;
			class UserDefinedModule56;
			class UserDefinedModule57;
			class UserDefinedModule58;
			class UserDefinedModule59;
			class UserDefinedModule60;
			class UserDefinedModule61;
			class UserDefinedModule62;
			class UserDefinedModule63;
			class UserDefinedModule64;
			class UserDefinedModule65;
			class UserDefinedModule66;
			class UserDefinedModule67;
			class UserDefinedModule68;
			class UserDefinedModule69;
			class UserDefinedModule70;
			class UserDefinedModule71;
			class UserDefinedModule72;
			class UserDefinedModule73;
			class UserDefinedModule74;
			class UserDefinedModule75;
			class UserDefinedModule76;
			class UserDefinedModule77;
			class UserDefinedModule78;
			class UserDefinedModule79;
			class UserDefinedModule80;
			class UserDefinedModule81;
			class UserDefinedModule82;
			class UserDefinedModule83;
			class UserDefinedModule84;
			class UserDefinedModule85;
			class UserDefinedModule86;
			class UserDefinedModule87;
			class UserDefinedModule88;
			class UserDefinedModule89;
			class UserDefinedModule90;
			class UserDefinedModule91;
			class UserDefinedModule92;
			class UserDefinedModule93;
			class UserDefinedModule94;
			class UserDefinedModule95;
			class UserDefinedModule96;
			class UserDefinedModule97;
			class UserDefinedModule98;
			class UserDefinedModule99;
		};
	};
	class Achilles
	{
		class util
		{
			file = "\ares_zeusExtensions\Achilles\functions";
			class SelectUnits;
			class map;
			class filter;
			class sum;
			class sideTab;
			class TextToVariableName;
			class HigherConfigHierarchyLevel;
			class ClassNamesWhichInheritsFromCfgClass;
			class chute;
			class eject_passengers;
			class LaunchCM;
			class CopyObjectsToClipboard;
			class PasteObjectsFromClipboard;
			class Animation;
			class Chatter;
			class changeAbility;
			class SwitchZeusSide;
			class ambientAnim;
			class ambientAnimGetParams;
			class ACS_toggleGrouping;
		};
		class ACEModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\ACE";
			class ACEInjury{};
			class ACEHeal {};
		};
		class BehaviourModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\Behaviours";
			class BehaviourAnimation{};
			class BehaviourChatter{};
			class BehaviourSitOnChair{};
			class BehaviourChangeAbility{};
		};
		class DevToolsModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\DevTools";
			class DevToolsBindVariable{};
		};
		class EnvironmentModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\Environment";
			class EnvironmentSetWeatherModule{};
			class EnvironmentEarthquake{};
		};
		class FireSupportModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\FireSupport";
			class FireSupportArtilleryFireMission{};
			class FireSupportSuppressiveFire{};
			class FireSupportCreateArtilleryTarget{};
			class FireSupportCreateSuppressionTarget{};
		};
		class BuildingsModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\Buildings";
			class BuildingsDestroy{};
		};
		class EffectModules
		{
			file = "\ares_zeusExtensions\Achilles\functions";
			class moduleLightSource{};
			class modulePersistentSmokePillar{};
			class spawnSmoke{};
		};
		class ObjectsModules
		{
			file = "\ares_zeusExtensions\Achilles\modules\Objects";
			class ObjectsToggleSimulation{};
			class ObjectsAttachTo{};
			class ObjectsSetHeight{};
		};
	};
};
class CfgGroups
{

	#include "Compositions\compositions.hpp"
};
class CfgWeapons
{
	class H_HelmetB;
	class H_Beret_blk;
	class H_Cap_red;
	class H_Bandanna_surfer;
	class H_Booniehat_khk;
	class H_MilCap_oucamo;
	class Vest_Camo_Base;
	class Vest_NoCamo_Base;
	class Rifle_Base_F;
	class Launcher_Base_F;
	class Rifle_Long_Base_F;
	class HelmetBase;
	class V_TacVest_camo;
	class H_MilCap_ocamo: H_HelmetB
	{
		side = 0;
	};
	class H_Bandanna_mcamo: H_Bandanna_surfer
	{
		side = 1;
	};
	class H_Beret_02: H_Beret_blk
	{
		side = 1;
	};
	class H_Beret_grn_SF: H_Beret_blk
	{
		side = 1;
	};
	class H_Booniehat_mcamo: H_Booniehat_khk
	{
		side = 1;
	};
	class H_Cap_khaki_specops_UK: H_Cap_red
	{
		side = 1;
	};
	class H_Cap_tan_specops_US: H_Cap_red
	{
		side = 1;
	};
	class H_Cap_usblack: H_Cap_red
	{
		side = 1;
	};
	class H_CrewHelmetHeli_B: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_black: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_camo: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_desert: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_grass: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_light: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_paint: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_plain_mcamo: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_sand: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetB_snakeskin: H_HelmetB
	{
		side = 1;
	};
	class H_HelmetCrew_B: H_HelmetB
	{
		side = 1;
	};
	class H_Helmet_Kerry: H_HelmetB
	{
		side = 1;
	};
	class H_MilCap_mcamo: H_MilCap_ocamo
	{
		side = 1;
	};
	class H_PilotHelmetFighter_B: H_HelmetB
	{
		side = 1;
	};
	class H_PilotHelmetHeli_B: H_HelmetB
	{
		side = 1;
	};
	class V_PlateCarrier1_blk: Vest_Camo_Base
	{
		side = 1;
	};
	class V_PlateCarrier1_rgr: Vest_NoCamo_Base
	{
		side = 1;
	};
	class V_PlateCarrier3_rgr: Vest_NoCamo_Base
	{
		side = 1;
	};
	class V_PlateCarrierGL_rgr: Vest_NoCamo_Base
	{
		side = 1;
	};
	class V_PlateCarrierSpec_rgr: Vest_NoCamo_Base
	{
		side = 1;
	};
	class V_RebreatherB: Vest_Camo_Base
	{
		side = 1;
	};
	class V_I_G_resistanceLeader_F: V_TacVest_camo
	{
		side = 1;
	};
	class arifle_MX_Base_F: Rifle_Base_F
	{
		side = 1;
	};
	class EBR_base_F: Rifle_Long_Base_F
	{
		side = 1;
	};
	class H_Beret_ocamo: H_Beret_blk
	{
		side = 0;
	};
	class H_Cap_brn_SPECOPS: H_Cap_red
	{
		side = 0;
	};
	class H_CrewHelmetHeli_O: H_CrewHelmetHeli_B
	{
		side = 0;
	};
	class H_HelmetCrew_O: H_HelmetCrew_B
	{
		side = 0;
	};
	class H_HelmetO_ocamo: H_HelmetB
	{
		side = 0;
	};
	class H_PilotHelmetFighter_O: H_PilotHelmetFighter_B
	{
		side = 0;
	};
	class H_PilotHelmetHeli_O: H_PilotHelmetHeli_B
	{
		side = 0;
	};
	class V_HarnessO_brn: Vest_NoCamo_Base
	{
		side = 0;
	};
	class V_HarnessOGL_brn: Vest_NoCamo_Base
	{
		side = 0;
	};
	class V_RebreatherIR: V_RebreatherB
	{
		side = 0;
	};
	class arifle_Katiba_Base_F: Rifle_Base_F
	{
		side = 0;
	};
	class launch_RPG32_F: Launcher_Base_F
	{
		side = 0;
	};
	class LMG_Zafir_F: Rifle_Long_Base_F
	{
		side = 0;
	};
	class DMR_01_base_F: Rifle_Long_Base_F
	{
		side = 0;
	};
	class GM6_base_F: Rifle_Long_Base_F
	{
		side = 0;
	};
	class H_Booniehat_dgtl: H_Booniehat_khk
	{
		side = 2;
	};
	class H_Cap_blk_Raven: H_Cap_red
	{
		side = 2;
	};
	class H_CrewHelmetHeli_I: H_CrewHelmetHeli_B
	{
		side = 2;
	};
	class H_HelmetCrew_I: H_HelmetCrew_B
	{
		side = 2;
	};
	class H_HelmetIA: H_HelmetB
	{
		side = 2;
	};
	class H_MilCap_dgtl: H_MilCap_oucamo
	{
		side = 2;
	};
	class H_PilotHelmetFighter_I: H_PilotHelmetFighter_B
	{
		side = 2;
	};
	class H_PilotHelmetHeli_I: H_PilotHelmetHeli_B
	{
		side = 2;
	};
	class V_PlateCarrierIA1_dgtl: Vest_NoCamo_Base
	{
		side = 2;
	};
	class V_RebreatherIA: V_RebreatherB
	{
		side = 2;
	};
	class mk20_base_F: Rifle_Base_F
	{
		side = 2;
	};
	class Tavor_base_F: Rifle_Base_F
	{
		side = 2;
	};
	class LMG_Mk200_F: Rifle_Long_Base_F
	{
		side = 2;
	};
	class LRR_base_F: Rifle_Long_Base_F
	{
		side = 1;
	};
	class H_Bandanna_surfer_blk: H_Bandanna_surfer
	{
		side = 3;
	};
	class H_Bandanna_surfer_grn: H_Bandanna_surfer
	{
		side = 3;
	};
	class H_Beret_blk_POLICE: H_Beret_blk
	{
		side = 3;
	};
	class H_Cap_police: H_Cap_red
	{
		side = 3;
	};
	class H_Cap_press: H_Cap_red
	{
		side = 3;
	};
	class H_Cap_surfer: H_Cap_red
	{
		side = 3;
	};
	class H_RacingHelmet_1_F: H_HelmetB_camo
	{
		side = 3;
	};
	class H_StrawHat: H_HelmetB
	{
		side = 3;
	};
	class V_Press_F: Vest_Camo_Base
	{
		side = 3;
	};
};
class IGUIBack;
class RscFrame;
class RscEdit;
class RscText;
class RscToolbox;
class RscCombo;
class RscButton;
class RscButtonMenu;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscButtonImages;
class RscSlider;
class RscXSliderH;
class RscControlsGroup;
class RscMapControl;
class RscActivePicture;
class RscPicture;
class RscTree;
class Ares_CopyPaste_Dialog
{
	idd = 123;
	movingEnable = 0;
	onLoad = "((_this select 0) displayCtrl 1400) ctrlSetText (uiNamespace getVariable ['Ares_CopyPaste_Dialog_Text', '']);";
	onUnload = "uiNamespace setVariable ['Ares_CopyPaste_Dialog_Text', ctrlText ((_this select 0) displayCtrl 1400)];";
	class controls
	{
		class Ares_Title: RscText
		{
			idc = 1000;
			text = "$STR_COPY_PASTE_DIALOG";
			x = "2 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "38 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = "1.2 * (0.04)";
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;
			x = "0 * (0.025)+ (0)";
			y = "1.5 * (0.04)+ (0)";
			w = "40 * (0.025)";
			h = "20.5 * (0.04)";
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;
			x = "7 * (0.025)+ (0)";
			y = "20 * (0.04)+ (0)";
			w = "28 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_CopyPaste_Dialog_Result', 1]; closeDialog 1;";
			idc = 3000;
			x = "35.5 * (0.025)+ (0)";
			y = "20 * (0.04)+ (0)";
			w = "4 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_CopyPaste_Dialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = "0.5 * (0.025)+ (0)";
			y = "20 * (0.04)+ (0)";
			w = "6 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;
			x = "0.5 * (0.025)+ (0)";
			y = "2 * (0.04)+ (0)";
			w = "39 * (0.025)";
			h = "17 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;
			text = "$STR_COPY_PASTE_CLIPBOARD_CONTENTS_USING_KEYS";
			x = "1 * (0.025)+ (0)";
			y = "2 * (0.04)+ (0)";
			w = "39 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_Edit: RscEdit
		{
			idc = 1400;
			style = 16;
			linespacing = 1;
			default = 1;
			autocomplete = "scripting";
			x = "1 * (0.025)+ (0)";
			y = "3.5 * (0.04)+ (0)";
			w = "38 * (0.025)";
			h = "15 * (0.04)";
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;
			x = "0 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;
			style = 48;
			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = "0.2 * (0.025)+ (0)";
			y = "0.15 * (0.04)+ (0)";
			w = "1.6 * (0.025)";
			h = "1.2 * (0.04)";
		};
	};
};
class Ares_ExecuteCode_Dialog
{
	idd = 123;
	movingEnable = 0;
	onLoad = "((_this select 0) displayCtrl 1400) ctrlSetText (uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Text', '']);";
	onUnload = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Text', ctrlText ((_this select 0) displayCtrl 1400)];";
	class controls
	{
		class Ares_Title: RscText
		{
			idc = 1000;
			text = "$STR_EXECUTE_CODE";
			x = "2 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "38 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = "1.2 * (0.04)";
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;
			x = "0 * (0.025)+ (0)";
			y = "1.5 * (0.04)+ (0)";
			w = "40 * (0.025)";
			h = "22.5 * (0.04)";
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;
			x = "7 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "28 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', 1]; closeDialog 1;";
			idc = 3000;
			x = "35.5 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "4 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = "0.5 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "6 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Dialog_Paragraph_Combo: RscText
		{
			idc = 1010;
			text = "Mode:";
			x = "0.5 * (0.025)+ (0)";
			y = "19.5 * (0.04)+ (0)";
			w = "39 * (0.025)";
			h = "2 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Dialog_Combo: RscCombo
		{
			onLBSelChanged = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Constraint', _this select 1];";
			idc = 4000;
			x = "16 * (0.025)+ (0)";
			y = "20 * (0.04)+ (0)";
			w = "22.5 * (0.025)";
			h = "1 * (0.04)";
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;
			x = "0.5 * (0.025)+ (0)";
			y = "2 * (0.04)+ (0)";
			w = "39 * (0.025)";
			h = "17 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;
			text = "$STR_WRITE_OR_PASTE_CODE";
			x = "1 * (0.025)+ (0)";
			y = "2 * (0.04)+ (0)";
			w = "39 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_Edit: RscEdit
		{
			idc = 1400;
			style = 16;
			linespacing = 1;
			default = 1;
			autocomplete = "scripting";
			x = "1 * (0.025)+ (0)";
			y = "3.5 * (0.04)+ (0)";
			w = "38 * (0.025)";
			h = "15 * (0.04)";
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;
			x = "0 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;
			style = 48;
			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = "0.2 * (0.025)+ (0)";
			y = "0.15 * (0.04)+ (0)";
			w = "1.6 * (0.025)";
			h = "1.2 * (0.04)";
		};
	};
};
class Ares_Dynamic_Dialog
{
	idd = 133798;
	movingEnable = 0;
	class controls
	{
		class Ares_Title: RscText
		{
			idc = 1000;
			text = "Execute Code";
			x = "2 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "38 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = "1.2 * (0.04)";
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;
			x = "0 * (0.025)+ (0)";
			y = "1.5 * (0.04)+ (0)";
			w = "40 * (0.025)";
			h = "22.5 * (0.04)";
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;
			x = "7 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "28 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', 1]; closeDialog 1;";
			idc = 3000;
			x = "35.5 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "4 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = "0.5 * (0.025)+ (0)";
			y = "22 * (0.04)+ (0)";
			w = "6 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;
			x = "0 * (0.025)+ (0)";
			y = "0 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;
			style = 48;
			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = "0.2 * (0.025)+ (0)";
			y = "0.15 * (0.04)+ (0)";
			w = "1.6 * (0.025)";
			h = "1.2 * (0.04)";
		};
	};
};
class Ares_composition_Dialog
{
	idd = 133799;
	movingEnable = 0;
	class controls
	{
		class Ares_Title: RscText
		{
			idc = 1000;
			text = "$STR_ADVANCED_COMPOSITION";
			x = "9.5 * (0.025)+ (0)";
			y = "0.5 * (0.04)+ (0)";
			w = "24 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = "1.2 * (0.04)";
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;
			x = "7.5 * (0.025)+ (0)";
			y = "2 * (0.04)+ (0)";
			w = "26 * (0.025)";
			h = "20.5 * (0.04)";
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;
			x = "14.5 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "11 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			idc = 3010;
			onButtonClick = "uiNamespace setVariable ['Ares_Dialog_Result', -1]; closeDialog 2;";
			x = "8 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "6 * (0.025)";
			h = "1.5 * (0.04)";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class RscButtonMenuOK: RscButtonMenuOK
		{
			idc = 3000;
			onButtonClick = "uiNamespace setVariable ['Ares_Dialog_Result', 1]; closeDialog 1;";
			text = "$STR_SPAWN";
			x = "26 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "7 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;
			x = "8 * (0.025)+ (0)";
			y = "2.5 * (0.04)+ (0)";
			w = "25 * (0.025)";
			h = "17 * (0.04)";
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;
			text = "Select composition to edit or delete.";
			x = "8 * (0.025)+ (0)";
			y = "2.5 * (0.04)+ (0)";
			w = "25.5 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_composition_tree: RscTree
		{
			idc = 1400;
			expandOnDoubleclick = 1;
			colorMarked[] = {1,1,1,0.35};
			colorMarkedSelected[] = {1,1,1,0.7};
			x = "8.5 * (0.025)+ (0)";
			y = "4 * (0.04)+ (0)";
			w = "24 * (0.025)";
			h = "15 * (0.04)";
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;
			x = "7.5 * (0.025)+ (0)";
			y = "0.5 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;
			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = "7.5 * (0.025)+ (0)";
			y = "0.5 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_Delete_Button: RscActivePicture
		{
			idc = 3020;
			onButtonClick = "([""DELETE_BUTTON""] + _this) call Ares_fnc_RscDisplayAttributes_manageAdvancedComposition;";
			soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
			soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
			text = "a3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
			x = "31 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_Edit_Button: Ares_Delete_Button
		{
			idc = 3030;
			onButtonClick = "([""EDIT_BUTTON""] + _this) call Ares_fnc_RscDisplayAttributes_manageAdvancedComposition;";
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
			x = "28.5 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
		};
		class Ares_New_Button: Ares_Delete_Button
		{
			idc = 3040;
			onButtonClick = "([""NEW_BUTTON""] + _this) call Ares_fnc_RscDisplayAttributes_manageAdvancedComposition;";
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_add_ca.paa";
			x = "26 * (0.025)+ (0)";
			y = "20.5 * (0.04)+ (0)";
			w = "2 * (0.025)";
			h = "1.5 * (0.04)";
		};
	};
};
class cfgHints
{
	class Ares
	{
		displayName = "$STR_ARES_FIELD_MANUAL";
		class AresFieldManual
		{
			arguments[] = {};
			description = "$STR_ARES_FIELD_MANUAL_DESCRIPTION";
			displayName = "$STR_ARES_FIELD_MANUAL";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "";
		};
		class PlacingModules
		{
			arguments[] = {};
			description = "$STR_PLACING_MODULES_DESCRIPTION";
			displayName = "$STR_PLACING_MODULES";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "$STR_PLACING_MODULES_TIP";
		};
		class SelectionOption
		{
			arguments[] = {};
			description = "$STR_SELECTION_OPTION_DESCRIPTION";
			displayName = "$STR_SELECTION_OPTION";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "$STR_SELECTION_OPTION_TIP";
		};
		class KeyAssignment
		{
			arguments[] = {{{"launchCM"}}};
			description = "$STR_KEY_ASSIGNMENT_DESCRIPTION";
			displayName = "$STR_KEY_ASSIGNMENT";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "";
		};
		class ExecuteCode
		{
			arguments[] = {};
			description = "$STR_EXECUTE_CODE_DESCRIPTION";
			displayName = "$STR_EXECUTE_CODE";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "";
		};
		class RCvehicleCrew
		{
			arguments[] = {};
			description = "$STR_RC_VEHICLE_CREW_DESCRIPTION";
			displayName = "$STR_RC_VEHICLE_CREW";
			image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
			tip = "";
		};
	};
};
class cfgMusic
{
	class LeadTrack01a_F
	{
		duration = 74;
		musicClass = "Lead";
		name = "This is War - Part 1";
	};
	class LeadTrack01b_F
	{
		duration = 66;
		musicClass = "Lead";
		name = "This is War - Part 2";
	};
	class LeadTrack04a_F
	{
		musicClass = "Action";
	};
	class LeadTrack03_F_EPA
	{
		musicClass = "Action";
	};
	class LeadTrack02a_F_EPB
	{
		musicClass = "Action";
	};
	class LeadTrack01a_F_EPB
	{
		musicClass = "Action";
	};
	class LeadTrack02a_F_EPA
	{
		musicClass = "Action";
	};
	class LeadTrack02b_F_EPA
	{
		musicClass = "Action";
	};
	class Defcon
	{
		duration = 193;
		musicClass = "Stealth";
		name = "A2 EW - Defcon";
	};
	class SkyNet
	{
		duration = 233;
		musicClass = "Stealth";
		name = "A2 EW - Sky Net";
	};
	class Wasteland
	{
		duration = 194;
		musicClass = "Stealth";
		name = "A2 EW - Wasteland";
	};
	class Fallout
	{
		duration = 207;
		musicClass = "Stealth";
		name = "A2 EW - Fallout";
	};
	class Mad
	{
		duration = 198;
		musicClass = "Stealth";
		name = "A2 EW - Mad";
	};
	class AmbientTrack04a_F
	{
		musicClass = "Stealth";
	};
	class AmbientTrack01a_F
	{
		duration = 184;
		musicClass = "Stealth";
		name = "The East Wind - No Voice";
	};
	class LeadTrack06_F
	{
		musicClass = "Stealth";
	};
	class EventTrack01a_F_EPB
	{
		musicClass = "Stealth";
	};
	class BackgroundTrack01a_F
	{
		musicClass = "Calm";
	};
	class AmbientTrack03_F
	{
		musicClass = "Calm";
	};
	class BackgroundTrack03_F
	{
		musicClass = "Calm";
	};
};
class cfgWaypoints
{
	class Achilles
	{
		displayName = "Achilles";
		class Fastroping
		{
			displayName = "$STR_ACE_FASTROPING";
			displayNameDebug = "FASTROPING";
			file = "ares_zeusExtensions\Achilles\scripts\fn_wpFastrope.sqf";
			icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		};
		class Land
		{
			displayName = "$STR_A3_CfgWaypoints_Land";
			displayNameDebug = "LAND";
			file = "ares_zeusExtensions\Achilles\scripts\fn_wpLand.sqf";
			icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		};
		class SearchBuilding
		{
			displayName = "$STR_SEARCH_BUILDING";
			displayNameDebug = "SearchBuilding";
			file = "ares_zeusExtensions\Achilles\scripts\fn_wpSearchBuilding.sqf";
			icon = "\ares_zeusExtensions\Achilles\data\icon_position.paa";
		};
	};
};
class CfgScriptPaths
{
	AresDisplays = "\ares_zeusExtensions\Ares\ui\scripts\";
};
class RscControlsGroupNoScrollbars;
class RscAttributeOwners: RscControlsGroupNoScrollbars{};
class RscDisplayAttributes
{
	class Controls
	{
		class ButtonCustom: RscButtonMenu{};
		class ButtonCustomLeft: RscButtonMenu
		{
			idc = 30005;
			x = "18.3 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (safezoneX + (safezoneW -      ((safezoneW / safezoneH) min 1.2))/2)";
			y = "16.1 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY + (safezoneH -      (   ((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCustomLeftBelow: RscButtonMenu
		{
			idc = 30006;
			x = "18.3 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (safezoneX + (safezoneW -      ((safezoneW / safezoneH) min 1.2))/2)";
			y = "17.2 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY + (safezoneH -      (   ((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCustomBelow: RscButtonMenu
		{
			idc = 30007;
			x = "23.4 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (safezoneX + (safezoneW -      ((safezoneW / safezoneH) min 1.2))/2)";
			y = "17.2 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY + (safezoneH -      (   ((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};
class RscDisplayAttributesVehicle: RscDisplayAttributes
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call  (uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call  (uinamespace getvariable 'BIS_fnc_initDisplay')";
	class Controls: Controls
	{
		class ButtonBehaviour: ButtonCustom
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo: ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createdialog 'RscDisplayAttributesInventory'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonAmmo: ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonDamage: ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
	};
};
class RscDisplayAttributesVehicleEmpty: RscDisplayAttributes
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call  (uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call  (uinamespace getvariable 'BIS_fnc_initDisplay')";
	class Controls: Controls
	{
		class ButtonBehaviour: ButtonCustom
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo: ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createdialog 'RscDisplayAttributesInventory'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonAmmo: ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonDamage: ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
	};
};
class RscAttributeWaypointType: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeWaypointType"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	h = "8.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls
	{
		class Background: RscText
		{
			h = "7.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Value: RscToolbox
		{
			rows = 5;
			columns = 3;
			names[] = {"MOVE","CYCLE","SAD","HOLD","SENTRY","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""SearchBuilding""","GETOUT","UNLOAD","TR UNLOAD","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Land""","LOITER","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Fastroping""","HOOK","UNHOOK"};
			strings[] = {"$STR_ac_move","$STR_ac_cycle","$STR_ac_seekanddestroy","$STR_ac_hold","$STR_ac_sentry","$STR_SEARCH_BUILDING","$STR_ac_getout","$STR_ac_unload","$STR_ac_transportunload","$STR_A3_CfgWaypoints_Land","$STR_LOITER_HELI","$STR_ACE_FASTROPING","$STR_LIFT_CLOSEST","$STR_ac_unhook"};
			h = "7.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};
class CfgCurator
{
	class DrawWaypoint
	{
		class 3D
		{
			texture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			textureCycle = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
			texturePreview = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			colorNormal[] = {0.5,1.0,0.5,0.7};
			colorCycleNormal[] = {0.5,1.0,0.5,0.7};
		};
		class 2D
		{
			texture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			textureCycle = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
			texturePreview = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
		};
	};
};
class RscAttributeMusic: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeMusic"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};
//};
