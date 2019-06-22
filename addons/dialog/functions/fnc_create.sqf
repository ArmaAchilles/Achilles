/*
* Author: CreepPork
* Creats a dynamic dialog with custom controls.
*
* Arguments:
* 0: Title <STRING>
* 1: Controls <ARRAY>
* 2: On Confirm <CODE>
* 3: On Cancel <CODE> (default: {})
* 4: Arguments <ANY> (default: [])
*
* Return Value:
* Dialog created <BOOL>
*
* Example:
* ["My Dialog", [["SLIDER", "Awesomeness", 0.5]], {diag_log _this}] call achilles_dialog_fnc_create
*
* Public: Yes
*/

#include "script_component.hpp"

if (canSuspend) exitWith {
    [FUNC(create), _this] call CBA_fnc_directCall;
};

if (! hasInterface) exitWith {};

params [
    ["_title", "", [""]],
    ["_content", [], [[]]],
    ["_onConfirm", {}, [{}]],
    ["_onCancel", {}, [{}]],
    ["_arguments", []]
];

{
    _x params [
        ["_controlType", "", [""]],
        ["_name", "", ["", [""]]],
        ["_values", []]
    ];

    _name params [
        ["_displayName", "", [""]],
        ["_tooltip", "", [""]]
    ];

    // Localize strings if they can be localized
    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    // If secondary control type is given then split it into two strings, e.g. MYTYPE:YESNO
    (toUpper _controlType splitString ":") params [
        ["_primaryControl", "", [""]],
        ["_secondaryControl", "", [""]]
    ];

    private "_defaultValue";
    private _dialogControl = "";
    private _rowSettings = [];

    switch (_primaryControl) do {
        case "CHECKBOX": {
            _defaultValue = _values param [0, false, [false]];
            _dialogControl = QGVAR(row_checkbox);
        };
        default {
            ERROR_MSG_1("%1 is not a valid control type.",_primaryControl);
        };
    };
} forEach _content;
