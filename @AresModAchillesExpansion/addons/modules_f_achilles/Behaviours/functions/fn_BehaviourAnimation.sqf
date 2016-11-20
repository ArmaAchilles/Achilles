////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/19/16
//	VERSION: 2.0
//	FILE: Achilles\functions\fn_BehaviourAnimation.sqf
//  DESCRIPTION: Function for the module Animations
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

//Broadcast animation function
if (isNil "Achilles_var_animation_init_done") then
{
	publicVariable "Achilles_fnc_ambientAnimGetParams";
	publicVariable "Achilles_fnc_ambientAnim";
	Achilles_var_animation_init_done = true;
};

_units = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

[_units] call Achilles_fnc_Animation;

#include "\achilles\modules_f_ares\module_footer.hpp"
