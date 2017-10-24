#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_SuppressionTargetCount") then
{
	Ares_SuppressionTargetCount = 0;
};

// Don't delete this module when we're done the script.
private _deleteModuleOnExit = false;

private _targetPhoneticName = [Ares_SuppressionTargetCount] call Ares_fnc_GetPhoneticName;
private _target_name = format [localize "STR_SUPPRESS_X", _targetPhoneticName];
private _dialogResult = 
[
	localize "STR_CREATE_SUPPRESSION_TARGET",
	[
		[localize "STR_NAME", "", _target_name, true]
	]
] call Ares_fnc_ShowChooseDialog;
if (count _dialogResult == 0) exitWith {_deleteModuleOnExit = true};
_target_name = _dialogResult select 0;
_logic setName _target_name;
_logic setVariable ["SortOrder", Ares_SuppressionTargetCount];
[objNull, format [localize "STR_CREATED_SUPPRESSION_TARGET", _target_name]] call bis_fnc_showCuratorFeedbackMessage;
Ares_SuppressionTargetCount = Ares_SuppressionTargetCount + 1;
publicVariable "Ares_SuppressionTargetCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
