//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/16/16
//	VERSION: 2.0
//	FILE: achilles\ui_f\dialogs\RscDisplayReplacement.hpp
//  DESCRIPTION: This is a replacement config for curator displays
//////////////////////////////////////////////////////////////////////////////////

//  define script paths

class CfgScriptPaths
{
	AresDisplays = "\achilles\ui_f\scripts\";
};

// load parent resources

class RscControlsGroupNoScrollbars;
class RscAttributeOwners : RscControlsGroupNoScrollbars {};

// include music from description.ext
class RscAttributeMusic : RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeMusic"",""AresDisplays""] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";	
};

// add display key event handlers to curator interface
class RscDisplayCurator 
{
	onLoad = "[_this select 0] call Achilles_fnc_onDisplayCuratorLoad;";
};

// add 3 additinal custom buttons to standard curator dialog
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

// assign custom buttons in vehicle edit interface
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
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
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
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonDamage : ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};

// assign custom buttons in empty vehicle edit interface
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
	onSetFocus = "[_this,""RscAttributeWaypointType"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	h = "8.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls
	{
		class Background: RscText 
		{
			h = "7.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Value: RscToolbox
		{
			rows = 5;
			columns = 3;
			names[] = {"MOVE","CYCLE","SAD","HOLD","SENTRY","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""SearchBuilding""","GETOUT","UNLOAD","TR UNLOAD","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Land""","LOITER","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Fastroping""","HOOK","UNHOOK"};
			strings[] = {"$STR_ac_move","$STR_ac_cycle","$STR_ac_seekanddestroy","$STR_ac_hold","$STR_ac_sentry","$STR_SEARCH_BUILDING","$STR_ac_getout","$STR_ac_unload","$STR_ac_transportunload","$STR_A3_CfgWaypoints_Land","$STR_LOITER_HELI","$STR_ACE_FASTROPING","$STR_LIFT_CLOSEST","$STR_ac_unhook"};
			h = "7.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

// replace Zeus waypoint icons by Eden waypoint icons
class CfgCurator 
{
	class DrawWaypoint 
	{
		class 3D 
		{
			texture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			textureCycle = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
			texturePreview = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			colorNormal[] = {0.500000, 1.000000, 0.500000, 0.700000};
			colorCycleNormal[] = {0.500000, 1.000000, 0.500000, 0.700000};
		};

		class 2D 
		{
			texture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
			textureCycle = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
			texturePreview = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
		};
	};
};
