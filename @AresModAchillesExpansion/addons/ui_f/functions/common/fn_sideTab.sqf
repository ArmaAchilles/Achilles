// zeus, opfor, bluefor, greenfor, civilian
#define IDC_SIDE_ICONS [12000,12010,12020,12030,12040]

params ["_mode", "_caller", ["_index", 0, [0]], ["_default_side_index", 1, [0]]];


switch _mode do
{
	case "onLoad":
	{
		private _display = _caller;
		uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1', _index], -1];
		private _default_side_idc = IDC_SIDE_ICONS select _default_side_index;
		private _default_control = _display displayCtrl _default_side_idc;

		// Prepare Side Icons
		{
			private _ctrl = _display displayctrl _x;
			private _color = [(_foreachindex - 1) call bis_fnc_sideColor, [1,1,1,1]] select (_foreachindex == 0);
			_ctrl ctrlsetactivecolor _color;
			_color set [3,0.5];
			_ctrl ctrlsettextcolor _color;
			_ctrl ctrladdeventhandler ["buttonClick","['selectSide',_this select 0," + str(_index) + "] call Achilles_fnc_sideTab;"];
		} forEach IDC_SIDE_ICONS;

		// select the default side
		["selectSide", _default_control,_index] call Achilles_fnc_sideTab;
	};
	case "selectSide":
	{
		private _chosen_side_ctrl = _caller;
		private _display = ctrlParent _chosen_side_ctrl;
		private _chosen_side_idc = ctrlIDC _chosen_side_ctrl;
		private _new_side_index = IDC_SIDE_ICONS find _chosen_side_idc;
		private _old_side_index = uiNamespace getVariable [format['Ares_ChooseDialog_ReturnValue_%1', _index],-1];
		if (_new_side_index == _old_side_index) exitWith {};
		private _color = [(_new_side_index - 1) call bis_fnc_sideColor, [1,1,1,1]] select (_new_side_index == 0);
		_color set [3,1];
		_chosen_side_ctrl ctrlsettextcolor _color;
		[_chosen_side_ctrl,1.2,0.1] call bis_fnc_ctrlsetscale;
		_chosen_side_ctrl ctrlEnable false;

		if (_old_side_index != -1) then
		{
			private _old_side_idc = IDC_SIDE_ICONS select _old_side_index;
			private _old_side_ctrl = _display displayCtrl _old_side_idc;
			_color = [(_old_side_index - 1) call bis_fnc_sideColor, [1,1,1,1]] select (_old_side_index == 0);
			_color set [3,0.5];
			_old_side_ctrl ctrlsettextcolor _color;
			[_old_side_ctrl,1,0.1] call bis_fnc_ctrlsetscale;
			_old_side_ctrl ctrlEnable true;
		};
		uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1', _index], _new_side_index];
	};
};
