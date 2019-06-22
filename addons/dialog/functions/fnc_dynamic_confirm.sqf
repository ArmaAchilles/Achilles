/*
* Author: CreepPork, mharis001
* Event fired function which is executed when the dynamic dialog OK button is pressed.
*
* Arguments:
* 0: Button <CONTROL>
*
* Return Value:
* Nothing
*
* Example:
* [_myButton] call achilles_dialog_fnc_dynamic_confirm
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrl", controlNull, [controlNull]]
];

private _display = ctrlParent _ctrl;
private _values = _display getVariable QGVAR(values);
(_display getVariable QGVAR(params)) params ["_onConfirm", "", "_arguments", "_saveId"];

{
    private _valueId = [_saveId, _forEachIndex] joinString "#";
    GVAR(saved) setVariable [_valueId, _x];
} forEach _values;

[_values, _arguments] call _onConfirm;

closeDialog 0;
