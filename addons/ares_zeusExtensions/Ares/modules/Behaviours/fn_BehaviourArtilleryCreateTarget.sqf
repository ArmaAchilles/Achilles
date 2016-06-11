#include "\ares_zeusExtensions\Ares\module_header.hpp"

if (isNil "Ares_ArtilleryTargetCount") then
{
	Ares_ArtilleryTargetCount = 0;
};

// Don't delete this module when we're done the script.
_deleteModuleOnExit = false;

_targetPhoneticName = [Ares_ArtilleryTargetCount] call Ares_fnc_GetPhoneticName;
_logic setName format ["Target %1", _targetPhoneticName];
_logic setVariable ["SortOrder", Ares_ArtilleryTargetCount];
[objNull, format ["Created Artillery Target '%1'", _targetPhoneticName]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ArtilleryTargetCount = Ares_ArtilleryTargetCount + 1;
publicVariable "Ares_ArtilleryTargetCount";

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
