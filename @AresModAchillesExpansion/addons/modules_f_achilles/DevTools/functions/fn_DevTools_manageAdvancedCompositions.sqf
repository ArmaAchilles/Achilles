////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: 		Kex
//	DATE: 			7/16/17
//	VERSION: 		AMAE003
//  DESCRIPTION: 	Function for module "advanced composition"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

// load basic advanced compositions
if (isNil "Achilles_var_acs_init_done") then
{
	call compile preprocessFileLineNumbers "\achilles\data_f_achilles\Advanced Compositions\Ares_var_advanced_compositions.sqf";
	Achilles_var_acs_init_done = true;
};

createDialog "Ares_composition_Dialog";
["LOADED"] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;

#include "\achilles\modules_f_ares\module_footer.inc"
