
class CfgFunctions
{
	class Achilles // This bit will be prefixed when actually calling the function (e.g. "Achilles_fnc_...." )
	{
		class init
		{
			file = "\achilles\functions_f_achilles\functions\init";
			
			class Init;
		}
		class functions_f_common
		{
			file = "\achilles\functions_f_achilles\functions\common";
			
			class map;
			class filter;
			class sum;
			class TextToVariableName;
			class HigherConfigHierarchyLevel;
			class ClassNamesWhichInheritsFromCfgClass;
		};
		
		class functions_f_features
		{
			file = "\achilles\functions_f_achilles\functions\features";
			
			class ACS_toggleGrouping;
			class ambientAnim;
			class ambientAnimGetParams;
			class Animation;
			class Chatter;
			class changeAbility;
			class chute;
			class halo;
			class eject_passengers;
			class LaunchCM;
			class SwitchZeusSide;
			class CopyObjectsToClipboard;
			class PasteObjectsFromClipboard;
		};
	};
};
