class Ares_ExecuteCode_Dialog
{
	idd = 123;
	movingEnable = false;
	onLoad = "((_this select 0) displayCtrl 1400) ctrlSetText (uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Text', '']);";
	onUnload = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Text', ctrlText ((_this select 0) displayCtrl 1400)];";

	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Gocypi)
		////////////////////////////////////////////////////////

		class Ares_Title: RscText
		{
			idc = 1000;

			text = "$STR_EXECUTE_CODE"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * GUI_GRID_H;
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 22.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;

			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 28 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', 1]; closeDialog 1;";
			idc = 3000;
			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Dialog_Paragraph_Combo: RscText
		{
			idc = 1010;
			text = "Mode:"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Dialog_Combo: RscCombo
		{
			onLBSelChanged = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Constraint', _this select 1];";
			idc = 4000;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 17 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;

			text = "$STR_WRITE_OR_PASTE_CODE"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_Edit: RscEdit
		{
			idc = 1400;
			style = 16;
			linespacing = 1;
			default = 1;
			
			autocomplete = "scripting";

			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
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
			style = 48;
			text = "\achilles\data_f_achilles\icons\icon_achilles_small.paa";
			x = 0.2 * GUI_GRID_W + GUI_GRID_X;
			y = 0.15 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.6 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
