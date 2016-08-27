#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_SuppressionTargetCount") then
{
	Ares_SuppressionTargetCount = 0;
};

// Don't delete this module when we're done the script.
_deleteModuleOnExit = false;

_targetPhoneticName = [Ares_SuppressionTargetCount] call Ares_fnc_GetPhoneticName;
_logic setName format [localize "STR_SUPPRESS_X", _targetPhoneticName];
_logic setVariable ["SortOrder", Ares_SuppressionTargetCount];
[objNull, format ["STR_CREATED_SUPPRESSION_TARGET", _targetPhoneticName]] call bis_fnc_showCuratorFeedbackMessage;
Ares_SuppressionTargetCount = Ares_SuppressionTargetCount + 1;
publicVariable "Ares_SuppressionTargetCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
