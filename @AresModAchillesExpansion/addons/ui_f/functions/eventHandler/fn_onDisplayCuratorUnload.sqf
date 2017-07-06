////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/26/17
//	VERSION: 3
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
["Achilles_onUnloadCuratorInterface", _this, player] call CBA_fnc_targetEvent;

// execute vanilla display curator function
["onUnload",_this,"RscDisplayCurator","CuratorDisplays"] call (uinamespace getvariable "BIS_fnc_initDisplay");