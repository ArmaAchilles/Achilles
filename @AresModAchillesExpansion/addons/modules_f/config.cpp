#include "macros.hpp"

class CfgPatches
{
	class achilles_modules_f
	{
		weapons[] = {};
		requiredVersion = 1.82;
		author = "Achilles Dev Team";
		authorUrl = "https://github.com/ArmaAchilles/AresModAchillesExpansion";
		version = 2.0.0;
		versionStr = "2.0.0";
		versionAr[] = {2,0,0};
		
		#include "cfgUnits.hpp"
		#include "cfgRequired.hpp"
	};
};

#include "cfgFunctions.hpp"
#include "cfgFactionClasses.hpp"
#include "cfgVehicles.hpp"
