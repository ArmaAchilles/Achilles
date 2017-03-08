#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_ReinforcementRpCount") then
{
	Ares_ReinforcementRpCount = 0;
};

_deleteModuleOnExit = false;

_targetPhoneticName = [Ares_ReinforcementRpCount] call Ares_fnc_GetPhoneticName;
_target_name = format ["RP %1", _targetPhoneticName];
_dialogResult = 
[
	localize "STR_CREATE_NEW_RP",
	[
		[localize "STR_NAME", "", _target_name]
	]
] call Ares_fnc_showChooseDialog;
if (count _dialogResult == 0) exitWith {_deleteModuleOnExit = true};
_logic setName (_dialogResult select 0);
_logic setVariable ["SortOrder", Ares_ReinforcementRpCount];
[objNull, format ["Created RP '%1'", _targetPhoneticName]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ReinforcementRpCount = Ares_ReinforcementRpCount + 1;
publicVariable "Ares_ReinforcementRpCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
