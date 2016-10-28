
#define IDC_RSCATTRIBUTECOMBATMODE_HOLDFIRE			123472
#define IDC_RSCATTRIBUTECOMBATMODE_HOLDFIREDEFEND	123471
#define IDC_RSCATTRIBUTECOMBATMODE_HOLDFIREENGAGE	123474
#define IDC_RSCATTRIBUTECOMBATMODE_FIRE				123475
#define IDC_RSCATTRIBUTECOMBATMODE_FIREENGAGE		123469
#define IDC_RSCATTRIBUTECOMBATMODE_DEFAULT			123470

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_idcs = 
[
	IDC_RSCATTRIBUTECOMBATMODE_HOLDFIRE,
	IDC_RSCATTRIBUTECOMBATMODE_HOLDFIREDEFEND,
	IDC_RSCATTRIBUTECOMBATMODE_HOLDFIREENGAGE,
	IDC_RSCATTRIBUTECOMBATMODE_FIRE,
	IDC_RSCATTRIBUTECOMBATMODE_FIREENGAGE,
	IDC_RSCATTRIBUTECOMBATMODE_DEFAULT
];
_states = 
[
	"BLUE",
	"GREEN",
	"WHITE",
	"YELLOW",
	"RED",
	"NO CHANGE"
];
_colors = 

[
	[1,0,0,1],
	[1,0,0,1],
	[1,0,0,1],
	[1,1,1,1],
	[1,1,1,1],
	[1,1,1,1]
];

switch _mode do {
	case "onLoad": {

		_display = _params select 0;

		//--- Add handlers to all buttons
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeCombatMode};"];
			_ctrl ctrlsetactivecolor (_colors select _foreachindex);
		} foreach _idcs;

		//--- Select the current state
		_selected = if (typename _entity == typename []) then {
			waypointCombatMode _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTECOMBATMODE_DEFAULT) ctrlshow false;
			combatMode leader _entity
		};
		_selectedIndex = _states find _selected;
		_selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeCombatMode;
	};
	case "onButtonClick": {
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

		RscAttributeCombatMode_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		_display = _params select 0;
		_selectedIndex = uinamespace getvariable ["RscAttributeCombatMode_selected",0];
		_selected = _states select _selectedIndex;
		if (typename _entity == typename []) then {
			if (currentwaypoint (_entity select 0) == (_entity select 1) && _selected != "UNCHANGED") then {(_entity select 0) setcombatmode _selected;};
			_entity setwaypointcombatmode _selected;
		} else {
			_entity setcombatmode _selected;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeCombatMode_selected = nil;
	};
};