#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTEUNITPOS_DOWN,
	IDC_RSCATTRIBUTEUNITPOS_CROUCH,
	IDC_RSCATTRIBUTEUNITPOS_UP,
	IDC_RSCATTRIBUTEUNITPOS_AUTO
];
_stances = ["down","middle","up","auto"];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeUnitPos};"];
			_ctrl ctrlcommit 0;
		} foreach _idcs;

		//--- Select the current rank
		if (typename _entity == typename grpnull) then {_entity = leader _entity;};
		_selected = _stances find (tolower unitpos _entity);
		_idc = _idcs select _selected;
		['onButtonClick',[_display displayctrl _idc,0]] call RscAttributeUnitPos;
	};
	case "onButtonClick": {
		_control = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _control;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor [1,1,1,0.5];
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;
		_control ctrlsettextcolor [1,1,1,1];
		[_control,1.25,_delay] call bis_fnc_ctrlsetscale;
		RscAttributeUnitPos_selected = _idcs find (ctrlidc _control);
	};
	case "confirmed": {
	private ["_previousStanceId", "_entities"];
		_display = _params select 0;
		_selected = uinamespace getvariable ["RscAttributeUnitPos_selected",0];
		if (typename _entity == typename grpnull) then {
			_selectedGroups = ["group"] call Achilles_fnc_getCuratorSelected;
			_entities = [];
			{_entities append units _x} forEach _selectedGroups;
			_previousStanceId = _stances find (tolower unitpos leader _entity);
		} else {
			_entities = ["man"] call Achilles_fnc_getCuratorSelected;
			_previousStanceId = _stances find (tolower unitpos _entity);
		};
		if (_previousStanceId == _selected) exitWith {};
		_stance = _stances select _selected;
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