////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/11/17
//	VERSION: 3.0
//  DESCRIPTION: Define position for object in advance. If suspension is allowed, this script will wait till completion
//
//	ARGUMENTS:
//	_this select 0:		OBJECT / GROUP	- Object or group to be placed
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_object] call Achilles_fnc_PreplaceMode;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private "_objects_list";
private _entity = param [0, objNull, [objNull, grpNull]];
if (isNull _entity) exitWith {};

// exit with previous called preplace mode was not yet completed
if (count (missionNamespace getVariable ["Achilles_var_preplaceModeObjects",[]]) > 0) exitWith {};

_objects_list = [[_entity], units _entity] select (_entity isEqualType grpNull);
missionNamespace setVariable ["Achilles_var_preplaceModeObjects", _objects_list];

private _scriptHandle = [_objects_list] spawn
{
	params ["_objects_list"];
	{
		_x enableSimulation false;
		if (isNull objectParent _x) then
		{
			private _pos = position _x;
			_pos set [2,0];
			if (surfaceIsWater _pos) then {_x setPosASL _pos} else {_x setPosATL _pos};
			_x setVectorUp [0,0,1];
		} else
		{
			_objects_list pushBackUnique (vehicle _x);
		};
	} forEach _objects_list;

	disableSerialization;
	private _display = finddisplay IDD_RSCDISPLAYCURATOR;
	private _ctrlMessage = _display displayctrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;

	Achilles_var_submit_selection = nil;

	// Inform curator what he has to do
	playSound "FD_Finish_F";
	//[["Ares","SelectionOption"]] call BIS_fnc_advHint;

	_ctrlMessage ctrlsettext (localize "STR_AMAE_MOVE_SPAWN_POSITION_AND_PRESS_ENTER");
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
	WaitUntil {!isNil "Achilles_var_submit_selection" || {isNull findDisplay 312} || {{!isNull _x} count _objects_list == 0}};

	// remove the key handler and the message
	_display displayRemoveEventHandler ["KeyDown", _handler_id];
	_ctrlMessage ctrlsetfade 1;
	_ctrlMessage ctrlcommit 0.5;

	// if objects were deleted
	if ({!isNull _x} count _objects_list == 0) exitWith
	{
		[localize "STR_AMAE_SELECTION_CANCLLED"] call Achilles_fnc_ShowZeusErrorMessage;
		missionNamespace setVariable ["Achilles_var_preplaceModeObjects", []];
	};

	// if escape was pressed
	if (!isNil "Achilles_var_submit_selection" && {!Achilles_var_submit_selection}) exitWith
	{
		[localize "STR_AMAE_SELECTION_CANCLLED"] call Achilles_fnc_ShowZeusErrorMessage;
		{
			{deleteVehicle _x} forEach (crew _x);
			deleteVehicle _x;
		} forEach _objects_list;
		missionNamespace setVariable ["Achilles_var_preplaceModeObjects", []];
	};

	// if enter was pressed
	[localize "STR_AMAE_SELECTION_SUBMITTED"] call Ares_fnc_ShowZeusMessage;

	{
		{_x enableSimulation true} forEach (crew _x);
		_x enableSimulation true;
	} forEach _objects_list;
	missionNamespace setVariable ["Achilles_var_preplaceModeObjects", []];
};

// if we can suspend wait till completion
if (canSuspend) then
{
	waitUntil {sleep 0.1; scriptDone _scriptHandle};
};
