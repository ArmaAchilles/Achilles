#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_entity"];

private _idcs = [
	IDC_RSCATTRIBUTESPEEDMODE_LIMITED,
	IDC_RSCATTRIBUTESPEEDMODE_NORMAL,
	IDC_RSCATTRIBUTESPEEDMODE_FULL,
	IDC_RSCATTRIBUTESPEEDMODE_DEFAULT
];
private _states = [
	"LIMITED",
	"NORMAL",
	"FULL",
	"UNCHANGED"
];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;

		//--- Add handlers to all buttons
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeSpeedMode};"];
			_ctrl ctrlsetactivecolor (_colors select _foreachindex);
		} foreach _idcs;

		//--- Select the current state
		private _selected = if (_entity isequalType []) then {
			waypointspeed _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTESPEEDMODE_DEFAULT) ctrlshow false;
			speedmode leader _entity
		};
		private _selectedIndex = _states find _selected;
		private _selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeSpeedMode;
	};
	case "onButtonClick": {
		private _ctrlSelected = _params select 0;
		private _delay = _params select 1;
		private _display = ctrlparent _ctrlSelected;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.4];
			[_ctrl, [1.25, 1] select (_ctrl != _ctrlSelected), _delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_ctrlSelected ctrlsettextcolor [1,1,1,1];

		RscAttributeSpeedMode_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		private _display = _params select 0;
		private _selectedIndex = uinamespace getvariable ["RscAttributeSpeedMode_selected",0];
		private _selected = _states select _selectedIndex;
		if (_entity isEqualType []) then
		{
			if (waypointSpeed _entity == _selected) exitWith {};
			private _curatorSelectedWPs = ["wp"] call Achilles_fnc_getCuratorSelected;
			{
				private _group = _x select 0;
				private _wp_id = _x select 1;
				if (currentwaypoint _group == _wp_id && _selected != "UNCHANGED") then
				{
					[[_group, _selected] remoteExec ["setspeedmode",leader _group], _group setspeedmode _selected] select (local _group);
				};
				_x setwaypointspeed _selected;
			} forEach _curatorSelectedWPs;
		} else {
			if (speedMode leader _entity == _selected) exitWith {};
			private _curatorSelectedGrps = ["group"] call Achilles_fnc_getCuratorSelected;
			{
				private _leader = leader _x;
				[[_x, _selected] remoteExec ["setspeedmode", _leader], _x setspeedmode _selected] select (local _leader);
			} forEach _curatorSelectedGrps;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeSpeedMode_selected = nil;
	};
};
