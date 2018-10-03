////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/27/17
//	VERSION: 1.0
//  DESCRIPTION: Module for showing config of an object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (player isKindOf "VirtualCurator_F") exitWith {[localize "STR_AMAE_CANNOT_BE_USED_BY_VIRTUAL_CURATORS"] call Achilles_fnc_ShowZeusErrorMessage};
if (isNull _unit) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};
[[typeOf _unit, animationState _unit]] call BIS_fnc_animViewer;

#include "\achilles\modules_f_ares\module_footer.inc"
