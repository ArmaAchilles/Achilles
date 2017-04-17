
class RscAttributeInventory: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeInventory"",'AresDisplays'] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";
	
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
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2)";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "-1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class WeaponSpecificLable: RscText
		{
			idc = 24081;
			colorSelectBackground[] = {1, 1, 1, 0.250000};
			shadow = 0;
			text = "";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class ButtonVA: ArrowLeft
		{
			idc = 24470;
			text = "Virtual Arsenal";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			x = "20 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";			
		};

		class List: RscListNBox 
		{
			columns[] = {0.070000, 0.230000, 0.760000, 0.830000};
			drawSideArrows = 1;
			rowHeight = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			idcLeft = 24468;
			idcRight = 24469;
			colorSelect2[] = {0.950000, 0.950000, 0.950000, 1};
			colorSelectBackground[] = {1, 1, 1, 0.250000};
			colorSelectBackground2[] = {1, 1, 1, 0.250000};
			idc = 24368;
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "12.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};