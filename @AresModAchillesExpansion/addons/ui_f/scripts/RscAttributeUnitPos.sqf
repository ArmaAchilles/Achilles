#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private _mode = _this select 0;
private _params = _this select 1;
private _entity = _this select 2;

private _idcs = [
	IDC_RSCATTRIBUTEUNITPOS_DOWN,
	IDC_RSCATTRIBUTEUNITPOS_CROUCH,
	IDC_RSCATTRIBUTEUNITPOS_UP,
	IDC_RSCATTRIBUTEUNITPOS_AUTO
];
private _stances = ["down","middle","up","auto"];

switch _mode do {
	case "onLoad": {

		private _display = _params select 0;

		//--- Add handlers to all buttons
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeUnitPos};"];
			_ctrl ctrlcommit 0;
		} foreach _idcs;

		//--- Select the current rank
		if (typename _entity == typename grpnull) then {_entity = leader _entity;};
		private _selected = _stances find (tolower unitpos _entity);
		private _idc = _idcs select _selected;
		['onButtonClick',[_display displayctrl _idc,0]] call RscAttributeUnitPos;
	};
	case "onButtonClick": {
		private _control = _params select 0;
		private _delay = _params select 1;
		private _display = ctrlparent _control;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_control ctrlsettextcolor [1,1,1,1];
		[_control,1.25,_delay] call bis_fnc_ctrlsetscale;
		RscAttributeUnitPos_selected = _idcs find (ctrlidc _control);
	};
	case "confirmed": {
	private ["_previousStanceId", "_entities"];
		private _display = _params select 0;
		private _selected = uinamespace getvariable ["RscAttributeUnitPos_selected",0];
		if (typename _entity == typename grpnull) then {
			private _selectedGroups = ["group"] call Achilles_fnc_getCuratorSelected;
			_entities = [];
			{_entities append units _x} forEach _selectedGroups;
			_previousStanceId = _stances find (tolower unitpos leader _entity);
		} else {
			_entities = ["man"] call Achilles_fnc_getCuratorSelected;
			_previousStanceId = _stances find (tolower unitpos _entity);
		};
		if (_previousStanceId == _selected) exitWith {};
		private _stance = _stances select _selected;
		{
			if (local _x) then
			{
				_x setunitpos _stance;
			} else {
				[_x, _stance] remoteExecCall ["setunitpos", _x];
			};
		} forEach _entities;
		false
	};
	case "onUnload": {
		RscAttributeUnitPos_selected = nil;
	};
};
