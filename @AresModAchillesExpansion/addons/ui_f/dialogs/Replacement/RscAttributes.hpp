
// add 3 additional custom buttons to standard curator dialog
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
		class Content: RscControlsGroup 
		{
			class controls {};
		};
		
	};
};

// define class ammo for vehicles and units
class RscAttributeAmmo: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeAmmo"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	idc = 14775;
	x = "7 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls 
	{

		class Title: RscText 
		{
			idc = 13475;
			text = "$STR_AMMO";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Value: RscXSliderH 
		{
			idc = 14375;
			x = "10.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

// modify script

class RscAttributeRank: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeRank"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeSkill: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeSkill"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeFuel: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeFuel"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeDamage: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeDamage"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeLock: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeLock"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeUnitPos: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeUnitPos"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeFormation: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeFormation"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeSpeedMode: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeSpeedMode"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeRespawnVehicle : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeRespawnVehicle"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
};

class RscAttributeRespawnPosition: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeRespawnPosition"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";

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

// define class name

class RscAttributeName: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeName"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	idc = 119279;
	x = "7 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls 
	{

		class Title: RscText 
		{
			idc = 117979;
			text = "$STR_NAME";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Value: RscEdit 
		{
			idc = 118379;
			x = "10.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};


// define class head lights

class RscAttributeHeadlight: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeHeadlight"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	idc = 114725;
	x = "7 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
	y = "10 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	w = "26 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls 
	{

		class Title: RscText 
		{
			idc = 113427;
			text = "$STR_HEADLIGHT_SEARCHLIGHT";
			x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Background: RscText 
		{
			style = 2;
			idc = 113425;
			x = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "16 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1, 1, 1, 0.500000};
			colorBackground[] = {1, 1, 1, 0.100000};
		};

		class HeadlightOn: RscActivePicture 
		{
			idc = 113627;
			text = "achilles\data_f_achilles\icons\icon_headlightOn.paa";
			x = "16 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_SWITCH_ON";
		};

		class HeadlightOff: HeadlightOn
		{
			idc = 113630;
			text = "achilles\data_f_achilles\icons\icon_headlightOff.paa";
			x = "19.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_SWITCH_OFF";
		};
		
		class Default: HeadlightOn
		{
			idc = 123470;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			x = "24 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
		};
	};
};

// define combat modes for groups and waypoints
class RscAttributeCombatMode : RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeCombatMode"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	idc = 124569;
	x = "7 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
	y = "10 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	w = "26 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

	class controls {

		class Title: RscText 
		{
			idc = 123271;
			text = "$STR_disp_arcwp_semaphore";
			x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Background: RscText 
		{
			idc = 123269;
			x = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "16 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1, 1, 1, 0.100000};
		};

		class HoldFire: RscActivePicture 
		{
			idc = 123472;
			text = "achilles\data_f_achilles\icons\icon_hold_fire.paa";
			x = "11 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_HOLD_FIRE";
		};
		class HoldFireDefend : HoldFire
		{
			idc = 123471;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_defend.paa";
			x = "13.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_HOLD_FIRE_DEFEND";
		};

		class HoldFireEngage: HoldFire
		{
			idc = 123474;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_engage.paa";
			x = "16 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_HOLD_FIRE_ENGAGE";
		};

		class Fire: HoldFire
		{
			idc = 123475;
			text = "achilles\data_f_achilles\icons\icon_hold_fire.paa";
			x = "18.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_FIRE_AT_WILL";
		};

		class FireEngage: HoldFire
		{
			idc = 123469;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_engage.paa";
			x = "21 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_FIRE_ENGAGE";
		};

		class Default: HoldFire
		{
			idc = 123470;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			x = "24 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_combat_unchanged";
		};
	};
};

// implement careless option for groups and waypoints
class RscAttributeBehaviour: RscControlsGroupNoScrollbars 
{
	onSetFocus = "[_this,""RscAttributeBehaviour"",'AresDisplays'] call (uinamespace getvariable ""BIS_fnc_initCuratorAttribute"")";
	class controls 
	{
		class Title: RscText 
		{
			// correction: behaviour was named combat mode in vanilla
			text = "$STR_GROUP_BEHAVIOUR";
		};
		class Careless: RscActivePicture 
		{
			idc = 23472;
			text = "achilles\data_f_achilles\icons\icon_careless.paa";
			x = "11 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_CARELESS";
		};
	};
};
