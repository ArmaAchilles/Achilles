
class CfgFunctions
{
	class Ares // This bit will be prefixed when actually calling the function (e.g. "Achilles_fnc_...." )
	{
		class functions_f_common
		{
			file = "\achilles\functions_f_ares\common";
			
			class CreateLogic;
			class GetArrayDataFromUser;
			class GetFarthest;
			class GetGroupUnderCursor;
			class GetNearest;
			class GetPhoneticName;
			class GetSafePos;
			class GetUnitUnderCursor;
			class IsZeus;
			class LogMessage;
			class ShowZeusMessage;
			class StringContains;
			class WaitForZeus;
			class ExecuteCustomModuleCode;
			class RegisterCustomModule;
		};
		
		class functions_f_features
		{
			file = "\achilles\functions_f_ares\features";
			
			class addIntel;
			class AddUnitsToCurator;
			class ArsenalSetup;
			class GenerateArsenalBlacklist;
			class GenerateArsenalDataList;
			class SearchBuilding;
			class surrenderUnit;
			class TeleportPlayers;
			class ZenOccupyHouse;
		};
	};
};
