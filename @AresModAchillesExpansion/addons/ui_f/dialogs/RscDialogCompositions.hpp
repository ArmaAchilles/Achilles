class Ares_composition_Dialog
{
	idd = 133799;
	movingEnable = false;

	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kex, v1.063, #Qocuko)
		////////////////////////////////////////////////////////

		class Ares_Title: RscText
		{
			idc = 1000;

			text = "$STR_ADVANCED_COMPOSITION"; //--- ToDo: Localize;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * GUI_GRID_H;
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;

			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 26 * GUI_GRID_W;
			h = 20.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom: IGUIBack
		{
			idc = 2010;

			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			idc = 3010;
			
			onButtonClick = "uiNamespace setVariable ['Ares_Dialog_Result', -1]; closeDialog 2;";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class RscButtonMenuOK: RscButtonMenuOK
		{
			idc = 3000;
			
			onButtonClick = "uiNamespace setVariable ['Ares_Dialog_Result', 1]; closeDialog 1;";			
			text = "$STR_SPAWN"; //--- ToDo: Localize;
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;

			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 25 * GUI_GRID_W;
			h = 17 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;

			text = "Select composition to edit or delete."; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 25.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_composition_tree: RscTree
		{
			idc = 1400;
			
			expandOnDoubleclick = 1;
			colorMarked[] = {1, 1, 1, 0.350000};
			colorMarkedSelected[] = {1, 1, 1, 0.700000};

			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;
			
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;

			text = "\achilles\data_f_achilles\icons\icon_achilles_small.paa";
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_Delete_Button: RscActivePicture
		{
			idc = 3020;
			
			onButtonClick = "([""DELETE_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;";
			soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
			soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};			
			
			text = "a3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
			x = 31 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_Edit_Button: Ares_Delete_Button
		{
			idc = 3030;

			onButtonClick = "([""EDIT_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;";
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_New_Button: Ares_Delete_Button
		{
			idc = 3040;
			
			onButtonClick = "([""NEW_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;";			
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_add_ca.paa";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
