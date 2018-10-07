
class RscAttributeInventory: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeInventory"",'AresDisplays'] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";
	h = 29 * BIGUI_GRID_H_DYN;
	class controls 
	{
		class ArrowLeft: RscButtonMenu 
		{

			class Attributes 
			{
				font = "RobotoCondensed";
				color = "#ffffff";
				align = "center";
				shadow = "false";
			};

			class TextPos 
			{
				left = 0;
				top = 0;
				right = 0;
				bottom = 0;
			};
			idc = 24468;
			text = "-";
			size = 2* BIGUI_GRID_H_FIX;
			sizeEx = 2 * BIGUI_GRID_H_FIX;
			sizeExSecondary = 2 * BIGUI_GRID_H_FIX;
			x = 0 * BIGUI_GRID_W_FIX;
			y = -1 * BIGUI_GRID_H_FIX;
			w = 1 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		
		class WeaponSpecificLabel: RscText
		{
			idc = 24081;
			colorSelectBackground[] = {1, 1, 1, 0.250000};
			shadow = 0;
			text = "";
			x = 0 * BIGUI_GRID_W_FIX;
			y = 2 * BIGUI_GRID_H_FIX;
			w = 26 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;
		};
		
		class ButtonVA: ArrowLeft
		{
			idc = 24470;
			text = "Virtual Arsenal";
			size = 1 * BIGUI_GRID_H_FIX;
			sizeEx = 1 * BIGUI_GRID_H_FIX;
			sizeExSecondary = 1 * BIGUI_GRID_H_FIX;
			x = 20 * BIGUI_GRID_W_FIX;
			y = 2 * BIGUI_GRID_H_FIX;
			w = 6 * BIGUI_GRID_W_FIX;
			h = 1 * BIGUI_GRID_H_FIX;			
		};

		class List: RscListNBox 
		{
			columns[] = {0.070000, 0.230000, 0.760000, 0.830000};
			drawSideArrows = 1;
			rowHeight = 2 * BIGUI_GRID_H_FIX;
			idcLeft = 24468;
			idcRight = 24469;
			colorSelect2[] = {0.950000, 0.950000, 0.950000, 1};
			colorSelectBackground[] = {1, 1, 1, 0.250000};
			colorSelectBackground2[] = {1, 1, 1, 0.250000};
			idc = 24368;
			x = 0 * BIGUI_GRID_W_FIX;
			y = 3 * BIGUI_GRID_H_FIX;
			w = 26 * BIGUI_GRID_W_FIX;
			h = 29 * BIGUI_GRID_H_DYN - 4.5 * BIGUI_GRID_H_FIX;
		};
		
		class ListBackground : RscText
		{
			h = 29 * BIGUI_GRID_H_DYN - 3.5 * BIGUI_GRID_H_FIX;
		};
		
		class Load : RscProgress
		{
			y = 29 * BIGUI_GRID_H_DYN - 1 * BIGUI_GRID_H_FIX;
		};
	};
};

class RscDisplayAttributesInventory : RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesInventory";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesInventory"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesInventory"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
};
