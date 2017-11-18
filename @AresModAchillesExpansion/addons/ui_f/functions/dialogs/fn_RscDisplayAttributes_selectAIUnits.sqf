#define IDD_DYNAMIC_GUI		133798
#define IDC_MODE_COMBO		20000
#define IDC_SIDE_LABLE		[10001,20001]
#define IDC_SIDE_ICONS		[12000,12010,12020,12030,12040]
/*
IDD_DYNAMIC_GUI		=133798;
IDC_MODE_COMBO		=20000;
IDC_SELECTION_COMBO	=20001;
IDC_SELECTION_LABLE =10001;
IDC_SIDE_LABLE		=[10002,20002];
IDC_SIDE_ICONS		=[12000,12010,12020,12030,12040];
*/
private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

private _dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		{
			_ctrl = _dialog displayCtrl (IDC_MODE_COMBO + _x);
			if (not isNull _ctrl) then
			{
				_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
				_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
				_last_choice = [(lbSize _ctrl) - 1, _last_choice] select (_last_choice < lbSize _ctrl);
				_ctrl lbSetCurSel _last_choice;
				if (_x == 0) then
				{
					[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_selectAIUnits;
				};
			};
		} forEach [0,2,3];
	};
	case "0":
	{
		switch true do
		{
			case (_comboIndex < 2):
			{
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0.8;
					_ctrl ctrlEnable false;
					_ctrl ctrlCommit 0;
				} forEach (IDC_SIDE_LABLE + IDC_SIDE_ICONS);
			};
			case (_comboIndex == 2):
			{
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0;
					if (_x in IDC_SIDE_ICONS) then {_ctrl ctrlEnable true};
					_ctrl ctrlCommit 0;
				} forEach (IDC_SIDE_LABLE + IDC_SIDE_ICONS);
			};
		};

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
	};
	case "UNLOAD": {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
