class Ares // This bit will be prefixed when actually calling the function (e.g. "Ares_fnc_...." )
{
	// Functions to call during initialization. See https://community.bistudio.com/wiki/Functions_Library_(Arma_3)
	class init
	{
		file = "\ares_zeusExtensions\Ares\functions\init";
		class InitAres { preInit = 1; };
	};

	// Functions called in response to events
	class events
	{
		file = "\ares_zeusExtensions\Ares\functions\events";

		class OnModuleTreeLoad;
		class HandleCuratorObjectPlaced;
		class HandleCuratorObjectDoubleClicked;
		class HandleCuratorKeyPressed;
		class HandleCuratorKeyReleased;
		class HandleRemoteKeyPressed;
	};

	// Helper functions
	class util
	{
		file = "\ares_zeusExtensions\Ares\functions";

		class AddUnitsToCurator;
		class AppendToModuleTree;
		class ArsenalSetup;
		class BroadcastCode;
		class CompositionGrabber;
		class CreateLogic;
		class GenerateArsenalBlacklist;
		class GenerateArsenalDataList;
		class GetArrayDataFromUser;
		class GetFarthest;
		class GetGroupUnderCursor;
		class GetNearest;
		class GetPhoneticName;
		class GetSafePos;
		class GetUnitUnderCursor;
		class GlobalExecute;
		class IsZeus;
		class LogMessage;
		class MakePlayerInvisible;
		class MonitorCuratorDisplay;
		class SearchBuilding;
		class ShowChooseDialog;
		class ShowZeusMessage;
		class StringContains;
		class TeleportPlayers;
		class WaitForZeus;
		class ZenOccupyHouse;
	};
	
	// UI handler functions
	class ui
	{
		file = "\ares_zeusExtensions\Ares\ui\functions";

		class RscDisplayAttributes_Teleport;
		class RscDisplayAttributes_Create_Reinforcement;
	};

	// Functions to perform module actions
	class modules
	{
		file = "\ares_zeusExtensions\Ares\modules";
		class Empty;
	};
	
	#include "cfgFunctionsArsenal.hpp"
	#include "cfgFunctionsBehaviour.hpp"
	#include "cfgFunctionsEquipment.hpp"
	#include "cfgFunctionsDevtools.hpp"
	#include "cfgFunctionsPlayer.hpp"
	#include "cfgFunctionsReinforcements.hpp"
	#include "cfgFunctionsSpawn.hpp"
	#include "cfgFunctionsTeleport.hpp"
	#include "cfgFunctionsUtil.hpp"
	#include "cfgFunctionsCustomUserFunctions.hpp"
	#include "cfgFunctionsCustomUserModules.hpp"
};
