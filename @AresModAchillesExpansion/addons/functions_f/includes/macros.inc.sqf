/*
	Authors:
		Kex
	
	Description:
		Macros for function and variable names and definitions
*/


// Helper macros
// Quotes
#define _QUOTE(INP)										#INP
#define QUOTE(INP)										_QUOTE(INP)
#define _DBLQUOTE(INP)									QUOTE(#INP)
#define DBLQUOTE(INP)									_DBLQUOTE(INP)

// Concatenate paths
#define QCAT_PATH_2(PATH1, PATH2)						QUOTE(PATH1\PATH2)

// Define root path
#define FUNCTIONS_ROOT_PATH								\achilles\functions_f\functions

// Functions in Achilles convention with 0 category levels
// Function name:	<ADDON>_fnc_<NAME>
#define FUNC_0(ADDON, NAME)								ADDON##_fnc_##NAME
#define QFUNC_0(ADDON, NAME)							QUOTE(FUNC_0(ADDON, NAME))
#define QQFUNC_0(ADDON, NAME)							DBLQUOTE(FUNC_0(ADDON, NAME))

// Variables in Achilles convention with 0 category levels
// Variable name:	<ADDON>_var_<NAME>
#define GVAR_0(ADDON, NAME)								ADDON##_var_##NAME
#define QGVAR_0(ADDON, NAME)							QUOTE(GVAR_0(ADDON, NAME))
#define QQGVAR_0(ADDON, NAME)							DBLQUOTE(GVAR_0(ADDON, NAME))

// Functions in Achilles convention with 1 category level
// Function name:	<ADDON>_fnc_<CATEGORY>_<NAME>
#define FUNC_1(ADDON, CATEGORY, NAME)					ADDON##_fnc_##CATEGORY##_##NAME
#define QFUNC_1(ADDON, CATEGORY, NAME)					QUOTE(FUNC_1(ADDON, CATEGORY, NAME))
#define QQFUNC_1(ADDON, CATEGORY, NAME)					DBLQUOTE(FUNC_1(ADDON, CATEGORY, NAME))

// Variables in Achilles convention with 1 category level
// Variable name:	<ADDON>_fnc_<CATEGORY>_<NAME>
#define GVAR_1(ADDON, CATEGORY, NAME)					ADDON##_var_##CATEGORY##_##NAME
#define QGVAR_1(ADDON, CATEGORY, NAME)					QUOTE(GVAR_1(ADDON, CATEGORY, NAME))
#define QQGVAR_1(ADDON, CATEGORY, NAME)					DBLQUOTE(GVAR_1(ADDON, CATEGORY, NAME))

// Functions in Achilles convention with 2 category levels
// Function name:	<ADDON>_fnc_<CATEGORY>_<NAME>
#define FUNC_2(ADDON, CATEGORY, SUBCATEGORY, NAME)		ADDON##_fnc_##CATEGORY##_##SUBCATEGORY##_##NAME
#define QFUNC_2(ADDON, CATEGORY, SUBCATEGORY, NAME)		QUOTE(FUNC_2(ADDON, CATEGORY, SUBCATEGORY, NAME))
#define QQFUNC_2(ADDON, CATEGORY, SUBCATEGORY, NAME)	DBLQUOTE(FUNC_2(ADDON, CATEGORY, SUBCATEGORY, NAME))

// Variables in Achilles convention with 2 category levels
// Variable name:	<ADDON>_fnc_<CATEGORY>_<NAME>
#define GVAR_2(ADDON, CATEGORY, SUBCATEGORY, NAME)		ADDON##_var_##CATEGORY##_##SUBCATEGORY##_##NAME
#define QGVAR_2(ADDON, CATEGORY, SUBCATEGORY, NAME)		QUOTE(GVAR_2(ADDON, CATEGORY, SUBCATEGORY, NAME))
#define QQGVAR_2(ADDON, CATEGORY, SUBCATEGORY, NAME)	DBLQUOTE(GVAR_2(ADDON, CATEGORY, SUBCATEGORY, NAME))

// Achilles functions with 1 category level
// Function name:	Achilles_fnc_<CATEGORY>_<NAME>
// Function source:	"\achilles\functions_f\<CATEGORY>\fnc_<NAME>.sqf"
#define DEF_FUNC_ACHIL_1(CATEGORY, NAME)				class CATEGORY##_##NAME {file = QCAT_PATH_2(FUNCTIONS_ROOT_PATH, CATEGORY\fnc_##NAME.sqf)}
#define FUNC_ACHIL_1(CATEGORY, NAME)					FUNC_1(Achilles, CATEGORY, NAME)
#define QFUNC_ACHIL_1(CATEGORY, NAME)					QFUNC_1(Achilles, CATEGORY, NAME)
#define QQFUNC_ACHIL_1(CATEGORY, NAME)					QQFUNC_1(Achilles, CATEGORY, NAME)

