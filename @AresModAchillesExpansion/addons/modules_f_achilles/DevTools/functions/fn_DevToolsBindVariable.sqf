////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/1/17
//	VERSION: 2.0
//	FILE: Achilles\modules\fn_DevToolsBindVariable.sqf
//  DESCRIPTION: Module for binding variables to objects
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

private _dialogResult = [
	localize "STR_AMAE_BIND_VAR",
	[
		[localize "STR_AMAE_VAR",""],
		[localize "STR_AMAE_MODE",["Local","Public"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult select 0 == "") exitWith {["No variable entered!"] call Achilles_fnc_ShowZeusErrorMessage};

if (count _dialogResult > 0) then
{
	private _var = _dialogResult select 0;
    if (_dialogResult select 1 == 0) then {_object call compile format["%1 = _this;",_var]} else {[_object, compile format["%1 = _this;",_var], 0]  call Achilles_fnc_spawn};
};

#include "\achilles\modules_f_ares\module_footer.inc"
