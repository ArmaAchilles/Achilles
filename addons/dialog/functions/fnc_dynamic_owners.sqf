/*
* Author: CreepPork
* Set up function for the owners control.
*
* Arguments:
* 0: Control Group <CONTROL>
* 1: Row Index <SCALAR>
* 2: Default value <SIDE|GROUP|OBJECT> (default: west)
*
* Return Value:
* Nothing
*
* Example:
* [_ctrl, 0] call achilles_dialog_fnc_dynamic_owner
*
* Public: No
*/

#include "script_component.hpp"

params [
    ["_ctrlGroup", controlNull, [controlNull]],
    ["_rowIndex", 0, [0]],
    ["_defaultValue", west, [west, grpNull, objNull]]
];

private _fnc_changeControlStatus = {
    params ["_ctrlGroup", "_allCtrls", "_show"];
    {
        private _ctrl = _ctrlGroup controlsGroupCtrl _x;
        _ctrl ctrlShow _show;
    } forEach _allCtrls;
};

private _activeCtrl = controlNull;
private _activeCtrls = [];

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

private _ctrlsToHide = [];

// Init side control and
switch (typeName _defaultValue) do {
    case "SIDE": {
        [_ctrlGroup, _rowIndex, _defaultValue] call achilles_dialog_fnc_dynamic_sides;

        _activeCtrl = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_SIDE;
        _activeCtrl ctrlEnable false;
        _activeCtrls = IDCS_ACHILLES_ROW_SIDES;

        // Hide all the combo boxes as they would overlap with the side control on first load
        _ctrlsToHide = IDCS_ACHILLES_ROW_TAB_SELECTS;
    };
    case "GROUP": {
        [_ctrlGroup, _rowIndex] call achilles_dialog_fnc_dynamic_sides;

        private _groupDefault = _groups find _defaultValue;

        if (_groupDefault != -1) then {
            _groupSelect lbSetCurSel _groupDefault;
        };

        _activeCtrl = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_GROUP;
        _activeCtrl ctrlEnable false;
        _activeCtrls = [IDC_ACHILLES_ROW_TAB_GROUP_SELECT];

        _ctrlsToHide = IDCS_ACHILLES_ROW_SIDES;
        _ctrlsToHide append [IDC_ACHILLES_ROW_TAB_PLAYER_SELECT];
    };
    case "OBJECT": {
        [_ctrlGroup, _rowIndex] call achilles_dialog_fnc_dynamic_sides;

        private _playerDefault = _players find _defaultValue;

        if (_playerDefault != -1) then {
            _playerSelect lbSetCurSel _playerDefault;
        };

        _activeCtrl = _ctrlGroup controlsGroupCtrl IDC_ACHILLES_ROW_TAB_PLAYER;
        _activeCtrl ctrlEnable false;
        _activeCtrls = [IDC_ACHILLES_ROW_TAB_PLAYER_SELECT];

        _ctrlsToHide = IDCS_ACHILLES_ROW_SIDES;
        _ctrlsToHide append [IDC_ACHILLES_ROW_TAB_GROUP_SELECT];
    };
};

[_ctrlGroup, _ctrlsToHide, false] call _fnc_changeControlStatus;

// Add event handlers to handle value saving on dropdown change
{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;

    _ctrl ctrlAddEventHandler ["LBSelChanged", {
        params ["_ctrl", "_index"];

        private _display = ctrlParent _ctrl;
        private _values = _display getVariable QGVAR(values);

        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _params = _ctrlGroup getVariable [QGVAR(params), []];
        _params params ["_rowIndex", "_players", "_groups"];

        if (ctrlIDC _ctrl == IDC_ACHILLES_ROW_TAB_GROUP_SELECT) then {
            _values set [_rowIndex, _groups select _index];
        } else {
            _values set [_rowIndex, _players select _index];
        };
    }];
} forEach IDCS_ACHILLES_ROW_TAB_SELECTS;

_ctrlGroup setVariable [QGVAR(params), [_rowIndex, _players, _groups, _activeCtrl, _activeCtrls, _fnc_changeControlStatus]];

{
    private _ctrl = _ctrlGroup controlsGroupCtrl _x;

    _ctrl ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _ctrlGroup = ctrlParentControlsGroup _ctrl;
        private _params = _ctrlGroup getVariable [QGVAR(params), []];
        _params params ["_rowIndex", "_players", "_groups", "_disabledCtrl", "_previouslyActiveCtrls", "_fnc_changeControlStatus"];

        // Set the current "active" control to the one that just got pressed
        _disabledCtrl ctrlEnable true;
        _ctrl ctrlEnable false;

        // Hide previously active controls
        [_ctrlGroup, _previouslyActiveCtrls, false] call _fnc_changeControlStatus;

        // Show the appropriate controls for this tab
        private _activeCtrls = [];

        // Refresh the dialog row value as the user changes the tab
        private _display = ctrlParent _ctrl;
        private _values = _display getVariable QGVAR(values);

        switch (ctrlIDC _ctrl) do {
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

        [_ctrlGroup, _activeCtrls, true] call _fnc_changeControlStatus;

        _params set [3, _ctrl];
        _params set [4, _activeCtrls];

        _ctrlGroup setVariable [QGVAR(params), _params];
    }];
} forEach IDCS_ACHILLES_ROW_TABS;
