/*
* Author: CreepPork, mharis001
* Set up function for the text control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <STRING>
* 3: Row Settings <ARRAY>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, "My text"] call achilles_dialog_fnc_dynamic_edit
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", "", [""]],
    ["_rowSettings", [], [[]]]
];

_rowSettings params ["_fnc_sanitizeInput"];

private _ctrlEdit = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TEXT;
_ctrlEdit ctrlSetText _currentValue;

_ctrlEdit setVariable [QGVAR(params), [_rowIndex, _fnc_sanitizeInput]];

_ctrlEdit ctrlAddEventHandler ["KeyDown", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["", "_fnc_sanitizeInput"];

    private _value = ctrlText _ctrlEdit;
    _value = _value call _fnc_sanitizeInput;
    _ctrlEdit ctrlSetText _value;
}];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_rowIndex", "_fnc_sanitizeInput"];

    private _value = ctrlText _ctrlEdit;
    _value = _value call _fnc_sanitizeInput;
    _ctrlEdit ctrlSetText _value;

    private _display = ctrlParent _ctrlEdit;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];
