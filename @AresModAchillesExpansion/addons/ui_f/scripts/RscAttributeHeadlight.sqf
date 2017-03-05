
#define IDC_RSCATTRIBUTEHEADLIGHT_ON			113627
#define IDC_RSCATTRIBUTEHEADLIGHT_OFF			113630
#define IDC_RSCATTRIBUTEHEADLIGHT_DEFAULT		123470
#define IDC_RSCATTRIBUTEHEADLIGHT_BACKGROUND	113425

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = 
[
	IDC_RSCATTRIBUTEHEADLIGHT_ON,
	IDC_RSCATTRIBUTEHEADLIGHT_OFF,
	IDC_RSCATTRIBUTEHEADLIGHT_DEFAULT
];
_states = [true,false,"auto"];

switch _mode do 
{
	case "onLoad": 
	{

		_display = _params select 0;

		//--- Not available for destroyed object
		if !(alive _entity) exitwith {
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} foreach _idcs;
			_ctrlBackground = _display displayctrl IDC_RSCATTRIBUTEHEADLIGHT_BACKGROUND;
			_ctrlBackground ctrlsettext localize "str_lib_info_na";
		};

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeHeadlight};"];
		} foreach _idcs;

		//--- Select the current state
		_selected = _entity getVariable ["headlight","auto"];
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeHeadlight;
	};
	case "onButtonClick": 
	{
		_ctrlSelected = _params select 0;
		_delay = _params select 1;
		_display = ctrlparent _ctrlSelected;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeHeadlight};"];
			_scale = 1;
			_color = [1,1,1,0.4];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
				_color = [1,1,1,1];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeHeadlight_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": 
	{
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeHeadlight_selected",0];
		_light = _states select _selectedIndex;
		if ((_entity getVariable ["headlight","auto"]) isEqualTo _light) exitwith {};
		_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
		{
			_x setVariable ["headlight",_light,true];
			if (_light isEqualTo "auto") exitWith {};
			_codeBlock = 
			{
				_entity = _this select 0;
				_light = _this select 1;
				while {(alive _entity) and ((_entity getVariable ["headlight","auto"]) isEqualTo _light)} do
				{
					sleep 0.01;
					_entity setpilotlight _light;
				};
			};
			if (local _x) then 
			{
				[_x,_light] spawn _codeBlock;
			} else 
			{
				[[_x,_light],_codeBlock] remoteExec ["spawn", _x];
			};
		} forEach _curatorSelected;
		_entity setvariable ["updated",true,true];
		false
	};
	case "onUnload": 
	{
		RscAttributeHeadlight_selected = nil;
	};
};