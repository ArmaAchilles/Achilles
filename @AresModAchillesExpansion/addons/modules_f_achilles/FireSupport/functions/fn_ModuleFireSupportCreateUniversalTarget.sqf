/*
	Author: CreepPork_LV

	Description:
		A universal target module that can be used for all modules that require a target.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Achilles_TargetCount") then { Achilles_TargetCount = 0 };

private _targetPhoneticName = [Achilles_TargetCount] call Ares_fnc_GetPhoneticName;
private _targetName = format [localize "STR_AMAE_TARGET", _targetPhoneticName];

private _dialogResult =
[
	localize "STR_AMAE_CREATE_TARGET",
	[
		["TEXT", localize "STR_AMAE_NAME", [], _targetName, true]
	]
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_targetName"];

_logic setName _targetName;
_logic setVariable ["SortOrder", Achilles_TargetCount];

[format [localize "STR_AMAE_CREATED_TARGET", _targetName]] call Ares_fnc_showZeusMessage;

Achilles_TargetCount = Achilles_TargetCount + 1;
publicVariable "Achilles_TargetCount";

_deleteModuleOnExit = false;

#include "\achilles\modules_f_ares\module_footer.hpp"