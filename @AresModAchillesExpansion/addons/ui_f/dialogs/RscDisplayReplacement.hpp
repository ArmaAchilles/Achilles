//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/16/16
//	VERSION: 2.0
//	FILE: ui_f\dialogs\RscDisplayReplacement.hpp
//  DESCRIPTION: This is a replacement config for curator displays
//////////////////////////////////////////////////////////////////////////////////

//  define script path for script replacement
class CfgScriptPaths
{
	AresDisplays = "\achilles\ui_f\scripts\";
};


class RscDisplayCurator 
{
	// couple achilles init with curator display
	onLoad = "[_this select 0] call Achilles_fnc_onDisplayCuratorLoad;";
	class Controls 
	{
		#include "Replacement\RscDisplayAttributesModuleTree.hpp"
	};
};

/*
class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay
{
	//onLoad = "createDisplay ""Ares_Welcome_Dialog"";";
	class Controls 
	{
		class AchillesIntroMessage : RscText
		{
			onLoad = "(ctrlparent (_this select 0)) createDisplay ""Ares_Welcome_Dialog"";";
		};
	};
};
*/
// load external resources
class RscAttributeOwners : RscControlsGroupNoScrollbars {};

// load external attributes
class RscAttributeExec : RscControlsGroupNoScrollbars {};
class RscAttributeGroupID: RscControlsGroupNoScrollbars {};

// include modified attributes
#include "Replacement\RscAttributes.hpp"
#include "Replacement\RscAttributeInventory.hpp"
#include "Replacement\RscAttributesModules.hpp"

// include modified dialogs and displays
#include "Replacement\RscDisplayAttributesMan.hpp"
#include "Replacement\RscDisplayAttributesVehicle.hpp"
#include "Replacement\RscDisplayAttributesGroup.hpp"
#include "Replacement\RscDisplayWaypointAttributes.hpp"

// include music from description.ext
class RscAttributeMusic : RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeMusic"",""AresDisplays""] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";	
};
