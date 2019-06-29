/*
* Author: CreepPork, mharis001
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

// Create saved values namespace
if (isNil QGVAR(saved)) then {
    GVAR(saved) = [] call CBA_fnc_createNamespace;
};

private _saveId = [QGVAR(value), _title, _content, _onConfirm, _onCancel] joinString "#";
private _values = [];

// If no control found then this allows it to complete the dialog
scopeName "Main";

// Process each given control
{
    _x params [
        ["_controlType", "", [""]],
        ["_name", "", ["", [""]]],
        ["_valueData", []],
        ["_forceDefault", false, [false]],
        ["_fnc_resourceFunction", {}, [{}]]
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

    // If secondary control type is given then split it into two strings, e.g. BLOCK:YESNO
    (toUpper _controlType splitString ":") params [
        ["_primaryControl", "", [""]],
        ["_secondaryControl", "", [""]]
    ];

    private "_defaultValue";
    private _dialogControl = "";
    private _rowSettings = [];
    private _setValue = true;

    switch (_primaryControl) do {
        case "CHECKBOX": {
            _defaultValue = _valueData param [0, false, [false]];
            _dialogControl = QGVAR(row_checkbox);
        };
        case "COLOR": {
            _defaultValue = [_valueData] param [0, [1, 1, 1], [[]], [3, 4]];
            _dialogControl = [QGVAR(row_colorRGB), QGVAR(row_colorRGBA)] select (count _defaultValue > 3);
        };
        case "SELECT": {
            _valueData params [
                ["_values", [], [[]]],
                ["_labels", [], [[]]],
                ["_defaultIndex", 0, [0]]
            ];

            if (_values isEqualTo []) then {
                {
                    _values pushBack _forEachIndex;
                } forEach _labels;
            };

            {
                if (isNil "_x") then {
                    _x = _values select _forEachIndex;
                };

                _x params ["_label", ["_tooltip", ""], ["_picture", "", [""]], ["_textColor", [1, 1, 1, 1], [[]], 4]];

                if !(_label isEqualType "") then {
                    _label = str _label;
                };

                if !(_tooltip isEqualType "") then {
                    _tooltip = str _tooltip;
                };

                if (isLocalized _label) then {
                    _label = localize _label;
                };

                if (isLocalized _tooltip) then {
                    _tooltip = localize _tooltip;
                };

                _labels set [_forEachIndex, [_label, _tooltip, _picture, _textColor]];
            } forEach _labels;

            _rowSettings append [_values, _labels];
            _defaultValue = _values param [_defaultIndex];
            _dialogControl = QGVAR(row_select);
        };
        case "TEXT": {
            _valueData params [
                ["_default", "", [""]],
                ["_fnc_sanitizeInput", {_this}, [{}]]
            ];

            _rowSettings append [_fnc_sanitizeInput];
            _defaultValue = _default;
            _dialogControl = QGVAR(row_text);
        };
        case "SIDES": {
            _defaultValue = _valueData param [0, nil, [west]];

            if (_secondaryControl == "ALL") then {
                _dialogControl = QGVAR(row_sides_all);
                _rowSettings append [true];
            } else {
                _dialogControl = QGVAR(row_sides);
            };
        };
        case "SLIDER": {
            _valueData params [
                ["_min", 0, [0]],
                ["_max", 1, [0]],
                ["_default", 0, [0]],
                ["_decimals", 2, [0]]
            ];
            _rowSettings append [_min, _max, _decimals];
            _defaultValue = _default;
            _dialogControl = QGVAR(row_slider);
        };
        case "BLOCK": {
            _valueData params [
                ["_default", 0, [0, false]],
                ["_values", [], [[]]]
            ];

            switch (_secondaryControl) do {
                case "YESNO": {
                    _values = [ELSTRING(common,no), ELSTRING(common,yes)];
                };
                case "ENABLED": {
                    _values = [ELSTRING(common,disabled), ELSTRING(common,enabled)];
                };
            };

            _values = _values apply {
                if (isLocalized _x) then {localize _x} else {_x};
            };

            // Return boolean if there are only two options and default is boolean too
            private _valueCount = count _values;
            private _returnBool = _valueCount == 2 && {_default isEqualType false};

            // Ensure default is number if not returning boolean
            if (! _returnBool && {_default isEqualType false}) then {
                _default = parseNumber _default;
            };

            _rowSettings append [_values, _returnBool];
            _defaultValue = _default;
            _dialogControl = format [QGVAR(row_block%1), _valueCount]
        };
        case "VECTOR": {
            _defaultValue = [_valueData] param [0, [0, 0], [], [2, 3]];
            _dialogControl = [QGVAR(row_vectorXY), QGVAR(row_vectorXYZ)] select (count _defaultValue > 2);
        };
        case "DESCRIPTION": {
            _defaultValue = [_valueData] param [0, "", [""]];
            _dialogControl = QGVAR(row_description);
            _forceDefault = true;
            _setValue = false;
        };
        default {
            WARNING_1("%1 is not a valid control type",_primaryControl);
            false breakOut "Main";
        };
    };

    if (! _forceDefault) then {
        private _valueId = [_saveId, _forEachIndex] joinString "#";
        _defaultValue = GVAR(saved) getVariable [_valueId, _defaultValue];
    };

    if (_setValue) then {
        _values set [_forEachIndex, _defaultValue];
    };

    _content set [_forEachIndex, [_dialogControl, _displayName, _tooltip, _defaultValue, _rowSettings, _fnc_resourceFunction]];
} forEach _content;

// In case the dialog didn't get created, log error
if (! createDialog QGVAR(display)) exitWith {
    ERROR("Unable to create dialog");
    false;
};

// Get display
private _display = uiNamespace getVariable QGVAR(display);
_display setVariable [QGVAR(values), _values];
_display setVariable [QGVAR(params), [_onConfirm, _onCancel, _arguments, _saveId]];

// Set dialog title
private _ctrlTitle = _display displayCtrl IDC_ACHILLES_TITLE;

if (isLocalized _title) then {
    _title = localize _title;
};

_ctrlTitle ctrlSetText toUpper _title;

// Set up _content controls
private _ctrlContent = _display displayCtrl IDC_ACHILLES_CONTENT;
private _contentPosY = 0;

{
    _x params ["_controlType", "_displayName", "_tooltip", "_defaultValue", "_rowSettings", "_fnc_resourceFunction"];

    private _ctrlRowGroup = _display ctrlCreate [_controlType, IDC_ACHILLES_ROW_GROUP, _ctrlContent];

    // Set row text name and tooltip
    private _ctrlRowName = _ctrlRowGroup controlsGroupCtrl IDC_ACHILLES_ROW_NAME;
    _ctrlRowName ctrlSetText _displayName;
    _ctrlRowName ctrlSetTooltip _tooltip;

    // Call GUI scripts for each control
    private _script = getText (configFile >> ctrlClassName _ctrlRowGroup >> QGVAR(script));
    [_ctrlRowGroup, _forEachIndex, _defaultValue, _rowSettings] call (missionNamespace getVariable _script);

    // Call the resource function if provided
    [_ctrlRowGroup, _forEachIndex, _defaultValue, _rowSettings] call _fnc_resourceFunction;

    // Adjust the y axis position for the row
    private _position = ctrlPosition _ctrlRowGroup;
    _position set [1, _contentPosY];

    _ctrlRowGroup ctrlSetPosition _position;
    _ctrlRowGroup ctrlCommit 0;

    _contentPosY = _contentPosY + (_position select 3) + VERTICAL_SPACING;
} forEach _content;

// Update content position
private _contentHeight = MIN_HEIGHT max (_contentPosY - VERTICAL_SPACING) min MAX_HEIGHT;
_ctrlContent ctrlSetPosition [POS_X(7), POS_CONTENT_Y(_contentHeight), POS_W(26), _contentHeight];
_ctrlContent ctrlCommit 0;

// Update title and background position
private _ctrlBackground = _display displayCtrl IDC_ACHILLES_BACKGROUND;
_ctrlBackground ctrlSetPosition [POS_X(6.5), POS_BACKGROUND_Y(_contentHeight), POS_W(27), POS_BACKGROUND_H(_contentHeight)];
_ctrlBackground ctrlCommit 0;

_ctrlTitle ctrlSetPosition [POS_X(6.5), POS_TITLE_Y(_contentHeight)];
_ctrlTitle ctrlCommit 0;

// Update the positions for the buttons and add event handlers
private _ctrlButtonOk = _display displayCtrl IDC_ACHILLES_BTN_OK;
_ctrlButtonOk ctrlAddEventHandler ["ButtonClick", FUNC(dynamic_confirm)];
_ctrlButtonOk ctrlSetPosition [POS_X(28.5), POS_BUTTON_Y(_contentHeight)];
_ctrlButtonOk ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_ACHILLES_BTN_CANCEL;
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", FUNC(dynamic_cancel)];
_ctrlButtonCancel ctrlSetPosition [POS_X(6.5), POS_BUTTON_Y(_contentHeight)];
_ctrlButtonCancel ctrlCommit 0;

// Add event handler to close dialog when Escape is pressed
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key"];

    if (_key isEqualTo DIK_ESCAPE) then {
        private _values = _display getVariable QGVAR(values);
        (_display getVariable (QGVAR(params))) params ["", "_onCancel", "_arguments"];

        [_values, _arguments] call _onCancel;
    };

    false;
}];

true;
