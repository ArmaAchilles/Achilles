class Ares_ExecuteCode_Dialog
{
	idd = 123;
	movingEnable = true;
	onLoad = "((_this select 0) displayCtrl 1400) ctrlSetText (profileNamespace getVariable ['Ares_ExecuteCode_Dialog_Text', '']);";
	onUnload = "profileNamespace setVariable ['Ares_ExecuteCode_Dialog_Text', ctrlText ((_this select 0) displayCtrl 1400)];";

	class controls 
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Gocypi)
		////////////////////////////////////////////////////////

		class Ares_Title: RscText
		{
			idc = 1000;
			moving = 1;

			text = "$STR_AMAE_EXECUTE_CODE"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W_FIX + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W - 2 * GUI_GRID_W_FIX;
			h = 1.5 * GUI_GRID_H_FIX;
			size = TITLE_FONT_SIZE;
			sizeEx = TITLE_FONT_SIZE;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2000;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 22.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Dialog_Bottom_Bar: IGUIBack
		{
			idc = 2010;

			x = 1 * GUI_GRID_W + 6 * GUI_GRID_W_FIX + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W - 10 * GUI_GRID_W_FIX;
			h = 1.5 * GUI_GRID_H_FIX;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', 1]; closeDialog 1;";
			idc = 3000;
			x = 39.5 * GUI_GRID_W - 4 * GUI_GRID_W_FIX + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W_FIX;
			h = 1.5 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Result', -1]; closeDialog 2;";
			idc = 3010;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W_FIX;
			h = 1.5 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Dialog_Paragraph_Combo: RscText
		{
			idc = 1010;
			text = "Mode:"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H - 1 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 1 * GUI_GRID_H + 1 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Dialog_Combo: RscCombo
		{
			onLBSelChanged = "uiNamespace setVariable ['Ares_ExecuteCode_Dialog_Constraint', _this select 1];";
			idc = 4000;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H - 1 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Background_Edit: IGUIBack
		{
			idc = 2020;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + 1.5 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 19.5 * GUI_GRID_H - 2.5 * GUI_GRID_H_FIX;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Paragraph_edit: RscText
		{
			idc = 1020;

			text = "$STR_AMAE_WRITE_OR_PASTE_CODE"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + 1.5 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
		};
		class Ares_Edit: RscEdit
		{
			idc = 1400;
			style = 16;
			linespacing = 1;
			default = 1;
			/*
			// -- TO Do: Have to wait for ebSetCursor command...
			onKeyDown = "params[""_ctrl"",""_key""]; \
						_handled = false; \
						switch (_key) do \
						{ \
							case 15: \
							{ \
								_display = ctrlParent _ctrl;\
								_txt = ctrlText _ctrl; \
								_txt = _txt + ""    ""; \
								_ctrl ctrlSetText _txt; \
								ctrlSetFocus (_display displayCtrl 4000); \
								ctrlSetFocus _ctrl; \
								_handled = true; \
							}; \
							case 28: \
							{ \
								_display = ctrlParent _ctrl;\
								_txt = ctrlText _ctrl; \
								_txt = _txt + toString[0x0D,0x0A]; \
								_ctrl ctrlSetText _txt; \
								ctrlSetFocus (_display displayCtrl 4000); \
								ctrlSetFocus  _ctrl; \
								_handled = true; \
							}; \
						}; \
						_handled";
			*/
			autocomplete = "scripting";

			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + 3 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 19 * GUI_GRID_H - 4 * GUI_GRID_H_FIX;
			size = DEFAULT_FONT_SIZE;
			sizeEx = DEFAULT_FONT_SIZE;
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2020;

			x = 0 * GUI_GRID_W_FIX + GUI_GRID_X;
			y = 0 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 2 * GUI_GRID_W_FIX;
			h = 1.5 * GUI_GRID_H_FIX;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 2030;
			style = 48;
			text = "\achilles\data_f_achilles\icons\icon_achilles_dialog.paa";
			x = 0.2 * GUI_GRID_W_FIX + GUI_GRID_X;
			y = 0.15 * GUI_GRID_H_FIX + GUI_GRID_Y;
			w = 1.6 * GUI_GRID_W_FIX;
			h = 1.2 * GUI_GRID_H_FIX;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

