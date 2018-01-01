////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_BehaviourChangeAbility.sqf
//  DESCRIPTION: Module for change ability
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private _units = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

{
	if (isPlayer _x) exitWith {
		[localize "STR_AMAE_SELECT_NON_PLAYER_UNITS"] call Achilles_fnc_ShowZeusErrorMessage;
	} 
} forEach _units;

[_units] call Achilles_fnc_changeAbility;

#include "\achilles\modules_f_ares\module_footer.hpp"
