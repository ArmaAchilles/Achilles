////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 11/20/16
//	VERSION: 3.0
//	FILE: achilles\ui_f\functions\displayCurator\fn_OnModuleTreeLoad.sqf
//  DESCRIPTION: Integrates Custom Modules in Curator Interface Tree
//
//	ARGUMENTS:
//	nothing
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[false] call Achilles_fnc_OnModuleTreeLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_display","_ctrl","_category_list","_subCategories","_categoryName","_tvData","_tvBranch","_moduleClassName","_categoryIndex","_newPath"];

disableSerialization;

// Get the UI control
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

_category_list = [];

// Get all Vanilla Categories
for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	_categoryName = _ctrl tvText [_i];
	_category_list pushBack _categoryName;
};

// Add Custom modules
{
	_categoryName = _x select 0;
	_moduleDisplayName = _x select 1;
	_moduleClassName = format ["Ares_Module_User_Defined_%1", _forEachIndex];
	
	_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex] call Achilles_fnc_AppendToModuleTree;
} forEach Ares_Custom_Modules;

//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};

//get module list
_category_list sort true;
Ares_category_list = _category_list;
