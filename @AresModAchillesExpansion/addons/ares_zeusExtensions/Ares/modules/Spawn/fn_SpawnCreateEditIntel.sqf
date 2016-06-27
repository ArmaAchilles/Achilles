////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/23/16
//	VERSION: 1.0
//	FILE: Ares\Spawn\fn_SpawnCreateEditIntel.sqf
//  DESCRIPTION: Function that creates an intel
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\ares_zeusExtensions\Ares\module_header.hpp"
#define INTEL_OBJECTS ["Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Map_unfolded_F","Land_Laptop_unfolded_F","Land_MobilePhone_smart_F","Land_Tablet_01_F","Land_Tablet_02_F"]

_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_dialog_options = 	
[
	[localize "STR_SHARED_WITH", [localize "STR_SIDE", localize "STR_GROUP", localize "STR_NO_ONE"]],
	[localize "STR_TITLE",	""],
	[(localize "STR_TEXT"), ""]
];

if (isNull _object) then
{
	_dialog_options = [[localize "STR_OBJECT",[{getText (configfile >> "CfgVehicles" >> _this >> "displayName")}, INTEL_OBJECTS] call Achilles_fnc_map]] + _dialog_options;
};

_dialogResult = [localize "STR_CREATE_EDIT_INTEL", _dialog_options] call Ares_fnc_ShowChooseDialog;

_dialogCount = count _dialogResult;
if (_dialogCount == 0) exitWith {};

_title = _dialogResult select (_dialogCount - 2);
_text = _dialogResult select (_dialogCount - 1);

if (_dialogCount == 4) then
{
	_type = INTEL_OBJECTS select (_dialogResult select 0);
	_object = _type createVehicle (position _logic);
	[[_object], true] call Ares_fnc_AddUnitsToCurator;
};
_marker = createMarker [str _object, _object];

_shared = _dialogResult select (_dialogCount - 3);

_execute = 
{
	_object = _this select 0;
	_finder = _this select 1;
	_arguments = _this select 3;
	_curator = _arguments select 0;
	_title = _arguments select 1;
	_text = _arguments select 2;
	_marker = _arguments select 3;
	_shared = _arguments select 4;
	
	_target = switch (_shared) do {case 0: {side _finder}; case 1: {group _finder}; case 2: {_finder};};
	
	[_title,_text,_marker,name _finder,_shared] remoteExec ["Ares_fnc_addIntel",_target];
	["TaskSucceeded",["",format [localize "STR_INTEL_FOUND",name _finder,_title]]] remoteExec ["BIS_fnc_showNotification",_curator];
	deleteVehicle _object;
};

_object remoteExec ["RemoveAllActions", 0];
[_object,[localize "STR_PICK_UP_INTEL", _execute,[player, _title,_text,_marker,_shared]]] remoteExec ["addAction", 0, netId _object];

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
