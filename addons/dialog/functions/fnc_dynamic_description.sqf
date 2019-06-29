/*
* Author: CreepPork
* Set up function for the description control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Current Value <STRING>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0, "This is a long description of my dialog."] call achilles_dialog_fnc_dynamic_description
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_currentValue", "", [""]]
];

private _ctrlEdit = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_DESCRIPTION;
_ctrlEdit ctrlSetText _currentValue;
