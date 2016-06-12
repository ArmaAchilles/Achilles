#include "\ares_zeusExtensions\Ares\module_header.hpp"

if (isNil "Ares_ReinforcementRpCount") then
{
	Ares_ReinforcementRpCount = 0;
};

_deleteModuleOnExit = false;

_targetPhoneticName = [Ares_ReinforcementRpCount] call Ares_fnc_GetPhoneticName;
_logic setName format ["RP %1", _targetPhoneticName];
_logic setVariable ["SortOrder", Ares_ReinforcementRpCount];
[objNull, format ["Created RP '%1'", _targetPhoneticName]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ReinforcementRpCount = Ares_ReinforcementRpCount + 1;
publicVariable "Ares_ReinforcementRpCount";

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
