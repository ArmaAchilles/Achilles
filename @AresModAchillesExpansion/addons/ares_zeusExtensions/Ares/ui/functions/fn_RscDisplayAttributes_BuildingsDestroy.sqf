
#define COMBO_IDC 			20000
#define DYNAMIC_GUI_IDD		133798
#define LABEL_IDC			[10001,10002]
#define CTRL_IDC			[20001,20002]
	
_mode = _this select 0;

if (not (_mode in ["LOADED",((localize "STR_SELECTION") call Achilles_fnc_TextToVariableName)])) exitWith {};

disableSerialization;
_dialog = findDisplay DYNAMIC_GUI_IDD;
_ctrl = _dialog displayCtrl COMBO_IDC;
_selection = lbCurSel _ctrl;

if (_selection == 0) then
{
	// "Nearest" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0.8;
		_ctrl ctrlEnable false;
		_ctrl ctrlCommit 0;
	} forEach (LABEL_IDC + CTRL_IDC);
} else
{
	// "Range" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0;
		if (_x in CTRL_IDC) then {_ctrl ctrlEnable true};
		_ctrl ctrlCommit 0;
	} forEach (LABEL_IDC + CTRL_IDC);
};