class Achilles_rsc_loadSave
{
	idd = 133800;
	movingEnable = true;
	onLoad = "([""LOAD""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";
	onUnload = "([""UNLOAD""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

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

		text = $STR_A3_Achilles_rsc_saveLoadTree_Achilles_ctrl_title;
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
	class Achilles_ctrl_saveSection: RscButton
	{
		idc = 3000;
		onButtonClick = "([""SWITCH_SECTION""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

		text = $STR_A3_Achilles_rsc_saveLoadTree_Achilles_ctrl_saveSection;
		x = 5.5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.5};
	};
	class Achilles_ctrl_loadSection: Achilles_ctrl_saveSection
	{
		idc = 3010;

		text = $STR_A3_Achilles_rsc_saveLoadTree_Achilles_ctrl_loadSection;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class Achilles_ctrl_importSection: Achilles_ctrl_saveSection
	{
		idc = 3020;

		text = $STR_A3_Achilles_rsc_saveLoadTree_Achilles_ctrl_importSection;
		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class Achilles_ctrl_exportSection: Achilles_ctrl_saveSection
	{
		idc = 3030;

		text = $STR_A3_Achilles_rsc_saveLoadTree_Achilles_ctrl_exportSection;
		x = 28 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
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
		colorText[] = {0.5,0.5,0.5,1};
		colorBackground[] = {0,0,0,0.5};
	};
	class Achilles_ctrl_searchEdit: RscEdit
	{
		idc = 2000;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class Achilles_ctrl_searchIcon: RscPicture
	{
		idc = 1060;
		x = 34 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class Achilles_ctrl_tree: RscText
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
		onButtonClick = "([""CUSTOM_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

		text = "";
		x = 29 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.8};
	};
	class Achilles_ctrl_createButton: RscButton
	{
		idc = 3060;
		onButtonClick = "([""CREATE_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

		x = 29 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 2 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		colorBackground[] = {0,0,0,0.8};
		colorActive[] = {1,1,1,1};
	};
	class Achilles_ctrl_editButton: Achilles_ctrl_createButton
	{
		idc = 3070;
		onButtonClick = "([""EDIT_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

		x = 31.5 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 2 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class Achilles_ctrl_deleteButton: Achilles_ctrl_createButton
	{
		idc = 3080;
		onButtonClick = "([""DELETE_BUTTON""] + _this) call Achilles_fnc_RscDisplayAttributes_saveLoad";

		x = 34 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 2 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
};
