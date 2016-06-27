////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_ClassNamesWhichInheritsFromCfgClass.sqf
//  DESCRIPTION: Returns an array of configs which inherits from the input config (ONLY THOSE THAT ARE IN THE SAME HIERARCHY!)
//
//	ARGUMENTS:
//	_this:					CONFIG	- config form which the searched classes inherits
//
//	RETURNS:
//	_this:					ARRAY  - array of class names which inherits from the given config
//
//	Example:
//	_class_name_list = _paret_cfg_class call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_parent_cfg_class = _this;
_output = [];
_condition = format["configName _x isKindOf ""%1""",configName _parent_cfg_class];
_higherHierarchyLevel = _parent_cfg_class call Achilles_fnc_higherConfigHierarchyLevel;
{
	_output pushBack (configName _x);
} forEach (_condition configClasses _higherHierarchyLevel);
_output = _output - [configName _parent_cfg_class];
_output;