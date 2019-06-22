/*
* Author: CreepPork, mharis001
* Sets up the color control (RGB and RGBA).
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <ARRAY>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, [1, 0, 0, 1]] call achilles_dialog_fnc_dynamic_color
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", [0], [[]], [3, 4]]
];

_currentValue params [
    ["_red", 0, [0]],
    ["_green", 0, [0]],
    ["_blue", 0, [0]],
    ["_alpha", 1, [0]]
];

private _color = [_red, _green, _blue, _alpha];

for "_i" from 0 to (count _currentValue - 1) do {
    private _ctrlColor = _ctrlGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_COLOR select _i);

    _ctrlColor sliderSetRange [0, 1];
    _ctrlColor sliderSetPosition (_currentValue param [_i, 1]);
    _ctrlColor sliderSetSpeed [0.05, 0.1];

    _ctrlColor setVariable [QGVAR(params), [_rowIndex, _currentValue, _color, _i]];

    _ctrlColor ctrlAddEventHandler ["SliderPosChanged", {
        params ["_ctrlColor", "_value"];
        (_ctrlColor getVariable QGVAR(params)) params ["_rowIndex", "_currentValue", "_color", "_index"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColor;
        private _ctrlColorEdit = _controlsGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_COLOR_EDIT select _index);
        _ctrlColorEdit ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);

        _currentValue set [_index, _value];
        _color set [_index, _value];

        private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_ACHILLES_ROW_COLOR_PREVIEW;
        _ctrlColorPreview ctrlSetBackgroundColor _color;

        private _display = ctrlParent _ctrlColor;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _currentValue];
    }];

    private _ctrlColorEdit = _ctrlGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_COLOR_EDIT select _i);
    _ctrlColorEdit ctrlSetText ([_currentValue param [_i, 1], 1, 2] call CBA_fnc_formatNumber);
    _ctrlColorEdit setVariable [QGVAR(params), [_rowIndex, _currentValue, _color, _i]];

    _ctrlColorEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrlColorEdit"];
        (_ctrlColorEdit getVariable QGVAR(params)) params ["_rowIndex", "_currentValue", "_color", "_index"];

        private _value = parseNumber ctrlText _ctrlColorEdit;

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_COLOR select _index);

        _ctrlColor sliderSetPosition _value;
        _value = sliderPosition _ctrlColor;

        _currentValue set [_index, _value];
        _color set [_index, _value];

        private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_ACHILLES_ROW_COLOR_PREVIEW;
        _ctrlColorPreview ctrlSetBackgroundColor _color;

        private _display = ctrlParent _ctrlColorEdit;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _currentValue];
    }];

    _ctrlColorEdit ctrlAddEventHandler ["KillFocus", {
        params ["_ctrlColorEdit"];
        (_ctrlColorEdit getVariable QGVAR(params)) params ["", "_currentValue", "_color", "_index"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_COLOR select _index);

        private _value = sliderPosition _ctrlColor;

        _currentValue set [_index, _value];
        _color set [_index, _value];

        _ctrlColorEdit ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);
    }];
};

private _ctrlColorPreview = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_COLOR_PREVIEW;
_ctrlColorPreview ctrlSetBackgroundColor _color;
