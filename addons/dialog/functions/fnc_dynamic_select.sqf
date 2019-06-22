/*
* Author: CreepPork, mharis001
* Set up function for the select box (combo box).
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <ANY>
* 3: Row Settings <ARRAY>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, 1] call achilles_dialog_fnc_dynamic_select
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    "_currentValue",
    ["_rowSettings", [], [[]]]
];

_rowSettings params ["_values", "_labels"];

private _ctrlCombo = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_SELECT;

{
    _x params ["_label", "_tooltip", "_picture", "_textColor"];

    private _index = _ctrlCombo lbAdd _label;
    _ctrlCombo lbSetTooltip [_index, _tooltip];
    _ctrlCombo lbSetPicture [_index, _picture];
    _ctrlCombo lbSetColor [_index, _textColor];
} forEach _labels;

_ctrlCombo lbSetCurSel (_values find _currentValue);

_ctrlCombo setVariable [QGVAR(params), [_rowIndex, _values]];

_ctrlCombo ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlCombo", "_index"];
    (_ctrlCombo getVariable QGVAR(params)) params ["_rowIndex", "_lbData"];

    private _display = ctrlParent _ctrlCombo;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _lbData select _index];
}];
