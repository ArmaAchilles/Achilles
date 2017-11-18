#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#define IDC_RSCATTRIBUTEBEHAVIOUR_CARELESS 23472

params ["_mode", "_params", "_entity"];

_idcs =
[
    IDC_RSCATTRIBUTEBEHAVIOUR_CARELESS,
    IDC_RSCATTRIBUTEBEHAVIOUR_SAFE,
    IDC_RSCATTRIBUTEBEHAVIOUR_AWARE,
    IDC_RSCATTRIBUTEBEHAVIOUR_COMBAT,
    IDC_RSCATTRIBUTEBEHAVIOUR_STEALTH,
    IDC_RSCATTRIBUTEBEHAVIOUR_DEFAULT
];
_states =
[
    "CARELESS",
    "SAFE",
    "AWARE",
    "COMBAT",
    "STEALTH",
    "UNCHANGED"
];
_colors =
[
    [1,1,1,1],
    [0,1,0,1],
    [1,1,0,1],
    [1,0,0,1],
    [0,1,1,1],
    [1,1,1,1]
];

switch _mode do {
    case "onLoad":
    {
        _display = _params select 0;
        //--- Add handlers to all buttons
        {
            _ctrl = _display displayctrl _x;
            _ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeBehaviour};"];
            _ctrl ctrlsetactivecolor (_colors select _foreachindex);
        } foreach _idcs;

		//--- Select the current state
        _selected = if (_entity isEqualType []) then {
            waypointbehaviour _entity
        } else {
            (_display displayctrl IDC_RSCATTRIBUTEBEHAVIOUR_DEFAULT) ctrlshow false;
            behaviour leader _entity
		};
        _selectedIndex = _states find _selected;
        _selectedIDC = _idcs select _selectedIndex;
        ['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeBehaviour;
	};
    case "onButtonClick":
    {
        _ctrlSelected = _params select 0;
        _delay = _params select 1;
        _display = ctrlparent _ctrlSelected;
        {
            _ctrl = _display displayctrl _x;
            _scale = 1.25;
            _color = +(_colors select _foreachindex);//[1,1,1,0.4];
            if (_ctrl != _ctrlSelected) then {
                _scale = 1;
                _color set [3,0.4];
            };
            _ctrl ctrlsettextcolor _color;
            [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
        } foreach _idcs;

        RscAttributeBehaviour_selected = _idcs find (ctrlidc _ctrlSelected);
    };
    case "confirmed":
    {
        _display = _params select 0;
        _selectedIndex = uinamespace getvariable ["RscAttributeBehaviour_selected",0];
        _selected = _states select _selectedIndex;

        if (_entity isEqualType []) then
        {
            if (waypointbehaviour _entity == _selected) exitWith {};
            _curatorSelectedWPs = ["wp"] call Achilles_fnc_getCuratorSelected;
            {
                _group = _x select 0;
                _wp_id = _x select 1;
                if (currentwaypoint _group == _wp_id && _selected != "UNCHANGED") then
                {
                    [[_group,_selected] remoteExec ["setbehaviour", leader _group], _group setbehaviour _selected] select (local _group);
                };
                _x setwaypointbehaviour _selected;
            } forEach _curatorSelectedWPs;
        } else
        {
            if (behaviour leader _entity == _selected) exitWith {};
            _curatorSelectedGrps = ["group"] call Achilles_fnc_getCuratorSelected;
            {
                _leader = leader _x;
                [[_x, _selected] remoteExec ["setbehaviour", _leader], _x setbehaviour _selected] select (local _leader);
            } forEach _curatorSelectedGrps;
            _entity setvariable ["updated",true,true];
        };
        false
    };
    case "onUnload": {
        RscAttributeBehaviour_selected = nil;
    };
};
