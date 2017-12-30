
#define IDC_RSCATTRIBUTEENGINE_ON			113628
#define IDC_RSCATTRIBUTEENGINE_OFF			113631
#define IDC_RSCATTRIBUTEENGINE_DEFAULT		123471
#define IDC_RSCATTRIBUTEENGINE_BACKGROUND	113426

params ["_mode", "_params", "_entity"];

_idcs =
[
	IDC_RSCATTRIBUTEENGINE_ON,
	IDC_RSCATTRIBUTEENGINE_OFF,
	IDC_RSCATTRIBUTEENGINE_DEFAULT
];
private _states = [true, false, "auto"];

switch _mode do
{
	case "onLoad":
	{

		private _display = _params select 0;

		//--- Not available for destroyed object
		if (!alive _entity) exitwith {
			{
				private _ctrl = _display displayctrl _x;
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} foreach _idcs;
			private _ctrlBackground = _display displayctrl IDC_RSCATTRIBUTEENGINE_BACKGROUND;
			_ctrlBackground ctrlsettext localize "STR_AMAE_lib_info_na";
		};

		//--- Add handlers to all buttons
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeEngine};"];
		} foreach _idcs;

		//--- Select the current state
		private _selected = _entity getVariable ["engine","auto"];
		private _selectedIndex = _states find _selected;
		private _selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeEngine;
	};
	case "onButtonClick":
	{
		_params params ["_ctrlSelected", "_delay"];
		_display = ctrlparent _ctrlSelected;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeEngine};"];
			private _scale = 1;
			private _color = [1,1,1,0.4];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
				_color = [1,1,1,1];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeEngine_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed":
	{
		private _display = _params select 0;
		private _selectedIndex = uinamespace getvariable ["RscAttributeEngine_selected",0];
		private _engine = _states select _selectedIndex;
		if ((_entity getVariable ["engine","auto"]) isEqualTo _engine) exitwith {};
		private _curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
		if (_engine isEqualTo "auto") exitWith
		{
			{_x setVariable ["engine","auto",true]} forEach _curatorSelected;
		};
		{
			_x setVariable ["engine",_engine,true];
			private _codeBlock =
			{
				params ["_entity", "_engine"];
				while {(alive _entity) and ((_entity getVariable ["engine","auto"]) isEqualTo _engine)} do
				{
					sleep 0.01;
					_entity engineOn _engine;
				};
			};
			if (local _x) then {[_x,_engine] spawn _codeBlock} else {[[_x,_engine],_codeBlock, _x] call Achilles_fnc_spawn};
		} forEach _curatorSelected;
		_entity setvariable ["updated",true,true];
		false
	};
	case "onUnload":
	{
		RscAttributeEngine_selected = nil;
	};
};
