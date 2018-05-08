#include "\achilles\modules_f_ares\module_header.hpp"

disableSerialization;

private _position = position _logic;
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
private _params = [_position,_unitUnderCursor];

// mission designer can disallow usage of execute code module, but it will still be available for logged-in admins
if (!(missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true]) and ((call BIS_fnc_admin) == 0)) exitWith
{
	[localize "STR_AMAE_CODE_EXECUTION_NOT_ALLOWED"] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_ExecuteCode_Dialog_Result", -1];
private _default_target = uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Constraint', 0];
createDialog "Ares_ExecuteCode_Dialog";
private _dialog = findDisplay 123;
private _combobox = _dialog displayCtrl 4000;
{_combobox lbAdd _x} forEach ["local","server","global","global & JIP"];
_combobox lbSetCurSel _default_target;
waitUntil { dialog };
waitUntil { !dialog };
private _dialogResult = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Result", -1];

if (_dialogResult == 1) then
{

	private _target = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Constraint", 0];
	private _pastedText = profileNamespace getVariable ["Ares_ExecuteCode_Dialog_Text", "[]"];
	// check for server-side blacklist if not admin
	if ((call BIS_fnc_admin) == 0) then
	{
		private _isExecutionGranted = [missionNamespace, "Achilles_fnc_checkCodeBasedOnBlackList", {[]}] call BIS_fnc_getServerVariable;
		private _blacklistedEntries = _pastedText call _isExecutionGranted;
		if !(_blacklistedEntries isEqualTo []) then
		{
			[format [localize "STR_AMAE_THIS_SERVER_DOES_NOT_ALLOW_YOU_TO_USE_X", _blacklistedEntries select 0]] call Achilles_fnc_showZeusErrorMessage;
			breakTo MAIN_SCOPE_NAME;
		};
	};

	switch (_target) do
	{
		case 0: {_params spawn (compile _pastedText);};
		case 1: {[_params, compile _pastedText, 2] call Achilles_fnc_spawn; };
		case 2: {[_params, compile _pastedText, 0] call Achilles_fnc_spawn; };
		case 3:
		{
			_dummyObject = [_logic] call Achilles_fnc_createDummyLogic;
			private _JIP_id = [_params, compile _pastedText, 0, _dummyObject] call Achilles_fnc_spawn;
			_logic setName format ["Execute Code: JIP queue %1", _JIP_id];
			_deleteModuleOnExit = false;
		};
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
