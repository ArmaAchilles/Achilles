#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_ArtilleryTargetCount") then { Ares_ArtilleryTargetCount = 0 };

// Don't delete this module when we're done the script.
_deleteModuleOnExit = false;

private _targetPhoneticName = [Ares_ArtilleryTargetCount] call Ares_fnc_GetPhoneticName;
private _target_name = format [localize "STR_TARGET", _targetPhoneticName];
private _dialogResult =
[
	localize "STR_CREATE_EDIT_INTEL",
	[
		[localize "STR_NAME", "", _target_name, true]
	]
] call Ares_fnc_showChooseDialog;
if (_dialogResult isEqualTo []) exitWith {_deleteModuleOnExit = true};
_target_name = _dialogResult select 0;
_logic setName _target_name;
_logic setVariable ["SortOrder", Ares_ArtilleryTargetCount];
[objNull, format [localize "STR_CREATED_ARTILLERY_TARGET", _target_name]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ArtilleryTargetCount = Ares_ArtilleryTargetCount + 1;
publicVariable "Ares_ArtilleryTargetCount";

#include "\achilles\modules_f_ares\module_footer.hpp"
