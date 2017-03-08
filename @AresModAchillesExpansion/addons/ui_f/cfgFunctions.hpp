
class CfgFunctions
{
	class Achilles // This bit will be prefixed when actually calling the function (e.g. "Ares_fnc_...." )
	{
		class ui_f_init
		{
			file = "\achilles\ui_f\functions\init";
			
			class onGameStarted;
		};
		
		class ui_f_displayCurator
		{
			file = "\achilles\ui_f\functions\displayCurator";
			
			class AppendToModuleTree;
			class onDisplayCuratorLoad;
			class onModuleTreeLoad;
		};
		
		
		class ui_f_keyEvents
		{
			file = "\achilles\ui_f\functions\keyEvents";
			
			class HandleCuratorKeyPressed;
			class HandleCuratorKeyReleased;
			class HandleRemoteKeyPressed;
			class HandleCuratorObjectDoubleClicked;
			class HandleCuratorObjectPlaced;
			class HandleCuratorGroupPlaced;
			class HandleCuratorObjectEdited;
		};
		
		class ui_f_common
		{
			file = "\achilles\ui_f\functions\common";
			class SelectUnits;
			class sideTab;
		};
				
		class ui_f_dialogs
		{
			file = "\achilles\ui_f\functions\dialogs";

			class RscDisplayAttributes_selectPlayers;
			class RscDisplayAttributes_Create_Reinforcement;
			class RscDisplayAttributes_BuildingsDestroy;
			class RscDisplayAtttributes_SpawnEffect;
			class RscDisplayAttributes_SpawnAdvancedComposition;
			class RscDisplayAttributes_manageAdvancedComposition;
			class RscDisplayAttributes_createAdvancedComposition;
			class RscDisplayAttributes_editAdvancedComposition;
			class RscDisplayAttributes_SpawnExplosives;
			class RscDisplayAtttributes_SpawnIntel;
			class RscDisplayAtttributes_DamageComponents;
			class RscDisplayAttributes_Chatter;
			class RscDisplayAtttributes_ChangeSkills;
			class RscDisplayAttributes_SpawnEmptyObject;
			class RscDisplayAttributes_selectAIUnits;
			class RscDisplayAttributes_editableObjects;
		};
	};
	
	class Ares
	{
		class ui_f_dynamic // This bit will be prefixed when actually calling the function (e.g. "Ares_fnc_...." )
		{
			file = "\achilles\ui_f\functions\dynamic";

			class ShowChooseDialog;			
		}
	}
};
