// add 3 additional custom buttons to standard curator dialog
class RscDisplayAttributes
{
	movingEnable = true;
	class Controls
	{
		class Title : RscText
		{
			moving = 1;
		};
		class Background : RscText {};

		class ButtonOK : RscButtonMenuOK {};
		class ButtonCancel : RscButtonMenuCancel {};

		class Content: RscControlsGroup
		{
			class controls {};
		};

		class ButtonCustom : RscButtonMenu {};
		class ButtonCustomLeft : ButtonCustom
		{
			idc = 30005;
			x = 18.3 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
			y = 16.1 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
			w = 5 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		class ButtonCustomLeftBelow : ButtonCustom
		{
			idc = 30006;
			x = 18.3 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
			y = 17.2 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
			w = 5 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		class ButtonCustomBelow : ButtonCustom
		{
			idc = 30007;
			x = 23.4 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
			y = 17.2 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
			w = 5 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		class ButtonCustomLeft2 : ButtonCustom
		{
			idc = 30008;
			x = 13.2 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
			y = 16.1 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
			w = 5 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		class ButtonCustomLeftBelow2 : ButtonCustom
		{
			idc = 30009;
			x = 13.2 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
			y = 17.2 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
			w = 5 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
	};
};

// define class ammo for vehicles and units
class RscAttributeAmmo: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeAmmo','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
	idc = 14775;
	x = 7 * BIGUI_GRID_W_FIX + (safezoneX);
	y = 10 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX);
	w = 26 * BIGUI_GRID_W_FIX;
	h = 1 * BIGUI_GRID_H_FIX;

	class controls
	{

		class Title: RscText
		{
			idc = 13475;
			text = "$STR_AMAE_AMMO";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 10 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Value: RscXSliderH
		{
			idc = 14375;
			x = 10.1 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 15.9 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
	};
};

// modify script

class RscAttributeRank: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeRank','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeSkill: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeSkill','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeFuel: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeFuel','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeDamage: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeDamage','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeLock: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeLock','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeUnitPos: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeUnitPos','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeFormation: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeFormation','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeSpeedMode: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeSpeedMode','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeRespawnVehicle : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeRespawnVehicle','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeGroupID2 : RscAttributeGroupID
{
	onSetFocus = "[_this,'RscAttributeGroupID2','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeRespawnPosition: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeRespawnPosition','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";

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
	onSetFocus = "[_this,'RscAttributeName','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
	idc = 119279;
	x = 7 * BIGUI_GRID_W_FIX + (safezoneX);
	y = 10 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX);
	w = 26 * BIGUI_GRID_W_FIX;
	h = 1 * BIGUI_GRID_H_FIX;

	class controls
	{

		class Title: RscText
		{
			idc = 117979;
			text = "$STR_AMAE_NAME";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 10 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Value: RscEdit
		{
			idc = 118379;
			x = 10.1 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 15.9 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
	};
};


// define class head lights

class RscAttributeHeadlight: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeHeadlight','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
	idc = 114725;
	x = 7 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
	y = 10 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
	w = 26 * BIGUI_GRID_W_FIX;
	h = 2.5 * BIGUI_GRID_H_FIX;

	class controls
	{

		class Title: RscText
		{
			idc = 113427;
			text = "$STR_AMAE_HEADLIGHT_SEARCHLIGHT";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 10 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Background: RscText
		{
			style = 2;
			idc = 113425;
			x = 10 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 16 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorText[] = {1, 1, 1, 0.500000};
			colorBackground[] = {1, 1, 1, 0.100000};
		};

		class HeadlightOn: RscActivePicture
		{
			idc = 113627;
			text = "achilles\data_f_achilles\icons\icon_headlightOn.paa";
			x = 16 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_SWITCH_ON";
		};

		class HeadlightOff: HeadlightOn
		{
			idc = 113630;
			text = "achilles\data_f_achilles\icons\icon_headlightOff.paa";
			x = 19.5 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_SWITCH_OFF";
		};

		class Default: HeadlightOn
		{
			idc = 123470;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			x = 24 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
		};
	};
};

class RscAttributeEngine: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeEngine','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
	idc = 114726;
	x = 7 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
	y = 10 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
	w = 26 * BIGUI_GRID_W_FIX;
	h = 2.5 * BIGUI_GRID_H_FIX;

	class controls
	{

		class Title: RscText
		{
			idc = 113427;
			text = "$STR_AMAE_ENGINE";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 10 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Background: RscText
		{
			style = 2;
			idc = 113426;
			x = 10 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 16 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorText[] = {1, 1, 1, 0.500000};
			colorBackground[] = {1, 1, 1, 0.100000};
		};

		class EngineOn: RscActivePicture
		{
			idc = 113628;
			text = "achilles\data_f_achilles\icons\icon_engineOn.paa";
			x = 16 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_SWITCH_ON";
		};

		class EngineOff: EngineOn
		{
			idc = 113631;
			text = "achilles\data_f_achilles\icons\icon_engineOff.paa";
			x = 19.5 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_SWITCH_OFF";
		};

		class Default: EngineOn
		{
			idc = 123471;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			x = 24 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
		};
	};
};

// define combat modes for groups and waypoints
class RscAttributeCombatMode : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeCombatMode','AresDisplays'] call (uinamespace getvariable 'Achilles_fnc_initCuratorAttribute')";
	idc = 124569;
	x = 7 * BIGUI_GRID_W_FIX + safezoneX + (safezoneW - 40 * BIGUI_GRID_W_FIX) / 2;
	y = 10 * BIGUI_GRID_H_FIX + safezoneY + (safezoneH - 25 * BIGUI_GRID_H_FIX) / 2;
	w = 26 * BIGUI_GRID_W_FIX;
	h = 2.5 * BIGUI_GRID_H_FIX;

	class controls {

		class Title: RscText
		{
			idc = 123271;
			text = "$STR_disp_arcwp_semaphore";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 10 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0, 0, 0, 0.500000};
		};

		class Background: RscText
		{
			idc = 123269;
			x = 10 * BIGUI_GRID_W_FIX;
			y = 0 * BIGUI_GRID_H_FIX;
			w = 16 * BIGUI_GRID_W_FIX;
			h = 2.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {1, 1, 1, 0.100000};
		};

		class HoldFire: RscActivePicture
		{
			idc = 123472;
			text = "achilles\data_f_achilles\icons\icon_hold_fire.paa";
			x = 11 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_HOLD_FIRE";
		};
		class HoldFireDefend : HoldFire
		{
			idc = 123471;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_defend.paa";
			x = 13.5 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_HOLD_FIRE_DEFEND";
		};

		class HoldFireEngage: HoldFire
		{
			idc = 123474;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_engage.paa";
			x = 16 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_HOLD_FIRE_ENGAGE";
		};

		class Fire: HoldFire
		{
			idc = 123475;
			text = "achilles\data_f_achilles\icons\icon_hold_fire.paa";
			x = 18.5 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_FIRE_AT_WILL";
		};

		class FireEngage: HoldFire
		{
			idc = 123469;
			text = "achilles\data_f_achilles\icons\icon_hold_fire_engage.paa";
			x = 21 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_FIRE_ENGAGE";
		};

		class Default: HoldFire
		{
			idc = 123470;
			text = "\a3\ui_f_curator\Data\default_ca.paa";
			x = 24 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_combat_unchanged";
		};
	};
};

// implement careless option for groups and waypoints
class RscAttributeBehaviour: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeBehaviour','AresDisplays'] call (uiNamespace getVariable 'Achilles_fnc_initCuratorAttribute')";
	class controls
	{
		class Title: RscText
		{
			// correction: behaviour was named combat mode in vanilla
			text = "$STR_AMAE_GROUP_BEHAVIOUR";
		};
		class Careless: RscActivePicture
		{
			idc = 23472;
			text = "achilles\data_f_achilles\icons\icon_careless.paa";
			x = 11 * BIGUI_GRID_W_FIX;
			y = 0.5 * BIGUI_GRID_H_FIX;
			w = 1.5 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			tooltip = "$STR_AMAE_CARELESS";
		};
	};
};

class RscAttributeOwners : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeOwners','AresDisplays'] call (uiNamespace getVariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeOwners2 : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeOwners2','AresDisplays'] call (uiNamespace getVariable 'Achilles_fnc_initCuratorAttribute')";
};

class RscAttributeExec : RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,'RscAttributeExec','AresDisplays'] call (uiNamespace getVariable 'Achilles_fnc_initCuratorAttribute')";
	adminOnly = 0;
	codeExecution = 1;
	class controls
	{
		class Title : RscText
		{
			text = "$STR_3DEN_Object_AttributeCategory_Init";
		};
	};
};