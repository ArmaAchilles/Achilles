/*
* Author: CreepPork. mharis001
* Set up function for the vector control.
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
* [_ctrl, 0, [100, 100]] call achilles_dialog_fnc_dynamic_vector
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", [0, 0], [[]], [2, 3]]
];

for "_i" from 0 to (count _currentValue - 1) do {
    private _ctrlEdit = _ctrlGroup controlsGroupCtrl (IDCS_ACHILLES_ROW_VECTOR select _i);
    _ctrlEdit ctrlSetText str (_currentValue param [_i, 0]);

    _ctrlEdit setVariable [QGVAR(params), [_rowIndex, _currentValue, _i]];

    _ctrlEdit ctrlAddEventHandler ["KeyDown", {
        params ["_ctrlEdit"];

        private _value  = ctrlText _ctrlEdit;
        private _filter = toArray ".-0123456789";
        _value = toString (toArray _value select {_x in _filter});

        _ctrlEdit ctrlSetText _value;
    }];

    _ctrlEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrlEdit"];
        (_ctrlEdit getVariable QGVAR(params)) params ["_rowIndex", "_currentValue", "_index"];

        private _value = parseNumber ctrlText _ctrlEdit;
        _currentValue set [_index, _value];

        private _display = ctrlParent _ctrlEdit;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _currentValue];
    }];
};
