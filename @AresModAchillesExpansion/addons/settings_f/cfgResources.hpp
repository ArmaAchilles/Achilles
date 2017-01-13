class RscText;
class RscStandardDisplay;
class RscDisplayMPInterrupt :  RscStandardDisplay
{
	class controls
	{
		class Achilles_eh_onCloseDisplayInterrup : RscText
		{
			idc = 723217262;
			onDestroy = "[] spawn Achilles_fnc_onSettingsChanged";
		};
	};
};
class RscDisplayInterrupt : RscStandardDisplay
{
	class controls
	{
		class Achilles_eh_onCloseDisplayInterrup : RscText
		{
			idc = 723217262;
			onDestroy = "[] spawn Achilles_fnc_onSettingsChanged";
		};
	};
};