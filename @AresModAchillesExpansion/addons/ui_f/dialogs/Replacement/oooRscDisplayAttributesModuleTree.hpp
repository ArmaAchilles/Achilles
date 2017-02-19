class Add: RscControlsGroupNoScrollbars
{	
	class controls 
	{
		class CreateUnitsWest: RscTree 
		{
			h= "safezoneH - 7.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kex, v1.063, #Lekizy)
		////////////////////////////////////////////////////////
		
		class Ares_Title_Attr: RscText
		{
			idc = 1000;
			moving = 1;

			text = "Attributes"; //--- ToDo: Localize;
			x= "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y= "safezoneH - 11 * ((	((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w= "11 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h= "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0.518,0.016,0,0.8};
			//sizeEx= 1.2 * 	(0.04) * GUI_GRID_H;
		};
		class Ares_Icon_Background_Attr: IGUIBack
		{
			idc = 2020;

			x = 53.5 * GUI_GRID_W + GUI_GRID_X;
			y = 25.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon_Attr: RscPicture
		{
			idc = 2030;

			text = "\achilles\data_f_achilles\icons\icon_achilles_dialog.paa";
			x = 53.5 * GUI_GRID_W + GUI_GRID_X;
			y = 25.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Ares_Label_Crew: RscText
		{
			idc = 1020;

			text = "Spawn with crew"; //--- ToDo: Localize;
			x = 54 * GUI_GRID_W + GUI_GRID_X;
			y = 32 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Checkbox_Preplace: RscCheckbox
		{
			idc = 2800;
			x = 64.5 * GUI_GRID_W + GUI_GRID_X;
			y = 33 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Ares_Label_Preplace: RscText
		{
			idc = 1020;

			text = "Preplace"; //--- ToDo: Localize;
			x = 54 * GUI_GRID_W + GUI_GRID_X;
			y = 33 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Background_Attr: IGUIBack
		{
			idc = 2000;

			x = 53.5 * GUI_GRID_W + GUI_GRID_X;
			y = 27 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		class Ares_Button_Group: RscButtonMenu
		{
			idc = 2400;
			text = "Group"; //--- ToDo: Localize;
			x = 54 * GUI_GRID_W + GUI_GRID_X;
			y = 30.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Ares_Button_Unit: RscButtonMenu
		{
			idc = 2401;
			text = "Unit"; //--- ToDo: Localize;
			x = 54 * GUI_GRID_W + GUI_GRID_X;
			y = 27.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Ares_Button_Vehicle: RscButtonMenu
		{
			idc = 2402;
			text = "Vehicle"; //--- ToDo: Localize;
			x = 54 * GUI_GRID_W + GUI_GRID_X;
			y = 29 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Ares_Checkbox_Crew: RscCheckbox
		{
			idc = 2801;
			x = 64.5 * GUI_GRID_W + GUI_GRID_X;
			y = 32 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
