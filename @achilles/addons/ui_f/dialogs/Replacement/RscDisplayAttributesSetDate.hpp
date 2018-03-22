class RscAttributeDate: RscControlsGroupNoScrollbars
{
	onSetFocus = "[_this,""RscAttributeDate"",'AresDisplays'] call (uinamespace getvariable ""Achilles_fnc_initCuratorAttribute"")";
	idc = 122438;
	x = "7 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "26 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "12 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls
	{
		class Title1 : RscText {
			idc = 121138;
			text = "$STR_3DEN_Environment_Attribute_Date_displayName";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.5};
		};
		
		class Background1 : RscText {
			idc = 121140;
			tooltip = $STR_3DEN_Environment_Attribute_Date_tooltip;
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1, 1, 1, 0.1};
		};	

		class ValueYear: ctrlCombo
		{
			idc = 101;
			x = "0.5 * 						(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/3 * 0.99 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorTextRight[] = {1,1,1,0.6};
		};
		class ValueMonth: ValueYear
		{
			idc = 102;
			x = "(0.5 + 25 * 1/3) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			class Items
			{
				class Month1
				{
					text = $STR_3DEN_Attributes_Date_Month1_text;
					value = 1;
				};
				class Month2
				{
					text = $STR_3DEN_Attributes_Date_Month2_text;
					value = 2;
				};
				class Month3
				{
					text = $STR_3DEN_Attributes_Date_Month3_text;
					value = 3;
				};
				class Month4
				{
					text = $STR_3DEN_Attributes_Date_Month4_text;
					value = 4;
				};
				class Month5
				{
					text = $STR_3DEN_Attributes_Date_Month5_text;
					value = 5;
				};
				class Month6
				{
					text = $STR_3DEN_Attributes_Date_Month6_text;
					value = 6;
				};
				class Month7
				{
					text = $STR_3DEN_Attributes_Date_Month7_text;
					value = 7;
					default = 1;
				};
				class Month8
				{
					text = $STR_3DEN_Attributes_Date_Month8_text;
					value = 8;
				};
				class Month9
				{
					text = $STR_3DEN_Attributes_Date_Month9_text;
					value = 9;
				};
				class Month10
				{
					text = $STR_3DEN_Attributes_Date_Month10_text;
					value = 10;
				};
				class Month11
				{
					text = $STR_3DEN_Attributes_Date_Month11_text;
					value = 11;
				};
				class Month12
				{
					text = $STR_3DEN_Attributes_Date_Month12_text;
					value = 12;
				};
			};
		};
		class ValueDay: ValueYear
		{
			idc = 103;
			x = "(0.5 + 25 * 2/3) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		};
		
		class Title2 : RscText {
			idc = 121139;
			text = "$STR_3DEN_Environment_Attribute_Daytime_displayName";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "5.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0, 0, 0, 0.5};
		};
		class Background2 : RscText {
			idc = 121141;
			tooltip = $STR_3DEN_Environment_Attribute_Daytime_tooltip;
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "6.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "26 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1, 1, 1, 0.1};
		};
		
		class Preview: ctrlControlsGroupNoScrollbars
		{
			idc = 110;
			x = "(0.5 + 1.11) *	(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "(25 * 2/3 - 2.22) *			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLoad = "uinamespace setvariable ['AttributeSliderTimeDay_group',_this select 0];";
			class Controls
			{
				class PreviewNight1: ctrlStaticPicture
				{
					idc = 111;
					text = "\a3\3DEN\Data\Attributes\SliderTimeDay\night_ca.paa";
					colorText[] = {1,1,1,0.6};
					x = "0 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
					w = "0.5 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class PreviewNight2: PreviewNight1
				{
					idc = 112;
				};
				class PreviewDay: PreviewNight1
				{
					idc = 113;
					text = "\a3\3DEN\Data\Attributes\SliderTimeDay\day_ca.paa";
				};
				class PreviewSunrise: PreviewNight1
				{
					idc = 114;
					text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sunrise_ca.paa";
				};
				class PreviewSunset: PreviewNight1
				{
					idc = 115;
					text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sunset_ca.paa";
				};
				class Sun: ctrlStaticPicture
				{
					idc = 116;
					text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sun_ca.paa";
					colorText[] = {1,1,1,0.6};
					x = "(25 * 1/3 - 1.11 - 0.5) *	(			((safezoneW / safezoneH) min 1.2) / 40)";
					w = "1 *			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		
		
		class Value: ctrlXSliderH
		{
			idc = 104;
			x = "0.5 * 						(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/3 * 1.99 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			sliderRange[] = {0,1439};
			sliderPosition = 0;
			lineSize = 1;
			// pageSize = 3600;

			border = "\a3\3DEN\Data\Attributes\SliderTimeDay\border_ca.paa";
			thumb = "\a3\3DEN\Data\Attributes\SliderTimeDay\thumb_ca.paa";
			color[] = {1,1,1,0.6};
			colorActive[] = {1,1,1,1};
		};
		
		class Frame: ctrlStaticFrame
		{
			x = "(0.5 + 25 * 2/3) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/9 * 2.99 *				(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Separator: ctrlStatic
		{
			style = ST_CENTER;
			x = "(0.5 + 25 * 2/3) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/9 * 2.99 *				(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			font = "EtelkaMonospacePro";
			colorBackground[] = {0,0,0,0.5};
			text = ":      :";
		};
		class Hour: ctrlEdit
		{
			idc = 105;
			text = "00";
			tooltip = $STR_3DEN_Attributes_SliderTime_Hour_tooltip;
			style = ST_CENTER + ST_NO_RECT;
			x = "(0.5 + 25 * 2/3) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/9 * 0.99 *				(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			font = "EtelkaMonospacePro";
		};
		class Minute: Hour
		{
			idc = 106;
			tooltip = $STR_3DEN_Attributes_SliderTime_Minute_tooltip;
			x = "(0.5 + 25 * 7/9) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/9 * 0.99 *				(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Second: Hour
		{
			idc = 107;
			tooltip = $STR_3DEN_Attributes_SliderTime_Second_tooltip;
			x = "(0.5 + 25 * 8/9) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "25 * 1/9 * 0.99 *				(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

class RscDisplayAttributesModuleSetDate: RscDisplayAttributes
{
	scriptName = "RscDisplayAttributesModuleSetDate";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesModuleSetDate"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesModuleSetDate"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	
	class Controls : Controls {
		class Background : Background {};
		
		class Title : Title {};
		
		class Content : Content {
			class Controls : controls {
				class Date : RscAttributeDate {};
			};
		};
		
		class ButtonOK : ButtonOK {};
		
		class ButtonCancel : ButtonCancel {};
		
		class ButtonBehaviour : ButtonCustom 
		{
			text = "$STR_AMAE_PREVIEW";
			onMouseButtonClick = "with uiNamespace do {[""preview"",[ctrlParent (_this select 0)],objnull] call RscAttributeDate};";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
	};
};