
#define GUI_GRID_H					(0.04)
#define GtC_H(GRID)					GRID * GUI_GRID_H

#define IDD_DYNAMIC_GUI				133798
#define IDC_CTRL_BASE				20000
#define IDCs_INTEL_TEXT				[10004,20004]
#define IDCs_SHARED					[10005,20005]
#define	DYNAMIC_BOTTOM_IDCs			[2010,3000,3010]

private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

_dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		_object = Achilles_var_currentIntel;
		_offset = if (isNull _object) then {1} else {0};
		_params = _object getVariable ["Achilles_var_intel",[]];
		if (count _params != 0) then
		{
			// load intel information if aviable
			{
				_text = _params select _x;
				_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _x);
				_ctrl ctrlSetText _text;
				uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_x], _text];
			} forEach [0,1,3,4];
			{
				_index = _params select _x;
				_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _x);
				_ctrl lbSetCurSel _index;
				uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_x], _index];
			} forEach [2,5];
		} else
		{
			{
				_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _x);
				_ctrl lbSetCurSel 0;
				uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_x], 0];
			} forEach [2+_offset,5+_offset];	
			if (_offset == 1) then
			{
				_ctrl = _dialog displayCtrl IDC_CTRL_BASE;
				_ctrl lbSetCurSel 0;
				uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", 0];				
			};
		};
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
