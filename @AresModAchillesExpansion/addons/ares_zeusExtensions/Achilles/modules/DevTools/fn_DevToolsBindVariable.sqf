////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/5/16
//	VERSION: 1.0
//	FILE: Achilles\modules\fn_DevToolsBindVariable.sqf
//  DESCRIPTION: Module for binding variables to objects
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\ares_zeusExtensions\Ares\module_header.hpp"

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
	[(compile format["%1 = _this;",_var]), _object, 0] call Ares_fnc_BroadcastCode;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"