// Achilles variables with 1 category level
// Variable name:	Achilles_var_<CATEGORY>_<NAME>
#define GVAR_ACHIL_1(CATEGORY, NAME)					GVAR_1(Achilles, CATEGORY, NAME)
#define QGVAR_ACHIL_1(CATEGORY, NAME)					QGVAR_1(Achilles, CATEGORY, NAME)
#define QQGVAR_ACHIL_1(CATEGORY, NAME)					QQGVAR_1(Achilles, CATEGORY, NAME)

// Achilles functions with 2 category levels
// Function name:	Achilles_fnc_<CATEGORY>_<SUBCATEGORY>_<NAME>
// Function source:	"\achilles\functions_f\<CATEGORY>\<SUBCATEGORY>\fnc_<NAME>.sqf"
#define DEF_FUNC_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)	class CATEGORY##_##SUBCATEGORY##_##NAME {file = QCAT_PATH_2(FUNCTIONS_ROOT_PATH, CATEGORY\SUBCATEGORY\fnc_##NAME.sqf)}
#define FUNC_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		FUNC_2(Achilles, CATEGORY, SUBCATEGORY, NAME)
#define QFUNC_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		QFUNC_2(Achilles, CATEGORY, SUBCATEGORY, NAME)
#define QQFUNC_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		QQFUNC_2(Achilles, CATEGORY, SUBCATEGORY, NAME)

// Achilles variables with 2 category levels
// Name:	Achilles_var_<CATEGORY>_<SUBCATEGORY>_<NAME>
#define GVAR_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		GVAR_2(Achilles, CATEGORY, SUBCATEGORY, NAME)
#define QGVAR_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		QGVAR_2(Achilles, CATEGORY, SUBCATEGORY, NAME)
#define QQGVAR_ACHIL_2(CATEGORY, SUBCATEGORY, NAME)		QQGVAR_2(Achilles, CATEGORY, SUBCATEGORY, NAME)

// Ares functions with 1 category level
// Function name:	Ares_fnc_<NAME>
// Function source:	"\achilles\functions_f\ares\fnc_<NAME>.sqf"
#define DEF_FUNC_ARES_0(NAME)							class NAME {file = QCAT_PATH_2(FUNCTIONS_ROOT_PATH, ares\fnc_##NAME.sqf)}
#define FUNC_ARES_0(NAME)								FUNC_0(Ares, NAME)
#define QFUNC_ARES_0(NAME)								QFUNC_0(Ares, NAME)
#define QQFUNC_ARES_0(NAME)								QQFUNC_0(Ares, NAME)

// Ares variables with 0 category levels
// Name:	Ares_var_<NAME>
#define GVAR_ARES_0(NAME)								GVAR_0(Ares, NAME)
#define QGVAR_ARES_0(NAME)								QGVAR_0(Ares, NAME)
#define QQGVAR_ARES_0(NAME)								QQGVAR_0(Ares, NAME)

// CBA functions with 0 category levels
// Function name:	CBA_fnc_<NAME>
#define FUNC_CBA_0(NAME)								GVAR_0(CBA, NAME)
#define QFUNC_CBA_0(NAME)								QGVAR_0(CBA, NAME)
#define QQFUNC_CBA_0(NAME)								QQGVAR_0(CBA, NAME)

// ACE functions with 1 category level
// (note that ACE convention is different from Achilles, since it does not use the BIS function framework)
// Function name:	ACE_<CATEGORY>_fnc_<NAME>
#define FUNC_ACE_1(CATEGORY, NAME)						ACE_##CATEGORY##_fnc_##NAME
#define QFUNC_ACE_1(CATEGORY, NAME)						QUOTE(FUNC_ACE_1(CATEGORY, NAME))
#define QQFUNC_ACE_1(CATEGORY, NAME)					DBLQUOTE(FUNC_ACE_1(CATEGORY, NAME))

// ACE functions with 1 category level
// (note that ACE convention is different from Achilles)
// Variable name:	ACE_<CATEGORY>_<NAME>
#define GVAR_ACE_1(CATEGORY, NAME)						ACE_##CATEGORY##_##NAME
#define QGVAR_ACE_1(CATEGORY, NAME)						QUOTE(GVAR_ACE_1(CATEGORY, NAME))
#define QQGVAR_ACE_1(CATEGORY, NAME)					DBLQUOTE(GVAR_ACE_1(CATEGORY, NAME))
