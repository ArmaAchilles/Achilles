/*
	Registers a new module to be displayed in the Ares custom module tree.
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_categoryName = _this select 0;
_moduleDisplayName = _this select 1;
_codeBlock = _this select 2;

if (isNil "Ares_Custom_Modules") then
{
	Ares_Custom_Modules = [];
};

_replacedExistingEntry = false;
{
	if (_categoryName == (_x select 0) and _moduleDisplayName == (_x select 1)) exitWith
	{
		_replacedExistingEntry = true;
		_x set [2, _codeBlock];
	};
} forEach Ares_Custom_Modules;

if (not _replacedExistingEntry) then
{
	disableSerialization;
	
	// Get the UI
	_display = findDisplay IDD_RSCDISPLAYCURATOR;
	
	// Add module to list
	_index = count Ares_Custom_Modules;
	_moduleClassName = format ["Ares_Module_User_Defined_%1", _index];
	Ares_Custom_Modules pushBack [_categoryName, _moduleDisplayName, _codeBlock];
	
	// Handle Post-Init execution
	if(isNull _display) exitWith {};
	
	// Add module to module tree
	_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	_category_list = [_ctrl,Ares_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_index] call Achilles_fnc_AppendToModuleTree;
	
	//Sort category and module list
	_ctrl tvSort [[], false];
	for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};
	
	//get module list
	_category_list sort true;
	Ares_category_list = _category_list;
};
