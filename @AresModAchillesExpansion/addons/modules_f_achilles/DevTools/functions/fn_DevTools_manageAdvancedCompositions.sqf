////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/9/16
//	VERSION: 1.0
//	FILE: Ares\modules\DevTools\fn_DevTools_manageAdvancedCompositions.sqf
//  DESCRIPTION: Function for module "manage advanced composition"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "\achilles\modules_f_ares\module_header.hpp"

// load basic advanced compositions
if (isNil "Achilles_var_acs_init_done") then
{
	[] call compile preprocessFileLineNumbers "\achilles\data_f_achilles\Adcanced Compositions\Ares_var_advanced_compositions.sqf";
	Achilles_var_acs_init_done = true;
};

createDialog "Ares_composition_Dialog";
["LOADED"] spawn Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;

#include "\achilles\modules_f_ares\module_footer.hpp"