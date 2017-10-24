#define IDD_DYNAMIC_GUI		133798
#define IDC_COMBO_BASE		20000
#define IDC_RADIUS_COMBO	20002
#define IDC_RADIUS_LABLE	10002
#define IDC_TYPE_COMBO		20003
#define IDC_MODE_COMBO		20004
#define IDC_MODE_LABLE 		10004
#define IDC_SIDE_LABLE		[10005,20005]
#define IDC_SIDE_ICONS		[12000,12010,12020,12030,12040]
/*
IDD_DYNAMIC_GUI		=133798;
IDC_COMBO_BASE		=20000;
IDC_TYPE_COMBO		=20003;
IDC_MODE_COMBO		=20004;
IDC_MODE_LABLE 		=10004;
IDC_SIDE_LABLE		=[10005,20005];
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
			_ctrl = _dialog displayCtrl (IDC_COMBO_BASE + _x);
			if (not isNull _ctrl) then
			{
				_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
				_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
				_last_choice = if (_last_choice < lbSize _ctrl) then {_last_choice} else {(lbSize _ctrl) - 1};
				_ctrl lbSetCurSel _last_choice;
			};
		} forEach [0,1,3];
	};
	case "1":
	{
		if (_comboIndex == 0) then
		{
			_ctrl = _dialog displayCtrl IDC_RADIUS_COMBO;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlEnable true;
			_ctrl ctrlCommit 0;

			_ctrl = _dialog displayCtrl IDC_RADIUS_LABLE;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;	
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach [IDC_RADIUS_COMBO,IDC_RADIUS_LABLE];
		};
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
	};
	case "3":
	{
		if (_comboIndex == 1) then
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlEnable true;
				_ctrl ctrlCommit 0;
			} forEach ([IDC_MODE_COMBO] + IDC_SIDE_ICONS);
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0;
			} forEach ([IDC_MODE_LABLE] + IDC_SIDE_LABLE);
			
			_mode_ctrl = _dialog displayCtrl IDC_MODE_COMBO;
			_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_4", 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_last_choice = if (_last_choice < lbSize _mode_ctrl) then {_last_choice} else {(lbSize _mode_ctrl) - 1};
			_mode_ctrl lbSetCurSel _last_choice;
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach ([IDC_MODE_COMBO,IDC_MODE_LABLE] + IDC_SIDE_LABLE + IDC_SIDE_ICONS);
		};
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_3", _comboIndex];
	};
	case "4":
	{
		if (_comboIndex == 1) then
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlEnable true;
				_ctrl ctrlCommit 0;
			} forEach IDC_SIDE_ICONS;
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				_ctrl ctrlCommit 0;
			} forEach IDC_SIDE_LABLE;	
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach (IDC_SIDE_LABLE + IDC_SIDE_ICONS);
		};
	
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_4", _comboIndex];
	};
	case "UNLOAD": {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
