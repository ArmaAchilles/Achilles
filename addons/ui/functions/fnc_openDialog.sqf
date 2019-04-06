#include "script_component.hpp"
/*
    To Do:
        - Rename dialog macros
        - Think about how FUNC(initializeDialogControl) gets the previous choice
        - Get the correct values for adjusting the dialog bottom/background/ctrl group
        - Fix the spacing between controls
*/

params [
    ["_title", "", [""]],
    ["_variableSpace", missionNamespace, [objNull, missionNamespace, displayNull, controlNull]],
    ["_controls", [], [[]]],
    ["_targetEventNames", , [], [[]], 2]
];

createDialog "Achilles_dialog";
private _dialog = findDisplay DYNAMIC_GUI_IDD;

// Set the dialog title
if !(_title isEqualTo "") then
{
	private _ctrlTitle = _dialog displayCtrl DYNAMIC_TITLE_IDC;
	_ctrlTitle ctrlSetText _title;
};

// Add controls
private _yCoord = 0;
{
    _yCoord = [_x, _dialog, _yCoord] call FUNC(initializeDialogControl);
} forEach _controls;

// Adjust the ctrl group
private _ctrlGroup = _dialog displayCtrl DYNAMIC_CTRL_GROUP;
private _pos = ctrlPosition _ctrlGroup;
_pos set [3, _yCoord];
_ctrlGroup ctrlSetPosition _pos;
_ctrlGroup ctrlCommit 0;

// Adjust the dialog bottom
{
	private _bottomCtrl = _dialog displayCtrl _x;
	_pos = ctrlPosition _bottomCtrl;
	_pos set [1, _yCoord];
	_bottomCtrl ctrlSetPosition _pos;
	_bottomCtrl ctrlCommit 0;
} forEach DYNAMIC_BOTTOM_IDCs;

// Adjust the dialog background
private _background = _dialog displayCtrl DYNAMIC_BG_IDC;
_pos = ctrlPosition _background;
_pos set [3, _yCoord - (_pos select 1)];
_background ctrlSetPosition _pos;
_background ctrlCommit 0;
