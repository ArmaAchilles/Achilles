////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/23/16
//	VERSION: 1.0
//	FILE: Ares\Spawn\fn_SpawnCreateEditIntel.sqf
//  DESCRIPTION: Function that creates an intel
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

#define INTEL_OBJECTS 		["Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Map_unfolded_F","Land_Laptop_unfolded_F","Land_MobilePhone_smart_F","Land_Tablet_01_F","Land_Tablet_02_F"]
#define SEARCH_ICON			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"

_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_dialog_title = localize "STR_SPAWN_INTEL";
_dialog_options =
[
	[localize "STR_ACTION_TEXT","",localize "STR_PICK_UP_INTEL"],
	[localize "STR_ACTION_DURATION","","1"],
	[localize "STR_DELETE_OBJECT_ON_COMPLETION",[localize "STR_TRUE",localize "STR_FALSE"]],
	[localize "STR_INTEL_TITLE",""],
	[localize "STR_INTEL_TEXT", ""],
	[localize "STR_INTEL_SHARED_WITH", [localize "STR_SIDE", localize "STR_GROUP", localize "STR_NO_ONE"]]
];

if (isNull _object) then
{
	_dialog_title = localize "STR_CREATE_EDIT_INTEL";
	_dialog_options = [[localize "STR_OBJECT",[{getText (configfile >> "CfgVehicles" >> _this >> "displayName")}, INTEL_OBJECTS] call Achilles_fnc_map]] + _dialog_options;
};
Achilles_var_currentIntel = _object;
_dialogResult = [_dialog_title, _dialog_options,"Achilles_fnc_RscDisplayAtttributes_SpawnIntel"] call Ares_fnc_ShowChooseDialog;

_dialogCount = count _dialogResult;
if (_dialogCount == 0) exitWith {};

_actionName = _dialogResult select (_dialogCount - 6);
_duration = parseNumber (_dialogResult select (_dialogCount - 5));
_delete = if ((_dialogResult select (_dialogCount - 4)) == 0) then {true} else {false};;
_title = _dialogResult select (_dialogCount - 3);
_text = _dialogResult select (_dialogCount - 2);
_shared = _dialogResult select (_dialogCount - 1);

if (_dialogCount == 7) then
{
	_type = INTEL_OBJECTS select (_dialogResult select 0);
	_object = _type createVehicle (position _logic);
	_object setPos (position _logic);
	[[_object], true] call Ares_fnc_AddUnitsToCurator;
	
	// save parameters
	_dialogResult deleteAt 0;
	_object setVariable ["Achilles_var_intel",_dialogResult];
} else
{
	// save parameters
	_object setVariable ["Achilles_var_intel",_dialogResult];
};

_marker = createMarker [str _object, _object];

// remove previous action
remoteExec ["", _object];
_object remoteExec ["RemoveAllActions", 0];

_execute = 
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
	["TaskSucceeded",["",format [localize "STR_INTEL_FOUND",name _finder,_title]]] remoteExec ["BIS_fnc_showNotification",_curator];
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
	0,			// Priority
	false,		// Remove on completion
	false		// Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",0,_object];

#include "\achilles\modules_f_ares\module_footer.hpp"
