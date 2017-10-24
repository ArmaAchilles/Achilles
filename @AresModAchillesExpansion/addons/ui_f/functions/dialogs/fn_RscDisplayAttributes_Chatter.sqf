#define CHAT_CTRL_IDC		20000
#define EDIT_CTRL_IDC		20001
#define IDD_DYNAMIC_GUI		133798

private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

switch (_mode) do
{
	case "LOADED":
	{
		private _dialog = findDisplay IDD_DYNAMIC_GUI;
		
		private _chat_ctrl = _dialog displayCtrl CHAT_CTRL_IDC;
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_chat_ctrl lbSetCurSel _last_choice;
		
		private _edit_ctrl = _dialog displayCtrl EDIT_CTRL_IDC;
		ctrlSetFocus _edit_ctrl;
		_edit_ctrl ctrlSetText "";
		[0,_chat_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Chatter;
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
