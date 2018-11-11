
class Add: RscControlsGroupNoScrollbars
{	
	class controls 
	{
		class CreateUnitsWest: RscTree
		{
			//h = safezoneH - 15.4 * BIGUI_GRID_H_FIX;
			h = safezoneH - 11.7 * BIGUI_GRID_H_FIX;
		};
		
		class CreateSearch : RscEdit {};
		class CreateSearchMaster: CreateSearch
		{
			idc = 284;
			// transfer result of master to slave when enter or numpad enter is pressed
			onKeyUp = "params ['_ctrlMaster', '_key']; \
				private _display =  ctrlParent _ctrlMaster; \
				if (_key in [0x1C, 0x9C]) then \
				{ \
					(_display displayCtrl 283) ctrlSetText (ctrlText _ctrlMaster); \
				}; \
				true; \
			";
			// Makes sure that display key event handlers are disabled when searching
			onSetFocus = "missionNamespace setVariable ['RscDisplayCurator_search', true];";
			onKillFocus = "missionNamespace setVariable ['RscDisplayCurator_search', false];";
		};
		class CreateSearchButton : RscButtonSearch
		{
			idc = 285;
		};
		
		class Ares_Title_Attr: RscText
		{
			idc = 1000;
			moving = 1;

			text = "Spawn Attributes"; //--- ToDo: Localize;
			x = 2 * BIGUI_GRID_W_FIX;
			//y= "safezoneH - 10.2 * BIGUI_GRID_H_FIX";
			y = safezoneH - 6.5 * BIGUI_GRID_H_FIX;
			w = 19 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0.518,0.016,0,0.8};
			sizeEx = 1.2 * GUI_GRID_H_FIX;
		};
		class Ares_Icon_Background_Attr: IGUIBack
		{
			idc = 2020;

			x = 0.0 * BIGUI_GRID_W_FIX;
			//y = safezoneH - 10.2 * BIGUI_GRID_H_FIX;
			y = safezoneH - 6.5 * BIGUI_GRID_H_FIX;
			w = 2.0 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class Ares_Icon_Attr: RscPicture
		{
			idc = 2030;

			text = "\achilles\data_f_achilles\icons\icon_achilles_dialog.paa";
			x = 0.0 * BIGUI_GRID_W_FIX;
			//y = safezoneH - 10.2 * BIGUI_GRID_H_FIX;
			y = safezoneH - 6.5 * BIGUI_GRID_H_FIX;
			w = 2.0 * BIGUI_GRID_W_FIX;
			h = 1.5 * BIGUI_GRID_H_FIX;
		};
		class Ares_Background_Attr: IGUIBack
		{
			idc = 2000;

			x = 0.0 * BIGUI_GRID_W_FIX;
			//y = safezoneH - 8.7 * BIGUI_GRID_H_FIX;
			y = safezoneH - 5.0 * BIGUI_GRID_H_FIX;
			w = 11.0 * BIGUI_GRID_W_FIX;
			//h = 7.5 * BIGUI_GRID_H_FIX;
			h = 3.0 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0.2,0.2,0.2,0.8};
		};
		/*
		class Ares_Button_Unit: RscButtonMenu
		{
			idc = 2401;
			text = "Unit"; //--- ToDo: Localize;
			x = 0.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 8.2 * BIGUI_GRID_H_FIX;
			w = 10.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
		};
		class Ares_Button_Vehicle: RscButtonMenu
		{
			idc = 2402;
			text = "Vehicle"; //--- ToDo: Localize;
			x = 0.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 7.1 * BIGUI_GRID_H_FIX;
			w = 10.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
		};
		class Ares_Button_Group: RscButtonMenu
		{
			idc = 2400;
			text = "Group"; //--- ToDo: Localize;
			x = 0.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 6.0 * BIGUI_GRID_H_FIX;
			w = 10.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
		};
		*/
		class Ares_Label_Crew: RscText
		{
			idc = 1020;

			text = "Include crew"; //--- ToDo: Localize;
			shadow = 0;
			font = "PuristaLight";
			x = 0.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 4.5 * BIGUI_GRID_H_FIX;
			w = 10.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Checkbox_Crew: RscCheckbox
		{
			idc = 2801;
			checked = 1;
			onLoad = "if (isNil ""Achilles_var_deleteCrewOnSpawn"") then {(_this select 0) cbSetChecked true} else {(_this select 0) cbSetChecked false}";
			onCheckedChanged = "Achilles_var_deleteCrewOnSpawn = if (_this select 1 == 0) then {true} else {nil}";
			x = 9.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 4.5 * BIGUI_GRID_H_FIX;
			w = 1.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
		};
		class Ares_Label_Position: RscText
		{
			idc = 1020;
			text = "Specify position"; //--- ToDo: Localize;
			shadow = 0;
			font = "PuristaLight";
			x = 0.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 3.4 * BIGUI_GRID_H_FIX;
			w = 10.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
			colorBackground[] = {0,0,0,0.6};
		};
		class Ares_Checkbox_Position: RscCheckbox
		{
			idc = 2800;
			onLoad = "if (isNil ""Achilles_var_specifyPositionBeforeSpawn"") then {(_this select 0) cbSetChecked false} else {(_this select 0) cbSetChecked true}";
			onCheckedChanged = "Achilles_var_specifyPositionBeforeSpawn = if (_this select 1 == 0) then {nil} else {true}";
			x = 9.5 * BIGUI_GRID_W_FIX;
			y = safezoneH - 3.4 * BIGUI_GRID_H_FIX;
			w = 1.0 * BIGUI_GRID_W_FIX;
			h = 1.0 * BIGUI_GRID_H_FIX;
		};
	};
};
