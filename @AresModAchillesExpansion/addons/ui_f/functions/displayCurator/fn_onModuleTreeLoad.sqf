////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 14/11/16
//	VERSION: 3.0
//	FILE: achilles\ui_f\functions\displayCurator\fn_OnModuleTreeLoad.sqf
//  DESCRIPTION: Integrates Ares Modules in Curator Interface Tree
//
//	ARGUMENTS:
//	_this select 0:		BOOL	- load custom modules only (true: append new custom module; false: load entire tree)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[false] call Achilles_fnc_OnModuleTreeLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_display","_ctrl","_category_list","_all_modules","_subCategories","_categoryName","_tvData","_tvBranch","_moduleClassName","_categoryIndex","_newPath"];

disableSerialization;

// Get function  arguments
_custom_only = param [0,false,[false]];

// Get the UI control
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;


//prepare lists
_category_list = [];
_all_modules = (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_ares" >> "units"));
_all_modules append (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_achilles" >> "units"));

// Get all Vanilla Categories
for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	_categoryName = _ctrl tvText [_i];
	_category_list pushBack _categoryName;
};

if (not _custom_only) then
{
	// Add Ares modules
	{
		_moduleClassName = _x;
		_categoryName = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "subCategory");
		_moduleDisplayName = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "displayName");
		_moduleIcon = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "icon");

        _dlc = [(configFile >> "CfgVehicles" >> _moduleClassName), "dlc", ''] call BIS_fnc_returnConfigEntry;
        _addonIcon = [(configFile >> "CfgMods" >> _dlc), "logoSmall", ''] call BIS_fnc_returnConfigEntry;

		_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex,_moduleIcon,_addonIcon] call Achilles_fnc_AppendToModuleTree;
	} forEach _all_modules;
};

// Add Custom modules
if (not isNil "Ares_Custom_Modules") then
{
	{
		_categoryName = _x select 0;
		_moduleDisplayName = _x select 1;
		_moduleClassName = format ["Ares_Module_User_Defined_%1", _forEachIndex];
		
		_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex] call Achilles_fnc_AppendToModuleTree;
	} forEach Ares_Custom_Modules;
};

//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};

//get module list
_category_list sort true;
Ares_category_list = _category_list;



_tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;

//Add missing objects: Rocks
_categoryName = getText (configfile >> "CfgEditorCategories" >> "EdCat_Environment" >> "displayName");
_categoryIndex = _tree_ctrl tvAdd [[],_categoryName];
_subCategoryName = getText (configfile >> "CfgEditorSubcategories" >> "EdSubcat_Rocks" >> "displayName");
_subCategoryIndex = _tree_ctrl tvAdd [[_categoryIndex],_subCategoryName];
{
	_objectName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
	_objectIndex =  _tree_ctrl tvAdd [[_categoryIndex,_subCategoryIndex],_objectName];
	_tree_ctrl tvSetData [[_categoryIndex,_subCategoryIndex,_objectIndex],_x];
} forEach ((configfile >> "CfgVehicles" >> "Rocks_base_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass);
_tree_ctrl tvSort [[_categoryIndex,_subCategoryIndex],false];
_tree_ctrl tvSort [[],false];

//Add missing objects: Ruins
_categoryName = getText (configfile >> "CfgEditorCategories" >> "EdCat_Environment" >> "displayName");
_categoryIndex = _tree_ctrl tvAdd [[],_categoryName];

//{} forEach ((configfile >> "CfgVehicles" >> "Ruins_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass);


//collapse all unit trees
{
	_tree_ctrl = _display displayCtrl _x;
	for "_i" from 0 to ((_tree_ctrl tvCount []) - 1) do
	{
		_tree_ctrl tvCollapse [_i];
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
];

//collapse all group trees
{
	_tree_ctrl = _display displayCtrl _x;
	for "_i" from 0 to ((_tree_ctrl tvCount [0]) - 1) do
	{
		_tree_ctrl tvCollapse [0,_i];
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY
];
