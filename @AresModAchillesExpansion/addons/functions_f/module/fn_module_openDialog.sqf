/*
	Function:
		Achilles_fnc_module_openDialog
	
	Authors:
		Kex
	
	Description:
		Opens a scripted module dialog
		The local variable _logic must be defined in the caller scope!
	
	Parameters:
		none
	
	Returns:
		none
	
	Exampes:
		(begin example)
		(end)
*/


private _dialog = findDisplay ACHILLES_IDD_SHOW_CHOOSE;
_dialog setVariable ["logic", _logic];
private _buttonOk = _dialog displayCtrl ACHILLES_IDC_BUTTON_OK;
_buttonOk ctrlAddEventHandler ["ButtonClick",
{
	params ["_ctrl"];
	private _dialog = ctrlParent _ctrl;
	private _logic = _dialog getVariable ["logic", objNull];
	private _handle = _dialog getVariable ["handle", {}];
	private _return = _dialog getVariable ["return", []];
	["confirmed", [_logic, true, true, _return]] call _handle;
	closeDialog 1;
}];
private _buttonCancel = _dialog displayCtrl ACHILLES_IDC_BUTTON_CANCEL;
_buttonCancel ctrlAddEventHandler ["ButtonClick",
{
	params ["_ctrl"];
	private _dialog = ctrlParent _ctrl;
	private _logic = _dialog getVariable ["logic", objNull];
	private _handle = _dialog getVariable ["handle", {}];
	["canceled", [_logic, true, true, []]] call _handle;
}];
