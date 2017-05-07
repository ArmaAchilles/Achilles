////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 18/2/17
//	VERSION: 1.0
//  DESCRIPTION: Define position for object in advance
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Object that shall be placed
//
//	RETURNS:
//	_this:				ARRAY	- New world position coordinates
//						NIL		- If mode was cancled
//
//	Example:
//	_position = [_object] call Achilles_fnc_PreplaceMode;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_center_object", "_objects_list","_pos"];
_entity = param [0, objNull, [objNull, grpNull]];
if (isNull _entity) exitWith {};

if (typeName _entity == typeName grpNull) then 
{
	_center_object = leader _entity;
	_objects_list = units _entity;
} else 
{
	_center_object = _entity;
	_objects_list = [_entity];
};

private _center_pos = position _center_object;
private _pos_list = [];
{
	_pos = (position _x) vectorDiff _center_pos;
	_pos_list pushBack _pos;
	_x enableSimulation false;
	_x setPos [0,0,0];
} forEach _objects_list;

private _logic_group = createGroup sideLogic;
private _logic = _logic_group createUnit ["Module_f", _center_pos, [], 0, "CAN_COLLIDE"];
[[_logic], true] call Ares_fnc_AddUnitsToCurator;

disableSerialization;
private _display = finddisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMessage = _display displayctrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;

Achilles_var_submit_selection = nil;

// Inform curator what he has to do
playSound "FD_Finish_F";
//[["Ares","SelectionOption"]] call BIS_fnc_advHint;

_ctrlMessage ctrlsettext (localize "STR_MOVE_SPAWN_POSITION_AND_PRESS_ENTER");
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0;
_ctrlMessage ctrlsetfade 0;
_ctrlMessage ctrlcommit 0.1;

// Add key event handler
_handler_id = _display displayAddEventHandler ["KeyDown", 
{
	_key = _this select 1;
	if (_key == 28) then {Achilles_var_submit_selection = true; true} else {false};
	if (_key == 1) then {Achilles_var_submit_selection = false; true} else {false};
}];

// executed when the choice is submitted or cancled
WaitUntil {!isNil "Achilles_var_submit_selection"};

// remove the key handler and the message
_display displayRemoveEventHandler ["KeyDown", _handler_id];
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0.5;

// if escape was pressed
if (! Achilles_var_submit_selection) exitWith 
{
	[localize "STR_SELECTION_CANCLED"] call Ares_fnc_ShowZeusMessage; 
	playSound "FD_Start_F";
	deleteVehicle _logic;
	deleteGroup _logic_group;
	{
		{deleteVehicle _x} forEach (crew _x);
		deleteVehicle _x;
	} forEach _objects_list;
	nil
};

// if enter was pressed
[localize "STR_SELECTION_SUBMITTED"] call Ares_fnc_ShowZeusMessage;

_center_pos = position _logic;
{
	_x setPos ((_pos_list select _forEachIndex) vectorAdd _center_pos);
	_x enableSimulation true;
} forEach _objects_list;
deleteVehicle _logic;
deleteGroup _logic_group;
_center_pos;
