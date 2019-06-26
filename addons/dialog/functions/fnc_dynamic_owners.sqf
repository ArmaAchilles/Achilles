/*
* Author: CreepPork
* Set up function for the owners control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Default value <SIDE|GROUP|OBJECT>
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0] call achilles_dialog_fnc_dynamic_owner
*
* Public: No
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_defaultValue", west, [west, grpNull, objNull]]
];

// Init the side select control with default value if present
if (_defaultValue isEqualType west) then {
    [_ctrlGroup, _rowIndex, _defaultValue] call achilles_dialog_fnc_dynamic_sides;
} else {
    [_ctrlGroup, _rowIndex] call achilles_dialog_fnc_dynamic_sides
};

// Init each select to display content
private _groupSelect = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_GROUP_SELECT;
private _playerSelect = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_PLAYER_SELECT;
private _groups = [];
private _players = [];
{
    private _group = group _x;
    private _sideId = [side _group] call BIS_fnc_sideID;

    // If we have an ID that doesn't have an icon defined then we skip it
    if (_sideId < SIDE_ICON_COUNT) then {
        private _sideIcon = SIDE_ICONS select _sideId;

        // Prevent duplication
        if !(_group in _groups) then {
            _groups pushBack _group;

            private _id = _groupSelect lbAdd (groupId _group);
            _groupSelect lbSetPicture [_id, _sideIcon];
        };

        if !(_x in _players) then {
            _players pushBack _x;

            private _id = _playerSelect lbAdd (name _x);
            _playerSelect lbSetPicture [_id, _sideIcon];
        };
    };
} forEach (playableUnits + switchableUnits);

_groupSelect lbSetCurSel 0;
_playerSelect lbSetCurSel 0;

// Select the defaults
if (_defaultValue isEqualType grpNull) then {
    private _groupDefault = _groups find _defaultValue;

    if (_groupDefault != -1) then {
        _groupSelect lbSetCurSel _groupDefault;
    } else {
        _groupSelect lbSetCurSel 0;
    };
};

if (_defaultValue isEqualType objNull) then {
    private _playerDefault = _players find _defaultValue;

    if (_playerDefault != -1) then {
        _playerSelect lbSetCurSel _playerDefault;
    } else {
        _playerSelect lbSetCurSel 0;
    };
};


// Add event handlers to handle value saving on dropdown change
{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;

    _ctrl ctrlAddEventHandler ["LBSelChanged", {
        params ["_ctrl", "_index"];

        private _display = ctrlParent _ctrl;
        private _values = _display getVariable QGVAR(values);

        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _params = _ctrlGroup getVariable [QGVAR(params), []];
        _params params ["_rowIndex", "_players", "_groups", "_disabledCtrl", "_previouslyActiveCtrls"];

        if (ctrlIDC _ctrl == IDC_ACHILLES_ROW_TAB_GROUP_SELECT) then {
            _values set [_rowIndex, _groups select _index];
        } else {
            _values set [_rowIndex, _players select _index];
        };
    }];
} forEach IDCS_ACHILLES_ROW_TAB_SELECTS;

private _activeCtrl = controlNull;
private _activeCtrls = [];

// Disable sides tab as it is selected by default
if (_defaultValue isEqualType west) then {
    private _sideTab = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_SIDE;
    _sideTab ctrlEnable false;

    _activeCtrl = _sideTab;
    _activeCtrls = IDCS_ACHILLES_ROW_SIDES;

    // Hide all the combo boxes as they would overlap with the side control on first load
    {
        private _ctrl = _ctrlGroup controlsGroupCtrl _x;
        _ctrl ctrlShow false;
    } forEach IDCS_ACHILLES_ROW_TAB_SELECTS;
} else {
    if (_defaultValue isEqualType grpNull) then {
        private _groupTab = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_GROUP;
        _groupTab ctrlEnable false;

        _activeCtrl = _groupTab;
        _activeCtrls = [IDC_ACHILLES_ROW_TAB_GROUP_SELECT];

        {
            private _ctrl = _ctrlGroup controlsGroupCtrl _x;
            _ctrl ctrlShow false;
        } forEach (IDCS_ACHILLES_ROW_SIDES + [IDC_ACHILLES_ROW_TAB_PLAYER_SELECT]);
    } else {
        private _playerTab = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_PLAYER;
        _playerTab ctrlEnable false;

        _activeCtrl = _playerTab;
        _activeCtrls = [IDC_ACHILLES_ROW_TAB_PLAYER_SELECT];

        {
            private _ctrl = _ctrlGroup controlsGroupCtrl _x;
            _ctrl ctrlShow false;
        } forEach (IDCS_ACHILLES_ROW_SIDES + [IDC_ACHILLES_ROW_TAB_GROUP_SELECT]);
    };
};

_ctrlGroup setVariable [QGVAR(params), [_rowIndex, _players, _groups, _activeCtrl, _activeCtrls]];

{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;

    _ctrl ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _params = _ctrlGroup getVariable [QGVAR(params), []];
        _params params ["_rowIndex", "_players", "_groups", "_disabledCtrl", "_previouslyActiveCtrls"];

        // Set the current "active" control to the one that just got pressed
        _disabledCtrl ctrlEnable true;
        _ctrl ctrlEnable false;

        // Hide previously active controls
        {
            private _ctrl = _ctrlGroup controlsGroupCtrl _x;
            _ctrl ctrlShow false;
        } forEach _previouslyActiveCtrls;

        // Show the appropriate controls for this tab
        private _ctrlIdc = ctrlIDC _ctrl;
        private _activeCtrls = [];

        // Refresh the dialog row value as the user changes the tab
        private _display = ctrlParent _ctrl;
        private _values = _display getVariable QGVAR(values);

        switch (_ctrlIdc) do {
            case IDC_ACHILLES_ROW_TAB_SIDE: {
                _activeCtrls = IDCS_ACHILLES_ROW_SIDES;

                {
                    private _ctrlSide = _ctrlGroup controlsGroupCtrl _x;
                    private _params = _ctrlSide getVariable QGVAR(params);
                    _params params ["", "_side", "_color"];
                    private _isActive = _color select 3 == 1;

                    if (_isActive) then {
                        _values set [_rowIndex, _side];
                    };
                } forEach _activeCtrls;
            };
            case IDC_ACHILLES_ROW_TAB_GROUP: {
                _activeCtrls = [IDC_ACHILLES_ROW_TAB_GROUP_SELECT];

                private _ctrl = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_GROUP_SELECT;
                _values set [_rowIndex, _groups select (lbCurSel _ctrl)];
            };
            case IDC_ACHILLES_ROW_TAB_PLAYER: {
                _activeCtrls = [IDC_ACHILLES_ROW_TAB_PLAYER_SELECT];

                private _ctrl = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_PLAYER_SELECT;
                _values set [_rowIndex, _players select (lbCurSel _ctrl)];
            };
        };

        {
            private _ctrl = _ctrlGroup controlsGroupCtrl _x;
            _ctrl ctrlShow true;
        } forEach _activeCtrls;

        _params set [3, _ctrl];
        _params set [4, _activeCtrls];

        _ctrlGroup setVariable [QGVAR(params), _params];
    }];
} forEach IDCS_ACHILLES_ROW_TABS;
