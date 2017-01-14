////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/1/17
//	VERSION: 2.0
//	FILE: Achilles\modules\fn_DevToolsBindVariable.sqf
//  DESCRIPTION: Module for binding variables to objects
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _object) exitWith {["No object selected!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

_dialogResult = [
	"Bind object to variable:",
	[
		["Variable:",""]
	]
] call Ares_fnc_ShowChooseDialog;
if (count _dialogResult > 0) then 
{
	_var = _dialogResult select 0;
	_object call compile format["%1 = _this;",_var];
};

#include "\achilles\modules_f_ares\module_footer.hpp"