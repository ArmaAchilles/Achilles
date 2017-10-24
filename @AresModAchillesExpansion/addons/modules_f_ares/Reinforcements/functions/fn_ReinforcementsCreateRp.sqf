#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_ReinforcementRpCount") then
{
	Ares_ReinforcementRpCount = 0;
};

private _deleteModuleOnExit = false;

private _targetPhoneticName = [Ares_ReinforcementRpCount] call Ares_fnc_GetPhoneticName;
private _target_name = format ["RP %1", _targetPhoneticName];
private _dialogResult = 
[
	localize "STR_CREATE_NEW_RP",
	[
		[localize "STR_NAME", "", _target_name, true]
	]
] call Ares_fnc_showChooseDialog;
if (count _dialogResult == 0) exitWith {_deleteModuleOnExit = true};
_target_name = _dialogResult select 0;
_logic setName _target_name;
_logic setVariable ["SortOrder", Ares_ReinforcementRpCount];
[objNull, format ["Created RP '%1'", _target_name]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ReinforcementRpCount = Ares_ReinforcementRpCount + 1;
publicVariable "Ares_ReinforcementRpCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
