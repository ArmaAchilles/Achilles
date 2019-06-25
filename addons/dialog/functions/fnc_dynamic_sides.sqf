/*
* Author: CreepPork, mharis001
* Set up function for the sides control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <SIDE>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, west] call achilles_dialog_fnc_dynamic_sides
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", nil, [west]]
];

{
    private _ctrlSide = _ctrlGroup controlsGroupCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    private _side  = [_forEachIndex] call BIS_fnc_sideType;

    _ctrlSide setVariable [QGVAR(params), [_rowIndex, _side, _color]];
    _ctrlSide ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrlSide"];
        (_ctrlSide getVariable QGVAR(params)) params ["_rowIndex", "_selectedSide"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlSide;

        {
            private _ctrlSide = _controlsGroup controlsGroupCtrl _x;
            (_ctrlSide getVariable QGVAR(params)) params ["", "_side", "_color"];

            private _scale = 1;

            if (_side isEqualTo _selectedSide) then {
                _color set [3, 1];
                _scale = 1.2;
            } else {
                _color set [3, 0.5];
            };

            _ctrlSide ctrlSetTextColor _color;
            [_ctrlSide, _scale, 0.1] call BIS_fnc_ctrlSetScale;
        } forEach IDCS_ACHILLES_ROW_SIDES;

        private _display = ctrlParent _ctrlSide;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _selectedSide];
    }];

    _ctrlSide ctrlSetActiveColor _color;

    if (! isNil "_currentValue" && {_side isEqualTo _currentValue}) then {
        [_ctrlSide, 1.2, 0] call BIS_fnc_ctrlSetScale;
    } else {
        _color set [3, 0.5];
    };

    _ctrlSide ctrlSetTextColor _color;
} forEach IDCS_ACHILLES_ROW_SIDES;
