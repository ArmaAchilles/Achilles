//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/6/16
//	VERSION: 1.0
//	FILE: Achilles\config\cfgFunctions.hpp 
//  DESCRIPTION: Define functions used in the modules
//	NOTE: The classes defined here are children of cfgFunctions
//////////////////////////////////////////////////////////////////////////////////


class Achilles // This bit will be prefixed when actually calling the function (e.g. "Achilles_fnc_...." )
{
	// Helper functions
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
	};
	
	// Module Functions
	#include "cfgFunctionsACE.hpp"
	#include "cfgFunctionsBehaviour.hpp"
	#include "cfgFunctionsDevTools.hpp"
	#include "cfgFunctionsEnvironment.hpp"
	#include "cfgFunctionsFireSupport.hpp"
	#include "cfgFunctionsBuildings.hpp"
	#include "cfgFunctionsEffects.hpp"
};
