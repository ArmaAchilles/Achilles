/*
	Author: CreepPork_LV

	Description:
	 Adds a possiblity to rotate an object on either the X, Y, Z axis.

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Achilles_fnc_showZeusErrorMessage};
if (_object isKindOf "Man") exitWith {[localize "STR_UNITS_NOT_ALLOWED"] call Achilles_fnc_showZeusErrorMessage};

private _currentVectorUp = vectorUp _object;

private _dialogResult =
[
	localize "STR_ROTATION_MODULE",
	[
		[format [localize "STR_ROTATION_MODULE_X_AXIS", "X"], "SLIDER", _currentVectorUp select 0, true],
		[format [localize "STR_ROTATION_MODULE_X_AXIS", "Y"], "SLIDER", _currentVectorUp select 1, true],
		[format [localize "STR_ROTATION_MODULE_X_AXIS", "Z"], "SLIDER", _currentVectorUp select 2, true]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

if (local _object) then
{
	_object setVectorUp [_dialogResult select 0, _dialogResult select 1, _dialogResult select 2];
}
else
{
	[_object, [_dialogResult select 0, _dialogResult select 1, _dialogResult select 2]] remoteExecCall ["setVectorUp", _object];
};

#include "\achilles\modules_f_ares\module_footer.hpp"