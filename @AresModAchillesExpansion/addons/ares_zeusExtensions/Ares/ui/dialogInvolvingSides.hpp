class Ares_Sides_Dialog
{
	idd = 133;
	movingEnable = false;

	class controls 
	{

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Desebi)
		////////////////////////////////////////////////////////

		class Ares_Dialog_Title: RscText
		{
			idc = 1000;

			text = "Switch Player Side"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * 	(0.04) * GUI_GRID_H;
		};
		class Ares_Main_Background: IGUIBack
		{
			idc = 2200;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 12.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class IGUIBack_2201: IGUIBack
		{
			idc = 2200;

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 29.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Dialog_Ok_Button: RscButtonMenuOK
		{
			onButtonClick = "missionNamespace setVariable ['Ares_CopyPaste_Dialog_Result', 1];";

			x = 35.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Ares_Dialog_Cancle_Button: RscButtonMenuCancel
		{
			onButtonClick = "missionNamespace setVariable ['Ares_CopyPaste_Dialog_Result', 0];";

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class Paragraph_Owner: RscText
		{
			idc = 1000;

			text = "Target Players:"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Background_Owner: RscText
		{
			idc = 17408;

			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 31 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0.1};
		};
		class TabSide: RscButton
		{
			colorDisabled[] = {1,1,1,1};
			colorFocused[] = {1,1,1,0.1};
			colorBackgroundActive[] = {1,1,1,0.3};
			colorBackgroundDisabled[] = {1,1,1,0.1};
			period = 0;
			periodFocus = 0;
			periodOver = 0;
			shadow = "false";
			font = "PuristaLight";
			idc = 18010;

			text = "SIDES"; //--- ToDo: Localize;
			x = 15.75 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.68 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0};
		};
		class TabGroup: TabSide
		{
			idc = 18011;

			text = "GROUP"; //--- ToDo: Localize;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.75 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0};
		};
		class TabUnit: TabSide
		{
			idc = 18012;

			text = "SINGLE"; //--- ToDo: Localize;
			x = 31.25 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.75 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0};
		};
		class TabSelection : TabSide
		{
			idc = 18013;

			text = "SELECTION"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.75 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0};
		};
		class BLUFOR: RscActivePicture
		{
			idc = 17608;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "BLUFOR"; //--- ToDo: Localize;
		};
		class OPFOR: BLUFOR
		{
			idc = 17609;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "OPFOR"; //--- ToDo: Localize;
		};
		class Independent: BLUFOR
		{
			idc = 17610;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa"; //--- ToDo: Localize;
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "Independent"; //--- ToDo: Localize;
		};
		class Civilian: BLUFOR
		{
			idc = 17611;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa"; //--- ToDo: Localize;
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "Civilian"; //--- ToDo: Localize;
		};
		class GroupList: RscCombo
		{
			idc = 18508;

			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 26.4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class UnitList: RscCombo
		{
			idc = 18509;

			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 26.4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Paragraph_Side: RscText
		{
			idc = 1000;

			text = "Switch to Side:"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Background_Side: RscText
		{
			idc = 17408;

			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 31 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0.1};
		};
		class BLUFOR2: RscActivePicture
		{
			idc = 17608;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "BLUFOR"; //--- ToDo: Localize;
		};
		class OPFOR2: BLUFOR
		{
			idc = 17609;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "OPFOR"; //--- ToDo: Localize;
		};
		class Independent2: BLUFOR
		{
			idc = 17610;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa"; //--- ToDo: Localize;
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "Independent"; //--- ToDo: Localize;
		};
		class Civilian2: BLUFOR
		{
			idc = 17611;

			text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa"; //--- ToDo: Localize;
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "Civilian"; //--- ToDo: Localize;
		};
		class Zeus: BLUFOR
		{
			idc = 12000;
			
			text = "\a3\ui_f\data\gui\cfg\hints\Zeus_ca.paa"; //--- ToDo: Localize;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			tooltip = "Zeus"; //--- ToDo: Localize;
		};
		class Ares_Icon_Background: IGUIBack
		{
			idc = 2200;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon: RscPicture
		{
			idc = 1201;

			text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
			x = 0.2 * GUI_GRID_W + GUI_GRID_X;
			y = 0.15 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.6 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

/*
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Zarg, v1.063, #Gecaxy)
////////////////////////////////////////////////////////

class Ares_Dialog_Title: RscText
{
	idc = 1000;

	text = "Switch Player Side"; //--- ToDo: Localize;
	x = 2 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 38 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorBackground[] = {0.518,0.016,0,0.8};
	sizeEx = 1.2 * 	(0.04) * GUI_GRID_H;
};
class Ares_Main_Background: IGUIBack
{
	idc = 2200;

	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 40 * GUI_GRID_W;
	h = 12.5 * GUI_GRID_H;
	colorBackground[] = {0.2,0.2,0.2,0.8};
};
class IGUIBack_2201: IGUIBack
{
	idc = 2200;

	x = 5.5 * GUI_GRID_W + GUI_GRID_X;
	y = 12 * GUI_GRID_H + GUI_GRID_Y;
	w = 29.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.6};
};
class Ares_Dialog_Ok_Button: RscButtonMenuOK
{
	onButtonClick = "missionNamespace setVariable ['Ares_CopyPaste_Dialog_Result', 1];";

	x = 35.5 * GUI_GRID_W + GUI_GRID_X;
	y = 12 * GUI_GRID_H + GUI_GRID_Y;
	w = 4 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.8};
};
class Ares_Dialog_Cancle_Button: RscButtonMenuCancel
{
	onButtonClick = "missionNamespace setVariable ['Ares_CopyPaste_Dialog_Result', 0];";

	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 12 * GUI_GRID_H + GUI_GRID_Y;
	w = 4.5 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.8};
};
class Paragraph_Owner: RscText
{
	idc = 1000;

	text = "Target Players:"; //--- ToDo: Localize;
	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 39 * GUI_GRID_W;
	h = 5 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.6};
};
class Paragraph_Side: RscText
{
	idc = 1000;

	text = "Switch to Side:"; //--- ToDo: Localize;
	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
	y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 39 * GUI_GRID_W;
	h = 4 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.6};
};
class Background_Owner: RscText
{
	idc = 17408;

	x = 8 * GUI_GRID_W + GUI_GRID_X;
	y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 31 * GUI_GRID_W;
	h = 3 * GUI_GRID_H;
	colorBackground[] = {1,1,1,0.1};
};
class TabSide: RscButton
{
	colorDisabled[] = {1,1,1,1};
	colorFocused[] = {1,1,1,0.1};
	colorBackgroundActive[] = {1,1,1,0.3};
	colorBackgroundDisabled[] = {1,1,1,0.1};
	period = 0;
	periodFocus = 0;
	periodOver = 0;
	shadow = "false";
	font = "PuristaLight";
	idc = 18010;

	text = "SIDES"; //--- ToDo: Localize;
	x = 8 * GUI_GRID_W + GUI_GRID_X;
	y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {1,1,1,0};
};
class TabGroup: TabSide
{
	idc = 18011;

	text = "GROUP"; //--- ToDo: Localize;
	x = 18.5 * GUI_GRID_W + GUI_GRID_X;
	y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {1,1,1,0};
};
class TabUnit: TabSide
{
	idc = 18012;

	text = "SINGLE"; //--- ToDo: Localize;
	x = 28.5 * GUI_GRID_W + GUI_GRID_X;
	y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 10.5 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	colorBackground[] = {1,1,1,0};
};
class BLUFOR: RscActivePicture
{
	idc = 17608;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa"; //--- ToDo: Localize;
	x = 16.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "BLUFOR"; //--- ToDo: Localize;
};
class OPFOR: BLUFOR
{
	idc = 17609;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "OPFOR"; //--- ToDo: Localize;
};
class Independent: BLUFOR
{
	idc = 17610;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa"; //--- ToDo: Localize;
	x = 24.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "Independent"; //--- ToDo: Localize;
};
class Civilian: BLUFOR
{
	idc = 17611;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa"; //--- ToDo: Localize;
	x = 28.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "Civilian"; //--- ToDo: Localize;
};
class GroupList: RscCombo
{
	idc = 18508;

	x = 10.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 26.4 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class UnitList: RscCombo
{
	idc = 18509;

	x = 10.5 * GUI_GRID_W + GUI_GRID_X;
	y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 26.4 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class Background_Side: RscText
{
	idc = 17408;

	x = 8 * GUI_GRID_W + GUI_GRID_X;
	y = 8 * GUI_GRID_H + GUI_GRID_Y;
	w = 31 * GUI_GRID_W;
	h = 3 * GUI_GRID_H;
	colorBackground[] = {1,1,1,0.1};
};
class BLUFOR2: RscActivePicture
{
	idc = 17608;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa"; //--- ToDo: Localize;
	x = 16.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "BLUFOR"; //--- ToDo: Localize;
};
class OPFOR2: BLUFOR
{
	idc = 17609;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa"; //--- ToDo: Localize;
	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "OPFOR"; //--- ToDo: Localize;
};
class Independent2: BLUFOR
{
	idc = 17610;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa"; //--- ToDo: Localize;
	x = 24.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "Independent"; //--- ToDo: Localize;
};
class Civilian2: BLUFOR
{
	idc = 17611;

	text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa"; //--- ToDo: Localize;
	x = 28.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "Civilian"; //--- ToDo: Localize;
};
class Ares_Icon_Background: IGUIBack
{
	idc = 2200;

	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 2 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorBackground[] = {0.518,0.016,0,0.8};
};
class Ares_Icon: RscPicture
{
	idc = 1201;

	text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa";
	x = 0.2 * GUI_GRID_W + GUI_GRID_X;
	y = 0.15 * GUI_GRID_H + GUI_GRID_Y;
	w = 1.6 * GUI_GRID_W;
	h = 1.2 * GUI_GRID_H;
	colorBackground[] = {0.518,0.016,0,0.8};
};
class Zeus: BLUFOR
{
	idc = 17611;

	text = "\ares_zeusExtensions\Achilles\data\icon_achilles_small.paa"; //--- ToDo: Localize;
	x = 12.5 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 2.4 * GUI_GRID_W;
	h = 2 * GUI_GRID_H;
	colorBackground[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	tooltip = "Civilian"; //--- ToDo: Localize;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
*/
