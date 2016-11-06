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

// couple achilles init with curator display
class RscDisplayCurator 
{
	onLoad = "[_this select 0] call Achilles_fnc_onDisplayCuratorLoad;";
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
class RscControlsGroupNoScrollbars;
class RscControlsGroupNoHScrollbars;
class RscAttributeOwners : RscControlsGroupNoScrollbars {};

// load external attributes
class RscAttributeRank : RscControlsGroupNoScrollbars {};
class RscAttributeDamage : RscControlsGroupNoScrollbars {};
class RscAttributeFuel : RscControlsGroupNoScrollbars {};
class RscAttributeLock : RscControlsGroupNoScrollbars {};
class RscAttributeExec : RscControlsGroupNoScrollbars {};
class RscAttributeGroupID: RscControlsGroupNoScrollbars {};
class RscAttributeFormation: RscControlsGroupNoScrollbars {};
class RscAttributeSpeedMode: RscControlsGroupNoScrollbars {};
class RscAttributeUnitPos: RscControlsGroupNoScrollbars {};
class RscAttributeRespawnVehicle : RscControlsGroupNoScrollbars {};
class RscAttributeRespawnPosition : RscControlsGroupNoScrollbars 
{
	class controls 
	{
		class Title: RscText {};
		class Background: RscText {};
		class West: RscActivePicture {};
		class East: West {};
		class Guer: West {};
		class Civ: West {};
		class Disabled: West {};
	};
};

// include modified attributes
#include "Replacement\RscAttributes.hpp"

// include modified dialogs and displays
#include "Replacement\RscDisplayAttributesMan.hpp"
#include "Replacement\RscDisplayAttributesVehicle.hpp"
#include "Replacement\RscDisplayAttributesGroup.hpp"
#include "Replacement\RscDisplayWaypointAttributes.hpp"

// include music from description.ext
class RscAttributeMusic : RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeMusic"",""AresDisplays""] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";	
};
