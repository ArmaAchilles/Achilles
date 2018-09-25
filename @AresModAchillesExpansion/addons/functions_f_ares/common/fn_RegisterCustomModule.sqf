////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Anton Struyk
//
//  DESCRIPTION: Registers a new module to be displayed in the Ares custom module tree.
//
//	ARGUMENTS:
//	_this select 0:		STRING	- Module Category Name (if the name already exists, the modul will be appended to that category)
//	_this select 1:		STRING	- Module Name (the same name can be used multiple times, but this is not recommended)
//	_this select 2:		CODE	- Code that is executed when the module is placed.
//
//		ARGUMENTS FOR THE CODE
//		_this select 0: 	ARRAY	- Returns position AGLS where the module was placed.
//		_this select 1:		OBJECT  - Returns ObjNull or the object on which the module was placed.
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	["My Category", "My Module", { systemChat name (_this select 1); }] call Ares_fnc_RegisterCustomModule;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_categoryName", "_moduleDisplayName", "_codeBlock"];

if (isNil "Ares_Custom_Modules") then { Ares_Custom_Modules = [] };

private _replacedExistingEntry = false;
{
	if (_categoryName == (_x select 0) and _moduleDisplayName == (_x select 1)) exitWith
	{
		_replacedExistingEntry = true;
		_x set [2, _codeBlock];
	};
} forEach Ares_Custom_Modules;

if (!_replacedExistingEntry) then
{
	disableSerialization;

	// Get the UI
	private _display = findDisplay IDD_RSCDISPLAYCURATOR;

	// Add module to list
	private _index = count Ares_Custom_Modules;
	private _moduleClassName = format ["Ares_Module_User_Defined_%1", _index];
	Ares_Custom_Modules pushBack [_categoryName, _moduleDisplayName, _codeBlock];

	// Handle Post-Init execution
	if(isNull _display) exitWith {};

	// Add module to module tree
	private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	private _category_list = missionNamespace getVariable ["Ares_category_list", []];
	_category_list = [_ctrl, _category_list, _categoryName, _moduleDisplayName, _moduleClassName, _index] call Achilles_fnc_AppendToModuleTree;

	//Sort category and module list
	_ctrl tvSort [[], false];
	for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};

	//get module list
	_category_list sort true;
	Ares_category_list = _category_list;
};
