
class CfgFunctions
{
	class Achilles
	{
		project = "Ares Mod - Achilles Expansion";
		tag = "Achilles";
		
		class Init
		{
			file = "\achilles\functions_f_achilles\functions\init";
			
			class onCuratorStart;
		}
		class functions_f_common
		{
			file = "\achilles\functions_f_achilles\functions\common";
			
			class sum;
			class arrayMean;
			class pushBack;
			class TextToVariableName;
			class HigherConfigHierarchyLevel;
			class ClassNamesWhichInheritsFromCfgClass;
			class getAllTurretConfig;
			class getVehicleAmmoDef;
			class getUnitAmmoDef;
			class setUnitAmmoDef;
			class checkLineOfFire2D;
			class matrixTranspose;
			class vectorMap;
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
			class damageComponents;
			class changeSkills;
			class groupObjects;
			class ungroupObjects;
            class setCuratorVisionModes;
			class damageBuildings;
		};
	};
	class A3_Functions_F_Curator
	{
		class Curator
		{
			delete showCuratorAttributes;
		};
		class Achilles
		{
			file = "\achilles\functions_f_achilles\functions\replacement";
			
			class showCuratorAttributes;
		};
	};
};
