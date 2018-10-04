#include "\achilles\functions_f\macros.hpp"

// Define root path
#define MODULES_ROOT_PATH						\achilles\modules_f

// Achilles module classes
// Module name:		Achilles_mod_<CATEGORY>_<NAME>
#define MODULE(CATEGORY, NAME)					Achilles_module_##CATEGORY##_##NAME

// Achilles module functions
// Function name:	Achilles_fnc_<CATEGORY>_module<NAME>
// Function source:	"\achilles\modules_f\<CATEGORY>\functions\fnc_<NAME>.sqf"
#define DEF_MODULE_FUNC(CATEGORY, NAME)			class CATEGORY##_##NAME {file = QCAT_PATH_2(MODULES_ROOT_PATH, CATEGORY\functions\fnc_##NAME.sqf)}
#define MODULE_FUNC(CATEGORY, NAME)				FUNC_ACHIL_1(CATEGORY, module##NAME)
