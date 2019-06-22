/*
* Author: CreepPork, mharis001
* Set up function for the block control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <SCALAR|BOOL>
* 3: Row Settings <ARRAY>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, true, ["No", "Yes", true]] call achilles_dialog_fnc_dynamic_block
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", 0, [false, 0]],
    ["_rowSettings", [], [[]]]
];

_rowSettings params ["_values", "_returnBool"];

private _ctrlToolbox = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_BLOCK;

// Currently the only way to add options to toolbox controls through script
// Unfortunately also sets the name as the tooltip
{
    _ctrlToolbox lbAdd _x;
} forEach _values;

// Need number to set current index
if (_returnBool) then {
    _currentValue = parseNumber _currentValue;
};

_ctrlToolbox lbSetCurSel _currentValue;

_ctrlToolbox setVariable [QGVAR(params), [_rowIndex, _returnBool]];
_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_value"];
    (_ctrlToolbox getVariable QGVAR(params)) params ["_rowIndex", "_returnBool"];

    if (_returnBool) then {
        _value = _value > 0;
    };

    private _display = ctrlParent _ctrlToolbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];
