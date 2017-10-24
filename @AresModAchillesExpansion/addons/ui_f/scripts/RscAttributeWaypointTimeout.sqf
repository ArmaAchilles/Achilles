#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private _mode = _this select 0;
private _params = _this select 1;
private _entity = _this select 2;

private _idcs = [
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME00,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME05,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME10,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME15,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME20,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME25,
	IDC_RSCATTRIBUTEWAYPOINTTIMEOUT_BUTTONTIME30
];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _daytime = (ceil (daytime * 12)) / 12;
		private _statements = ["true"];
		private _selected = parsenumber (waypointstatements _entity select 0);
		private _selectedIDC = _idcs select 0;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick",{with uinamespace do {["buttonClick",_this,[]] call RscAttributeWaypointTimeout}}];
			if (_foreachindex > 0) then {
				private _time = _daytime + _foreachindex * (1/12);
				_statements set [count _statements,format ["%1; daytime > %1",_time]];
				_ctrl ctrlsettext ([_time + 1/120,"HH:MM"] call bis_fnc_timetostring);
				if (abs (_time - _selected) < 0.01) then {_selectedIDC = _x;};
			} else {
				_ctrl ctrlsettext toupper ctrltext _ctrl;
			};
		} foreach _idcs;
		RscAttributeWaypointTimeout_statements = _statements;
		["buttonClick",[_display displayctrl _selectedIDC],[]] call RscAttributeWaypointTimeout;
	};
	case "buttonClick": {
		private _ctrlButton = _params select 0;
		private _display = ctrlparent _ctrlButton;
		private _buttonID = _idcs find (ctrlidc _ctrlButton);
		{
			(_display displayctrl _x) ctrlenable (_foreachindex != _buttonID);
		} foreach _idcs;
	};
	case "confirmed": {
		private _display = _params select 0;
		private _buttonID = 0;
		{
			if !(ctrlenabled (_display displayctrl _x)) exitwith {_buttonID = _foreachindex;};
		} foreach _idcs;

		private _statements = uinamespace getvariable ["RscAttributeWaypointTimeout_statements",["true","true","true","true","true","true","true"]];
		_entity setwaypointstatements [_statements select _buttonID,""];
	};
	case "onUnload": {
		RscAttributeWaypointTimeout_statements = nil;
	};
};
