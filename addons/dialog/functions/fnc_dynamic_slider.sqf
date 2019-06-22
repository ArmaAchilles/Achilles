/*
* Author: CreepPork, mharis001
* Set up function for the slider control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <SCALAR>
* 3: Row Settings <ARRAY>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, 5, [0, 10, 1]] call achilles_dialog_fnc_dynamic_slider
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", 0, [0]],
    ["_rowSettings", [0, 1, 2], [[]], 3]
];

_rowSettings params ["_min", "_max", "_decimals"];

private _ctrlSlider = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_SLIDER;

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _currentValue;

private _range = _max - _min;
_ctrlSlider sliderSetSpeed [0.05 * _range, 0.1 * _range];

_ctrlSlider setVariable [QGVAR(params), [_rowIndex, _decimals]];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_rowIndex", "_decimals"];

    if (_decimals < 0) then {
        _value = round _value;
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    private _ctrlEdit = _controlsGroup controlsGroupCtrl IDC_ACHILLES_ROW_SLIDER_EDIT;
    _ctrlEdit ctrlSetText ([_value, 1, _decimals max 0] call CBA_fnc_formatNumber);

    private _display = ctrlParent _ctrlSlider;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];

private _ctrlEdit = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_SLIDER_EDIT;
_ctrlEdit ctrlSetText ([_currentValue, 1, _decimals max 0] call CBA_fnc_formatNumber);
_ctrlEdit setVariable [QGVAR(params), [_rowIndex, _decimals]];

_ctrlEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["_rowIndex", "_decimals"];

    private _value = parseNumber ctrlText _ctrlEdit;

    if (_decimals < 0) then {
        _value = round _value;
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ACHILLES_ROW_SLIDER;

    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    private _display = ctrlParent _ctrlEdit;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];

_ctrlEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlEdit"];
    (_ctrlEdit getVariable QGVAR(params)) params ["", "_decimals"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_ACHILLES_ROW_SLIDER;

    private _value = sliderPosition _ctrlSlider;

    if (_decimals < 0) then {
        _value = round _value;
    };

    _ctrlEdit ctrlSetText ([_value, 1, _decimals max 0] call CBA_fnc_formatNumber);
}];
