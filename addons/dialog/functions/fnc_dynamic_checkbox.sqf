/*
* Author: CreepPork, mharis001
* Set up function for the checkbox control from the dynamic dialog.
*
* Arguments:
* 0: Controls Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Is checked? <BOOL>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, true] call achilles_dialog_fnc_dynamic_checkbox
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_isChecked", false, [false]]
];

private _ctrlCheckbox = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_CHECKBOX;
_ctrlCheckbox cbSetChecked _isChecked;

_ctrlCheckbox setVariable [QGVAR(params), [_rowIndex]];

_ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlCheckbox", "_state"];
    (_ctrlCheckbox getVariable QGVAR(params)) params ["_rowIndex"];

    private _display = ctrlParent _ctrlCheckbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _state == 1];
}];
