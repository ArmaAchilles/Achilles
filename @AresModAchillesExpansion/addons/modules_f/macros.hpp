#include "\achilles\functions_f\macros.hpp"

// Define root path
#define MODULES_ROOT_PATH						\achilles\modules_f

// Module classes
// Module base name:			<ADDON>_module_base_f
#define MODULE_BASE(ADDON)						ADDON##_module_base_f

// Module category base name:	<ADDON>_module_<CATEGORY>_base_f
#define MODULE_CATEGORY_BASE(ADDON, CATEGORY)	ADDON##_module_##CATEGORY##_base_f

// Module name:					<ADDON>_module_<CATEGORY>_<NAME>_f
#define MODULE(ADDON, CATEGORY, NAME)			ADDON##_module_##CATEGORY##_##NAME##_f

// Achilles module classes
// Module base name:			Achilles_module_base_f
#define MODULE_BASE_ACHIL						MODULE_BASE(Achilles)

// Module category base name:	Achilles_module_<CATEGORY>_base_f
#define MODULE_CATEGORY_BASE_ACHIL(CATEGORY)	MODULE_CATEGORY_BASE(Achilles, CATEGORY)

// Module name:					Achilles_module_<CATEGORY>_<NAME>_f
#define MODULE_ACHIL(CATEGORY, NAME)			MODULE(Achilles, CATEGORY, NAME)

// Achilles module functions
// Function name:	Achilles_fnc_<CATEGORY>_module<NAME>
// Function source:	"\achilles\modules_f\<CATEGORY>\functions\fnc_<NAME>.sqf"
#define DEF_MODULE_FUNC_ACHIL(CATEGORY, NAME)			class CATEGORY##_##NAME {file = QCAT_PATH_2(MODULES_ROOT_PATH, CATEGORY\functions\fnc_##NAME.sqf)}
#define MODULE_FUNC_ACHIL(CATEGORY, NAME)				FUNC_ACHIL_1(CATEGORY, module##NAME)
