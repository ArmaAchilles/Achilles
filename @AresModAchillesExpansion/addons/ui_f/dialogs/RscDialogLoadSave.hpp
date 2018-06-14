class Achilles_rsc_loadSave
{
	idd = 133800;
	movingEnable = true;
	onLoad = "([""LOAD""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
	onUnload = "([""UNLOAD""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
	class controls 
	{
		// top
		class Achilles_ctrl_addonIconBackground: IGUIBack
		{
			idc = 1000;

			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Achilles_ctrl_addonIcon: RscPicture
		{
			idc = 1010;

			text = "\achilles\data_f_achilles\icons\icon_achilles_dialog.paa";
			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Achilles_ctrl_title: RscText
		{
			idc = 1020;
			moving = 1;

			text = "";
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * 	(0.04) * GUI_GRID_H;
		};
		
		class Achilles_ctrl_mainBackground: IGUIBack
		{
			idc = 1030;

			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 32 * GUI_GRID_W;
			h = 22.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		
		// tree
		class Achilles_ctrl_treeBackground: IGUIBack
		{
			idc = 1040;

			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 31 * GUI_GRID_W;
			h = 19.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Achilles_ctrl_tabSelection: RscToolBox
		{
			idc = 3000;
			onToolBoxSelChanged = "([""SWITCH_TAB""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
			soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
			columns = 4;
			strings[] = {"STR_AMAE_SAVE", "STR_AMAE_LOAD", "$STR_3DEN_Display3DENSave_ButtonOK_textImport", "$STR_3DEN_Display3DEN_menubar_MissionExport_text"};
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,0.5};
			color[] = {0,0,0,0.2};
			colorTextSelect[] = {1,1,1,1};
			colorSelect[] = {0,0,0,0.5};
			colorSelectedBg[] = {0,0,0,0.5};
		};
		class Achilles_ctrl_searchBackground: IGUIBack
		{
			idc = 1050;
			colorMarked[] = {1,1,1,0.35};
			colorMarkedSelected[] = {1,1,1,0.7};

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class Achilles_ctrl_searchFrame: RscFrame
		{
			idc = 1080;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Achilles_ctrl_searchEdit: RscEdit
		{
			idc = 645; // hard-coded IDC
			style = "0x240"; // 0x200 => no frame
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 28 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Achilles_ctrl_searchIcon: RscPicture
		{
			idc = 1060;
			
			text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
			x = 33.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Achilles_ctrl_tree: RscTreeSearch
		{
			idc = 2010;
			colorMarked[] = {1,1,1,0.35};
			colorMarkedSelected[] = {1,1,1,0.7};

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 15.5 * GUI_GRID_H;
			colorText[] = {0.5,0.5,0.5,1};
			colorBackground[] = {0,0,0,0.5};
		};
		
		// bottom ctrls
		class Achilles_ctrl_bottomBar: IGUIBack
		{
			idc = 1070;

			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Achilles_ctrl_cancelButton: RscButtonMenuCancel
		{
			idc = 3040;
			onButtonClick = "closeDialog 2";

			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Achilles_ctrl_customButton: RscButtonMenu
		{
			idc = 3050;
			onButtonClick = "([""CUSTOM_BUTTON_CLICK""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";

			text = "";
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Achilles_ctrl_createBackground: IGUIBack
		{
			idc = 3061;
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
		};
		class Achilles_ctrl_editBackground: Achilles_ctrl_createBackground
		{
			idc = 3071;
			x = 31.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Achilles_ctrl_deleteBackground: Achilles_ctrl_createBackground
		{
			idc = 3081;
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Achilles_ctrl_createButton: RscActivePicture
		{
			idc = 3060;
			onButtonClick = "([""CREATE_BUTTON_CLICK""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			onMouseEnter = "([""PICTURE_BUTTON_FOCUSED""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			onMouseExit = "([""PICTURE_BUTTON_KILLED""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			onButtonDown = "([""PICTURE_BUTTON_KILLED""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
			soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};			
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_add_ca.paa";
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
		};
		class Achilles_ctrl_editButton: Achilles_ctrl_createButton
		{
			idc = 3070;
			onButtonClick = "([""EDIT_BUTTON_CLICK""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			text = "a3\3den\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
			x = 31.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Achilles_ctrl_deleteButton: Achilles_ctrl_createButton
		{
			idc = 3080;
			onButtonClick = "([""DELETE_BUTTON_CLICK""] + _this) call Achilles_fnc_RscDisplayAttributes_loadSave";
			text = "a3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
	};
};
