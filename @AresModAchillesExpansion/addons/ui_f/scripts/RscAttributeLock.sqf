#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = [
	IDC_RSCATTRIBUTELOCK_LOCKED,
	IDC_RSCATTRIBUTELOCK_UNLOCKED,
	IDC_RSCATTRIBUTELOCK_UNLOCKED,
	IDC_RSCATTRIBUTELOCK_LOCKED
];
_states = [3,1,0,2];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Not available for destroyed object
		if !(alive _entity) exitwith {
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} foreach _idcs;
			_ctrlBackground = _display displayctrl IDC_RSCATTRIBUTELOCK_BACKGROUND;
			_ctrlBackground ctrlsettext localize "str_lib_info_na";
		};

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeLock};"];
		} foreach _idcs;

		//--- Select the current state
		_selected = locked _entity;
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeLock;
	};
	case "onButtonClick": {
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeLock};"];
			_scale = 1;
			_color = [1,1,1,0.4];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
				_color = [1,1,1,1];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeLock_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeLock_selected",0];
		_lock = _states select _selectedIndex;
		if (locked _entity == _lock) exitwith {};
		_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
		{
			if (local _x) then {
				_x lock _lock;
			} else {
				[_x, _lock] remoteExecCall ["lock", _x];
			};
		} forEach _curatorSelected;
		_entity setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		RscAttributeLock_selected = nil;
	};
};