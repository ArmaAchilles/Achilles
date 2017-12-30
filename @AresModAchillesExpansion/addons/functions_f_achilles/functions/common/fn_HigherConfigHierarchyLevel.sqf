////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_HigherConfigHierarchyLevel.sqf
//  DESCRIPTION: Returns the config one level higher in hierarchy than the input config.
//
//	ARGUMENTS:
//	_this:					CONFIG	- config of which the upper config level has to be determined
//
//	RETURNS:
//	_this:					CONFIG  - upper level config
//
//	Example:
//	_output_config = _input_config call Achilles_fnc_HigherConfigHierarchyLevel
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _input_config = _this;
private _hierarchy = configHierarchy _input_config;
_hierarchy select ((count _hierarchy) - 2)
