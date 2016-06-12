//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\config\Rsc_config.hpp 
//  DESCRIPTION: Unlocks new waypoints for Zeus
//////////////////////////////////////////////////////////////////////////////////

//  define script paths

class CfgScriptPaths
{
	AresDisplays = "\ares_zeusExtensions\Ares\ui\";
};

// load parent resources

class RscControlsGroupNoScrollbars;
class RscAttributeOwners : RscControlsGroupNoScrollbars {};

class RscDisplayAttributes 
{
	class Controls
	{
		class ButtonCustom : RscButtonMenu {};
		class ButtonCustomLeft : RscButtonMenu 
		{
			idc = 30005;
			x = "18.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "16.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCustomLeftBelow : RscButtonMenu 
		{
			idc = 30006;
			x = "18.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "17.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCustomBelow : RscButtonMenu 
		{
			idc = 30007;
			x = "23.4 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "17.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};


// modify basic curator resources

class RscDisplayAttributesVehicle : RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";

	class Controls : Controls 
	{
		class ButtonBehaviour : ButtonCustom 
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo : ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createdialog 'RscDisplayAttributesInventory'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonAmmo : ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonDamage : ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};

class RscDisplayAttributesVehicleEmpty : RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";

	class Controls : Controls 
	{
		class ButtonBehaviour : ButtonCustom 
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo : ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createdialog 'RscDisplayAttributesInventory'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonAmmo : ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonDamage : ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};

// Change aviable waypoints in corresponding resource

class RscAttributeWaypointType: RscControlsGroupNoScrollbars
{
	class controls
	{				
		class Value: RscToolbox
		{
			names[] = {"MOVE","LOITER","%1/cfgWaypoints/Ares/Fastroping","%1/cfgWaypoints/A3/Land","GETOUT","UNLOAD","SAD"};
			strings[] = {"MOVE","LOITER (HELI)","ACE FAST-ROPING","LAND","GET OUT","UNLOAD","SEEK AND DESTROY"};
		};
	};
};

// load zeus dialog resources
//#include "cfgRscAchilles.hpp"