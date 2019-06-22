/*
* Author: CreepPork, mharis001
* Event fired function which is executed when the dynamic dialog Cancel button is pressed.
*
* Arguments:
* 0: Button <CONTROL>
*
* Return Value:
* Nothing
*
* Example:
* [_myButton] call achilles_dialog_fnc_dynamic_cancel
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrl", controlNull, [controlNull]]
];

private _display = ctrlParent _ctrl;
private _values = _display getVariable QGVAR(values);
(_display getVariable QGVAR(params)) params ["", "_onCancel", "_arguments"];

[_values, _arguments] call _onCancel;

closeDialog 0;
