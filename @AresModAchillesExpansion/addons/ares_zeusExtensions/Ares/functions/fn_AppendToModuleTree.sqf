////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_AppendToModuleTree.sqf
//  DESCRIPTION: Appends a module to the module tree
//
//	ARGUMENTS:
//	_this select 0:		CTRL	- tree control UI object
//	_this select 1:		ARRAY	- list of all category display names
//	_this select 2:		STRING	- category display name
//	_this select 3:		STRING	- module display name
//	_this select 4:		STRING	- module class name in config
//	_this select 5:		INTEGER	- value associated to the tree entry
//	_this select 6:		STRING	- path of *.paa icon file
//
//	RETURNS:
//	_this				ARRAY	- updated list of all category display names
//
//	Example:
//	_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex,_moduleIcon] call Ares_fnc_AppendToModuleTree;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_ctrl				= _this select 0;
_category_list		= _this select 1;
_categoryName 		= _this select 2;
_moduleDisplayName 	= _this select 3;
_moduleClassName	= _this select 4;
_value				= param [5,0,[0]];
_moduleIcon			= param [6,"\ares_zeusExtensions\Achilles\data\icon_unit.paa",[""]];

_categoryIndex = _category_list find _categoryName;

if (_categoryIndex == -1) then
{
	// Add categories if it does not already exist
	
	_tvData = "Ares_Module_Empty"; // All of the categories use the 'Empty' module. There's no logic associated with them.
	_tvBranch = _ctrl tvAdd [[], _categoryName];
	_ctrl tvSetData [[_tvBranch], _tvData];
	_categoryIndex = count _category_list;
	_category_list pushBack _categoryName;
};

_moduleIndex = _ctrl tvAdd [[_categoryIndex], _moduleDisplayName];
_newPath = [_categoryIndex, _moduleIndex];
_ctrl tvSetData [_newPath, _moduleClassName];
_ctrl tvSetPicture [_newPath, _moduleIcon];
_ctrl tvSetValue [_newPath, _value];

_category_list;