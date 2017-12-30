#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_CASTargetCount") then
{
	Ares_CASTargetCount = 0;
};

// Don't delete this module when we're done the script.
_deleteModuleOnExit = false;

private _targetPhoneticName = [Ares_CASTargetCount] call Ares_fnc_GetPhoneticName;
private _target_name = format [localize "STR_AMAE_CAS_X", _targetPhoneticName];
private _dialogResult =
[
	localize "STR_AMAE_CREATE_CAS_TARGET",
	[
		[localize "STR_AMAE_NAME", "", _target_name, true]
	]
] call Ares_fnc_ShowChooseDialog;
if (_dialogResult isEqualTo []) exitWith {_deleteModuleOnExit = true};
_target_name = _dialogResult select 0;
_logic setName _target_name;
_logic setVariable ["SortOrder", Ares_CASTargetCount];
[objNull, format [localize "STR_AMAE_CREATED_SUPPRESSION_TARGET", _target_name]] call bis_fnc_showCuratorFeedbackMessage;
Ares_CASTargetCount = Ares_CASTargetCount + 1;
publicVariable "Ares_CASTargetCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
