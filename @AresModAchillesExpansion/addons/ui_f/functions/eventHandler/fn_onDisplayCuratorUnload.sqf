////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/10/17
//	VERSION: 1.0
//  DESCRIPTION: Called when display curator is unloaded
//
//	ARGUMENTS:
//	_this select 0:		display	- curator display
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_curatorDisplay] call Achilles_fnc_onDisplayCuratorunload;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

// custom stacked curator display event handler
_code_list = (getAssignedCuratorLogic player) getVariable ["Achilles_var_onUnloadCuratorInterface",[]];
{[_this] call _x} forEach _code_list;

// execute vanilla display curator function
["onUnload",_this,"RscDisplayCurator","CuratorDisplays"] call (uinamespace getvariable "BIS_fnc_initDisplay");