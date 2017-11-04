
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
			class weaponsAllTurrets;
			class getVehicleAmmoDef;
			class getUnitAmmoDef;
			class setUnitAmmoDef;
			class setVehicleAmmoDef;
			class checkLineOfFire2D;
			class matrixTranspose;
			class vectorMap;
			class dikToLetter;
			class getCuratorSelected;
			class deadlyExplosion;
			class disablingExplosion;
			class fakeExplosion;
			class spawn;
			class spawn_remote;
			class ShowChooseDialog;
			class showZeusErrorMessage;
			class logMessage;
			class parseBool;
			class getAllLZsOrRPs;
		};

		class selectUnit
		{
			file = "\achilles\functions_f_achilles\functions\selectUnit";
			
			class switchUnit_start;
			class switchUnit_exit;
		};
		
		class changeAttributes
		{
			file = "\achilles\functions_f_achilles\functions\changeAttributes";
			
			class changeAbility;
			class changePylonAmmo;
			class changeSideAttribute;
			class changeSide_local;
			class changeSkills;
			class damageComponents;
			class setSensors;
		};

		class functions_f_features
		{
			file = "\achilles\functions_f_achilles\functions\features";

			class ACS_toggleGrouping;
			class ambientAnim;
			class ambientAnimGetParams;
			class Animation;
			class Chatter;
			class chute;
			class eject_passengers;
			class LaunchCM;
			class SwitchZeusSide;
			class CopyObjectsToClipboard;
			class PasteObjectsFromClipboard;
			class groupObjects;
			class ungroupObjects;
			class setCuratorVisionModes;
			class damageBuildings;
			class preplaceMode;
			class addBreachDoorAction;
			class breachStun;
			class setACEInjury;
			class setVanillaInjury;
			class SuppressiveFire;
			class changeNVGBrightness;
			class createIED;
			class createSuicideBomber;
			class IED_DamageHandler;
			class setSRFrequencies;
			class setLRFrequencies;
		};
	};

	class A3_Mark
	{
		class Vehicles
		{
			delete garage;
		};
		class Achilles
		{
			file = "\achilles\functions_f_achilles\functions\replacement";
			class garage;
			class garageZeus;
		};
	};
	class A3_Functions_F_Curator
	{
		class Curator
		{
			delete showCuratorAttributes;
			delete curatorObjectPlaced;
			delete curatorObjectEdited;
			delete toggleCuratorVisionMode;
		};
		class Achilles
		{
			file = "\achilles\functions_f_achilles\functions\replacement";

			class showCuratorAttributes;
			class curatorObjectPlaced;
			class curatorObjectEdited;
			class toggleCuratorVisionMode;
		};
	};
};
