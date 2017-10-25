////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_SelectObjects.sqf
//  DESCRIPTION: Let the curator select units and submit the selection
//
//	ARGUMENTS:
//	_this select 0:		STRING	- (Default: localize "STR_OBJECTS") Tells what has to be selected
//	_this select 1:		BOOL	- (Default: false) If true only one object is returned. Otherwise the array of all groups / objects is returned.
//
//	RETURNS:
//	_this:				OBJECT or GROUP or ARRAY of objects or groups or NIL if the selection was cancled
//
//	Example:
//	_selected_units_array = ["units"] call Achilles_fnc_SelectUnits;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params[["_type", localize "STR_OBJECTS"], ["_single", false]];

disableSerialization;
private _display = finddisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMessage = _display displayctrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;

Achilles_var_submit_selection = nil;

// Inform curator what he has to do
playSound "FD_Finish_F";
[["Ares","SelectionOption"],15,"not isNil ""Achilles_var_submit_selection""",35,"not isNil ""Achilles_var_submit_selection""",true,true] call BIS_fnc_advHint;

_ctrlMessage ctrlsettext toupper (format [localize "STR_SELECT_X_APPLIED_TO_MODULE",_type]);
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0;
_ctrlMessage ctrlsetfade 0;
_ctrlMessage ctrlcommit 0.1;

// Add key event handler
private _handler_id = _display displayAddEventHandler ["KeyDown", 
{
	private _key = _this select 1;
	if (_key == 28) then {Achilles_var_submit_selection = true; true} else {false};
	if (_key == 1) then {Achilles_var_submit_selection = false; true} else {false};
}];

// executed when the choice is submitted or cancled
WaitUntil {!isNil "Achilles_var_submit_selection" or {isNull findDisplay 312}};

// remove the key handler and the message
_display displayRemoveEventHandler ["KeyDown", _handler_id];
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0.5;

// if escape was pressed
if (!isNil "Achilles_var_submit_selection" && {!Achilles_var_submit_selection}) exitWith {[localize "STR_SELECTION_CANCLED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

// if enter was pressed
[localize "STR_SELECTION_SUBMITTED"] call Ares_fnc_ShowZeusMessage;

private _output = [];

if (_single) then 
{
	if (count (curatorSelected select 0) > 0) then
	{
		_output = (curatorSelected select 0) select 0;
	}
	else
	{
		_output = ObjNull;
	};
}
else
{
	_output = curatorSelected select 0;
};

_output;