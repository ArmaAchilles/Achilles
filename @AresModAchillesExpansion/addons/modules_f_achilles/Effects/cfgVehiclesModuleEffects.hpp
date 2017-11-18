/////////////////////////////////////////////////////////////////////////////////////////////
// 	AUTHOR: Kex
// 	DATE: 6/15/16
//	VERSION: 1.0
//	FILE: Achilles\congig\cfgVehiclesModuleEffects.hpp
//  DESCRIPTION: Add new effect modules
//	NOTE: The classes defined here are children of cfgVehicles
/////////////////////////////////////////////////////////////////////////////////////////////

class ModuleLightSource_F : Module_F
{
	author = "Kex";
	mapSize = 1;
	vehicleClass = "Modules";
	_generalMacro = "ModuleLightSource_F";
	side = 7;
	scope = 2;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
	scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.
	icon = "\a3\Modules_F_Curator\Data\iconFlare_ca.paa";					// Map icon. Delete this entry to use the default icon				
	portrait = "\a3\Modules_F_Curator\Data\portraitFlareWhite_ca.paa";		
	displayName = "$STR_LIGHT_SOURCE";				// Name displayed in the menu
	category = "Effects";
	function = "Achilles_fnc_ModuleLightSource";	// Name of function triggered once conditions are met
	functionPriority = 1;		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	is3DEN = 1;					// 1 to run init function in Eden Editor as well
	isGlobal = 2;				// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isTriggerActivated = 0;		// 1 for module waiting until all synced triggers are activated
	
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

class ModuleLightSourceWhite_F : ModuleLightSource_F 
{
	_generalMacro = "ModuleLightSourceWhite_F";
	displayName = "$STR_WHITE_LIGHT";
	color = "white";
	scope = 1;
};
class ModuleLightSourceBlue_F : ModuleLightSource_F 
{
	_generalMacro = "ModuleLightSourceBlue_F";
	displayName = "$STR_BLUE_LIGHT";
	color = "blue";
	scope = 1;
};
class ModuleLightSourceRed_F : ModuleLightSource_F 
{
	_generalMacro = "ModuleLightSourceRed_F";
	displayName = "$STR_RED_LIGHT";
	color = "red";
	scope = 1;
};
class ModuleLightSourceGreen_F : ModuleLightSource_F 
{
	_generalMacro = "ModuleLightSourceGreen_F";
	displayName = "$STR_GREEN_LIGHT";
	color = "green";
	scope = 1;
};
class ModuleLightSourceYellow_F : ModuleLightSource_F 
{
	_generalMacro = "ModuleLightSourceYellow_F";
	displayName = "$STR_YELLOW_LIGHT";
	color = "yellow";
	scope = 1;
};

class ModulePersistentSmokePillar_F : Module_F
{
	author = "Kex";
	mapSize = 1;
	vehicleClass = "Modules";
	_generalMacro = "ModulePersistentSmokePillar_F";
	side = 7;
	scope = 2;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
	scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.
	icon = "\a3\Modules_F_Curator\Data\iconSmoke_ca.paa";					// Map icon. Delete this entry to use the default icon				
	portrait = "\a3\Modules_F_Curator\Data\portraitSmokeWhite_ca.paa";
	displayName = "$STR_PERSISTENT_SMOKE_PILLAR";				// Name displayed in the menu
	category = "Effects";
	function = "Achilles_fnc_ModulePersistentSmokePillar";		// Name of function triggered once conditions are met
	functionPriority = 1;		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
	is3DEN = 1;					// 1 to run init function in Eden Editor as well
	isGlobal = 1;				// 0 for server only execution, 1 for global execution, 2 for persistent global execution
	isTriggerActivated = 0;		// 1 for module waiting until all synced triggers are activated
	
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
		description = "Achilles Persistent Smoke module";
	};
};

class ModulePersistentSmokePillar000_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar000_F";
	displayName = "$STR_VEHICLE_FIRE";
	smokeType = 0;
	scope = 1;
};
class ModulePersistentSmokePillar001_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar001_F";
	displayName = "$STR_SMALL_OILY_SMOKE";
	smokeType = 1;
	scope = 1;
};
class ModulePersistentSmokePillar002_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar002_F";
	displayName = "$STR_MEDIUM_OILY_SMOKE";
	smokeType = 2;
	scope = 1;
};
class ModulePersistentSmokePillar003_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar003_F";
	displayName = "$STR_LARGE_OILY_SMOKE";
	smokeType = 3;
	scope = 1;
};
class ModulePersistentSmokePillar004_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar004_F";
	displayName = "$STR_SMALL_WOOD_SMOKE";
	smokeType = 4;
	scope = 1;
};
class ModulePersistentSmokePillar005_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar005_F";
	displayName = "$STR_MEDIUM_WOOD_SMOKE";
	smokeType = 5;
	scope = 1;
};
class ModulePersistentSmokePillar006_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar006_F";
	displayName = "$STR_LARGE_WOOD_SMOKE";
	smokeType = 6;
	scope = 1;
};
class ModulePersistentSmokePillar007_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar007_F";
	displayName = "$STR_SMALL_MIXED_SMOKE";
	smokeType = 7;
	scope = 1;
};
class ModulePersistentSmokePillar008_F : ModulePersistentSmokePillar_F 
{
	_generalMacro = "ModulePersistentSmokePillar008_F";
	displayName = "$STR_LARGE_MIXED_SMOKE";
	smokeType = 8;
	scope = 1;
};
