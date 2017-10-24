////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/3/17
//	VERSION: 1.0
//  DESCRIPTION: Function that creates an intel
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

#define INTEL_OBJECTS 		["Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Map_unfolded_F","Land_Laptop_unfolded_F","Land_MobilePhone_smart_F","Land_Tablet_01_F","Land_Tablet_02_F"]
#define SEARCH_ICON			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"

//Broadcast intel function
if (isNil "Achilles_var_intel_init_done") then
{
	publicVariable "Ares_fnc_addIntel";
	Achilles_var_intel_init_done = true;
};

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

private _dialog_title = localize "STR_CREATE_INTEL_ON_OBJECT";
private _dialog_options =
[
	[localize "STR_ACTION_TEXT","",localize "STR_PICK_UP_INTEL"],
	[localize "STR_ACTION_DURATION","","1"],
	[localize "STR_DELETE_OBJECT_ON_COMPLETION",[localize "STR_TRUE",localize "STR_FALSE"],1],
	[localize "STR_INTEL_TITLE",""],
	[localize "STR_INTEL_TEXT", "MESSAGE"],
	[localize "STR_INTEL_SHARED_WITH", [localize "STR_SIDE", localize "STR_GROUP", localize "STR_NO_ONE"]]
];

if (isNull _object) then
{
	// case spawn intel
	_dialog_title = localize "STR_SPAWN_INTEL";
	_dialog_options = [[localize "STR_OBJECT", INTEL_OBJECTS apply {getText (configfile >> "CfgVehicles" >> _x >> "displayName")}]] + _dialog_options;
} else
{
	private _previous_dialogResult = _object getVariable ["Achilles_var_intel",[]];
	if (count _previous_dialogResult == count _dialog_options) then
	{
		// case edit intel
		_dialog_title = format [localize "STR_EDIT_INTEL_X", _previous_dialogResult select 3];
		{
			_x set [2, _previous_dialogResult select _forEachIndex];
			_x set [3, true];
		} forEach _dialog_options;
	};
};
private _dialogResult = [_dialog_title, _dialog_options] call Ares_fnc_ShowChooseDialog;

private _dialogCount = count _dialogResult;
if (_dialogCount == 0) exitWith {};

private _actionName = _dialogResult select (_dialogCount - 6);
private _duration = parseNumber (_dialogResult select (_dialogCount - 5));
private _delete = if ((_dialogResult select (_dialogCount - 4)) == 0) then {true} else {false};;
private _title = _dialogResult select (_dialogCount - 3);
private _text = _dialogResult select (_dialogCount - 2);
// correctly handle newline characters
_text = (_text splitString endl) joinString "<br />";
private _shared = _dialogResult select (_dialogCount - 1);

if (_dialogCount == 7) then
{
	// case spawn intel:
	private _type = INTEL_OBJECTS select (_dialogResult select 0);
	_object = _type createVehicle (position _logic);
	[_object, false] remoteExec ["enableSimulationGlobal", 2];
	_object setPos (position _logic);
	[[_object], true] call Ares_fnc_AddUnitsToCurator;
	
	// save parameters
	_dialogResult deleteAt 0;
	_object setVariable ["Achilles_var_intel",_dialogResult];
} else
{
	// case edit or create intel: save parameters
	_object setVariable ["Achilles_var_intel",_dialogResult];
};

private _marker = createMarker [str _object, _object];

// remove previous action
remoteExec ["", _object];
_object remoteExec ["RemoveAllActions", 0];

private _execute = 
{
	private ["_object","_finder","_arguments","_curator","_title","_text","_marker","_shared","_delete","_target"];
	_object = _this select 0;
	_finder = _this select 1;
	_arguments = _this select 3;
	_curator = _arguments select 0;
	_title = _arguments select 1;
	_text = _arguments select 2;
	_marker = _arguments select 3;
	_shared = _arguments select 4;
	_delete = _arguments select 5;
	
	_target = switch (_shared) do {case 0: {side _finder}; case 1: {group _finder}; case 2: {_finder};};
	
	[_title,_text,_marker,name _finder,_shared] remoteExec ["Ares_fnc_addIntel",_target];
	["intelAdded",[format [localize "STR_INTEL_FOUND",name _finder,_title] ,"\A3\ui_f\data\map\markers\military\warning_ca.paa"]] remoteExec ["BIS_fnc_showNotification",_curator];
	if (_delete) then {deleteVehicle _object} else {remoteExec ["", _object]; _object remoteExec ["RemoveAllActions", 0];};
};

[
	_object,			// Object the action is attached to
	_actionName,		// Title of the action
	SEARCH_ICON,			// Idle icon shown on screen
	SEARCH_ICON,			// Progress icon shown on screen
	"_this distance _target < 3",	// Condition for the action to be shown
	"_caller distance _target < 3",	// Condition for the action to progress
	{},			// Code executed when action starts
	{},			// Code executed on every progress tick
	_execute,	// Code executed on completion
	{},			// Code executed on interrupted
	[player,_title,_text,_marker,_shared,_delete],			// Arguments passed to the scripts
	_duration,	// Action duration
	20,			// Priority
	false,		// Remove on completion
	false		// Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",0,_object];

#include "\achilles\modules_f_ares\module_footer.hpp"
