/*
	Author: CreepPork_LV

	Description:
	 Hides an object on the map.

  Parameters:
    None

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

private _dialogResult =
[
	localize "STR_AMAE_HIDE_OBJECTS",
	[
		[localize "STR_AMAE_IS_OBJECT_HIDDEN", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _isHidden = (_dialogResult select 0) == 0;

if (isNull (_objects select 0)) then { _objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits; };
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_showZeusErrorMessage};

{
	[_x, _isHidden] remoteExecCall ["hideObjectGlobal", 2];
} forEach _objects;

#include "\achilles\modules_f_ares\module_footer.hpp"
