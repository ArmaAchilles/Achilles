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

_object = param [0, objNull, [objNull]];
_position = getPosWorld _object;
_object enableSimulationGlobal false;
_object setPos [0,0,0];

_logic = (createGroup sideLogic) createUnit ["Achilles_Helpers_Position", [0,0,0], [], 0, "NONE"];
_logic setPosWorld _position;
[[_logic], true] call Ares_fnc_AddUnitsToCurator;

disableSerialization;
_display = finddisplay IDD_RSCDISPLAYCURATOR;
_ctrlMessage = _display displayctrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;

Achilles_var_submit_selection = nil;

// Inform curator what he has to do
playSound "FD_Finish_F";
//[["Ares","SelectionOption"]] call BIS_fnc_advHint;

_ctrlMessage ctrlsettext (localize "STR_SELECT_X_APPLIED_TO_MODULE");
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
	{deleteVehicle _x} forEach crew _object;
	deleteVehicle _object;
	nil
};

// if enter was pressed
[localize "STR_SELECTION_SUBMITTED"] call Ares_fnc_ShowZeusMessage;

_position = getPosWorld _logic;
deleteVehicle _logic;
_object setPosWorld _position;
_object enableSimulationGlobal true;
_position;
