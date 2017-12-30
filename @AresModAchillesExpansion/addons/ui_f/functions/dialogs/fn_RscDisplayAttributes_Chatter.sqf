#define CHAT_CTRL_IDC		20000
#define EDIT_CTRL_IDC		20001
#define IDD_DYNAMIC_GUI		133798

disableSerialization;
params ["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

switch (_mode) do
{
	case "LOADED":
	{
		private _dialog = findDisplay IDD_DYNAMIC_GUI;

		private _chat_ctrl = _dialog displayCtrl CHAT_CTRL_IDC;
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
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
