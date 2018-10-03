/*
	Author: CreepPork_LV

	Description:
	 Adds a possiblity to rotate an object on either the X, Y, Z axis.

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_showZeusErrorMessage};
if (_object isKindOf "Man") exitWith {[localize "STR_AMAE_UNITS_NOT_ALLOWED"] call Achilles_fnc_showZeusErrorMessage};

private _angles = _object call BIS_fnc_getPitchBank;

private _dialogResult =
[
	localize "STR_AMAE_ROTATION_MODULE",
	[
		["SLIDER", localize "STR_AMAE_PITCH_ANGLE", [[-180,180]], _angles select 0, true],
		["SLIDER", localize "STR_AMAE_ROLL_ANGLE", [[-180,180]], _angles select 1, true],
		["SLIDER", localize "STR_AMAE_YAW_ANGLE", [[-180,180]], direction _object, true]
	]
] call Achilles_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

if (local _object) then
{
	_object setDir (_dialogResult select 2);
	[_object, _dialogResult select 0, _dialogResult select 1] call BIS_fnc_setPitchBank;
}
else
{
	[_object, _dialogResult select 2] remoteExecCall ["setDir", _object];
	[_object, _dialogResult select 0, _dialogResult select 1] remoteExecCall ["BIS_fnc_setPitchBank", _object];
};

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
