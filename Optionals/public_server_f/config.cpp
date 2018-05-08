class CfgPatches
{
	class achilles_public_server_f
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "ArmA 3 Achilles Mod Inc.";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 1.1.0;
		versionStr = "1.1.0";
		versionAr[] = {1,1,0};

		units[] = {};
		requiredAddons[] = {};
	};
};

class CfgFunctions
{
	class Achilles
	{
		class Server
		{
			file = "\achilles\public_server_f";

			class checkCodeBasedOnBlackList;
		};
	};
};