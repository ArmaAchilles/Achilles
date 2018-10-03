////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_BehaviourChangeAbility.sqf
//  DESCRIPTION: Module for change ability
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.inc"

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

[_unit] call Achilles_fnc_changeAbility;

#include "\achilles\modules_f_ares\module_footer.inc"
