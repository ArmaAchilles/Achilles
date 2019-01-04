////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/1/17
//	VERSION: 3.0
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

private _units = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

[[_units]] call Achilles_fnc_Animation;

#include "\achilles\modules_f_ares\module_footer.hpp"
