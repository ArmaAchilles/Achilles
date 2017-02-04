////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/3/17
//	VERSION: 2.0
//  DESCRIPTION: Function for module "manage advanced composition"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

// load basic advanced compositions
if (isNil "Achilles_var_acs_init_done") then
{
	[] call compile preprocessFileLineNumbers "\achilles\data_f\Adcanced Compositions\Ares_var_advanced_compositions.sqf";
	Achilles_var_acs_init_done = true;
};


createDialog "Ares_composition_Dialog";
["LOADED"] spawn Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;

#include "\achilles\modules_f_ares\module_footer.hpp"