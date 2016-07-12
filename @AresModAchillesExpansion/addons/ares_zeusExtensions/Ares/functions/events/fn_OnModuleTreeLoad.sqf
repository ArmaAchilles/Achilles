////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 6/3/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_OnModuleTreeLoad.sqf
//  DESCRIPTION: Integrates Ares Modules in Curator Interface Tree
//
//	ARGUMENTS:
//	_this select 0:		BOOL	- load custom modules only (true: append new custom module; false: load entire tree)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[false] call Ares_fnc_OnModuleTreeLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_CATEGORIES_TO_REMOVE = [localize "STR_ANIMALS", localize "STR_CHEM_LIGHTS", localize "STR_EFFECTS", localize "STR_FLARES", localize "STR_SMOKE_SHELLS", localize "STR_TRAINING"];

private ["_display","_ctrl","_category_list","_all_modules","_subCategories","_categoryName","_tvData","_tvBranch","_moduleClassName","_categoryIndex","_newPath"];

disableSerialization;

// Get function  arguments
_custom_only = param [0,false,[false]];

// Get the UI control
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;


//prepare lists
_category_list = [];
_all_modules = (getArray (configFile >> "cfgPatches" >> "Ares" >> "units"));
_all_modules append (getArray (configFile >> "cfgPatches" >> "Achilles" >> "units"));


// Get all Vanilla Categories we want and delete the undesired ones	

private _i = 0;
while {_i < (_ctrl tvCount [])} do
{
	_categoryName = _ctrl tvText [_i];
	if (_categoryName in _CATEGORIES_TO_REMOVE) then
	{
		_ctrl tvDelete [_i];
	} else
	{
		_category_list pushBack _categoryName;
		_i = _i + 1;
	};
};
if (not _custom_only) then
{
	// Add Ares modules
	{
		_moduleClassName = _x;
		_categoryName = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "subCategory");
		_moduleDisplayName = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "displayName");
		_moduleIcon = gettext (configFile >> "CfgVehicles" >> _moduleClassName >> "icon");
		
		_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex,_moduleIcon] call Ares_fnc_AppendToModuleTree;
	} forEach _all_modules;
};
// Add Custom modules
if (not isNil "Ares_Custom_Modules") then
{
	{
		_categoryName = _x select 0;
		_moduleDisplayName = _x select 1;
		_moduleClassName = format ["Ares_Module_User_Defined_%1", _forEachIndex];
		
		_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex] call Ares_fnc_AppendToModuleTree;
	} forEach Ares_Custom_Modules;
};

//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};

//get module list
_category_list sort true;
Ares_category_list = _category_list;
