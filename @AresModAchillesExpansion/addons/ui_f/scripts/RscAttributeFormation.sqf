#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_entity"];

private _idcs = [
	IDC_RSCATTRIBUTEFORMATION_WEDGE,
	IDC_RSCATTRIBUTEFORMATION_VEE,
	IDC_RSCATTRIBUTEFORMATION_LINE,
	IDC_RSCATTRIBUTEFORMATION_COLUMN,
	IDC_RSCATTRIBUTEFORMATION_FILE,
	IDC_RSCATTRIBUTEFORMATION_STAG_COLUMN,
	IDC_RSCATTRIBUTEFORMATION_ECH_LEFT,
	IDC_RSCATTRIBUTEFORMATION_ECH_RIGHT,
	IDC_RSCATTRIBUTEFORMATION_DIAMOND,
	IDC_RSCATTRIBUTEFORMATION_DEFAULT
];
private _states = [
	"WEDGE",
	"VEE",
	"LINE",
	"COLUMN",
	"FILE",
	"STAG COLUMN",
	"ECH LEFT",
	"ECH RIGHT",
	"DIAMOND",
	"NO CHANGE"
];

switch _mode do {
	case "onLoad": {

		private _display = _params select 0;

		//--- Add handlers to all buttons
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeFormation};"];
		} foreach _idcs;

		//--- Select the current state
		private _selected = if (_entity isEqualType []) then {
			waypointformation _entity
		} else {
			(_display displayctrl IDC_RSCATTRIBUTEFORMATION_DEFAULT) ctrlshow false;
			formation _entity;
		};
		private _selectedIndex = _states find _selected;
		private _selectedIDC = _idcs select _selectedIndex;
		['onButtonClick',[_display displayctrl _selectedIDC,0]] call RscAttributeFormation;
	};
	case "onButtonClick": {
		private _ctrlSelected = _params select 0;
		private _delay = _params select 1;
		private _display = ctrlparent _ctrlSelected;
		{
			private _ctrl = _display displayctrl _x;
			private _scale = 1;
			private _color = [1,1,1,0.4];
			if (_ctrl == _ctrlSelected) then {
				_scale = 1.25;
				_color = [1,1,1,1];
			};
			_ctrl ctrlsettextcolor _color;
			[_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeFormation_selected = _idcs find (ctrlidc _ctrlSelected);
	};
	case "confirmed": {
		private _display = _params select 0;
		private _selectedIndex = uinamespace getvariable ["RscAttributeFormation_selected",0];
		private _selected = _states select _selectedIndex;

		if (_entity isEqualType []) then
		{
			if (waypointformation _entity == _selected) exitWith {};
			private _curatorSelectedWPs = ["wp"] call Achilles_fnc_getCuratorSelected;
			{
				private _group = _x select 0;
				private _wp_id = _x select 1;
				if (currentwaypoint _group == _wp_id && _selected != "NO CHANGE") then
				{
					if (local _group) then
					{
						_group setformation _selected;
					} else
					{
						[_group,_selected] remoteExec ["setformation", leader _group];
					};
				};
				_x setwaypointformation _selected;
			} forEach _curatorSelectedWPs;
		} else
		{
			if (formation leader _entity == _selected) exitWith {};
			private _curatorSelectedGrps = ["group"] call Achilles_fnc_getCuratorSelected;
			{
				private _leader = leader _x;
				if (local _leader) then
				{
					_x setformation _selected;
				} else
				{
					[_x,_selected] remoteExec ["setformation", _leader];
				};
			} forEach _curatorSelectedGrps;
			_entity setvariable ["updated",true,true];
		};
		false
	};
	case "onUnload": {
		RscAttributeFormation_selected = nil;
	};
};
