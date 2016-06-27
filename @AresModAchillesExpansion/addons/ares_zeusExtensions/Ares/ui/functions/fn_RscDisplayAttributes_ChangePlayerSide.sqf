
#define COMBO_IDC 			20000
#define DYNAMIC_GUI_IDD		133798
#define SIDE_CTRL_IDC		[12000,12010,12020,12030,12040]
#define LABEL_CTRL_IDC		[10001,20001]

	
disableSerialization;
_dialog = findDisplay DYNAMIC_GUI_IDD;

_selection = param [2,3,[0]];

if (_selection == 3) then
{
	// case "LOAD"
	_ctrl = _dialog displayCtrl COMBO_IDC;
	_selection = lbCurSel _ctrl;
};

if (_selection < 2) then
{
	// "All" or "Selection" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0.8;
		_ctrl ctrlEnable false;
		_ctrl ctrlCommit 0;
	} forEach (SIDE_CTRL_IDC + LABEL_CTRL_IDC);
};
if (_selection == 2) then
{
	// "Side" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0;
		if (_x in SIDE_CTRL_IDC) then {_ctrl ctrlEnable true};
		_ctrl ctrlCommit 0;
	} forEach (SIDE_CTRL_IDC + LABEL_CTRL_IDC);
};