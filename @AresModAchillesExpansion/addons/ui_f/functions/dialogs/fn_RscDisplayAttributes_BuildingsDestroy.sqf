
#define BASE_CTRL_IDC		20000
#define IDD_DYNAMIC_GUI		133798
#define DAMAGE_SLIDER_IDC	20001
#define LABEL_IDCs			[10003,10004]
#define CTRL_IDCs			[20003,20004]

private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

switch (_mode) do
{
	case "LOADED":
	{
		_dialog = findDisplay IDD_DYNAMIC_GUI;
		{
			_ctrl = _dialog displayCtrl (BASE_CTRL_IDC + _x);
			_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_ctrl lbSetCurSel _last_choice;
			if (_x == 0) then
			{
				[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_BuildingsDestroy;
			};
		} forEach [0,1,2,4];
	};
	case "0":
	{
		// selection combo changed
		_dialog = findDisplay IDD_DYNAMIC_GUI;

		if (_comboIndex == 0) then
		{
			// "Nearest" selected
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach (LABEL_IDCs + CTRL_IDCs);
		} else
		{
			// "Range" selected
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				if (_x in CTRL_IDCs) then {_ctrl ctrlEnable true};
				_ctrl ctrlCommit 0;
			} forEach (LABEL_IDCs + CTRL_IDCs);
		};
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
