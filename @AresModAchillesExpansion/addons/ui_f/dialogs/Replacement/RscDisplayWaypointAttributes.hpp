
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

// Change aviable waypoints in corresponding resource
class RscAttributeWaypointType: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeWaypointType"",'AresDisplays'] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";
	h = 8.5 * BIGUI_GRID_H_FIX;
	class controls
	{
		class Background: RscText 
		{
			h = 7.5 * BIGUI_GRID_H_FIX;
		};
		class Value: RscToolbox
		{
			rows = 6;
			columns = 3;
			names[] = {"MOVE","CYCLE","SAD","HOLD","SENTRY","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""SearchBuilding""","GETOUT","UNLOAD","TR UNLOAD","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Land""","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Fastroping""","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Paradrop""","HOOK","UNHOOK","configFile >> ""cfgWaypoints"" >> ""Achilles"" >> ""Repair""","configFile >> ""cfgWaypoints"" >> ""A3"" >> ""Demine"""};
			strings[] = {"$STR_ac_move","$STR_ac_cycle","$STR_ac_seekanddestroy","$STR_ac_hold","$STR_ac_sentry","$STR_AMAE_WP_SEARCH_BUILDING","$STR_ac_getout","$STR_ac_unload","$STR_ac_transportunload","$STR_A3_CfgWaypoints_Land","$STR_AMAE_FASTROPING","$STR_AMAE_PARADROP","$STR_AMAE_LIFT_CLOSEST","$STR_ac_unhook","$STR_AMAE_WP_REPAIR","$STR_A3_Functions_F_Orange_Demine"};
			h = 7.5 * BIGUI_GRID_H_FIX;
		};
	};
};

class RscAttributeWaypointTimeout: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeWaypointTimeout"",'AresDisplays'] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";
};

// include combat modes attribute
class RscDisplayAttributesWaypoint: RscDisplayAttributes
{
	scriptName = "RscDisplayAttributesWaypoint";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesWaypoint"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesWaypoint"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	
	class Controls: Controls 
	{
		class Content: Content 
		{
			class Controls: controls 
			{
				delete SpeedMode;
				
				class CombatMode: RscAttributeCombatMode {};
				class SpeedMode2: RscAttributeSpeedMode {};
			};
		};
	};
};

