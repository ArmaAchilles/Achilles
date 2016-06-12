class RscDisplayAttributesModuleSpawnReinforcement
{
	idd = 124;
	movingEnable = false;
	onLoad = "[""LOAD""] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement;";
	onUnload = "[""UNLOAD""] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement;";

	class controls 
	{

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Jarujy)
		////////////////////////////////////////////////////////

		class Ares_Title: RscText
		{
			idc = 1000;
			
			text = "Spawn Reinforcement"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * 	(0.04) * GUI_GRID_H;
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 17.6 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 29.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', 1]; closeDialog 1;";
			idc = 3000;

			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', -1]; closeDialog 2;";
			idc = 3010;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;

			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = 0.2 * GUI_GRID_W + GUI_GRID_X;
			y = 0.15 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.6 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class LabelSide: RscText
		{
			idc = 1001;
			text = "Side"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelFaction: RscText
		{
			idc = 1002;
			text = "Faction"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelVehicleCategory: RscText
		{
			idc = 1003;
			text = "Vehicle Category"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelVehicle: RscText
		{
			idc = 1004;
			text = "Vehicle"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelVehicleBehaviour: RscText
		{
			idc = 1005;
			text = "Vehicle Behaviour (After Drop)"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelLZDZ: RscText
		{
			idc = 1006;
			text = "Vehicle LZ/DZ"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class LabelRP: RscText
		{
			idc = 1007;
			text = "Unit RP"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class ComboSide: RscCombo
		{
			idc = 2100;
			onLBSelChanged = "[""SIDE"",_this select 1] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboFaction: RscCombo
		{
			idc = 2101;
			onLBSelChanged = "[""FACTION"",_this select 1] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 4.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboVehicleCategory: RscCombo
		{
			idc = 2102;
			onLBSelChanged = "[""CATEGORY"",_this select 1] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 6.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboVehicle: RscCombo
		{
			idc = 2103;
			onLBSelChanged = "[""VEHICLE"",_this select 1] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 8.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboLZDZ: RscCombo
		{
			idc = 2104;
			onLBSelChanged = "[""LZDZ"",_this select 1] call Achilles_fnc_DialogAttributesModuleSpawnReinforcement";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboVehicleBehaviour: RscCombo
		{
			
			idc = 2105;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 10.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ComboRP: RscCombo
		{
			idc = 2106;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 15.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};