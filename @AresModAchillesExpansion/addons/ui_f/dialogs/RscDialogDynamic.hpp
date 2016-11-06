class Ares_Dynamic_Dialog
{
	idd = 133798;
	movingEnable = true;
	
	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Gocypi)
		////////////////////////////////////////////////////////

		class Ares_Title: RscText
		{
			idc = 1000;
			moving = 1;

			text = "Execute Code"; //--- ToDo: Localize;
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
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', 1]; closeDialog 1;";
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
			onButtonClick = "uiNamespace setVariable ['Ares_ChooseDialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
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
