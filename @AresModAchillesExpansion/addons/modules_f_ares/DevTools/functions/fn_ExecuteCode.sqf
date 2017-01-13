#include "\achilles\modules_f_ares\module_header.hpp"

disableSerialization;

_position = position _logic;
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
_params = [_position,_unitUnderCursor];

// mission designer can disallow usage of execute code module, but it will still be available for logged-in admins
if (not (missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true]) and not (serverCommandAvailable "#kick")) exitWith
{
	["This module has been disabled by the mission creator."] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_ExecuteCode_Dialog_Result", -1];
_default_target = uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Constraint', 0];
createDialog "Ares_ExecuteCode_Dialog";
_dialog = findDisplay 123;
_combobox = _dialog displayCtrl 4000;
{_combobox lbAdd _x} forEach ["local","server","global","global & JIP"];
_combobox lbSetCurSel _default_target;
waitUntil { dialog };
waitUntil { !dialog };
_dialogResult = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Result", -1];

if (_dialogResult == 1) then
{

	_target = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Constraint", 0];
	_pastedText = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Text", "[]"];

	switch (_target) do
	{
		case 0: {_params spawn (compile _pastedText);};
		case 1: {[_params, compile _pastedText] remoteExec ["spawn",2];};
		case 2: {[_params, compile _pastedText] remoteExec ["spawn",0];};
		case 3: 
		{
			_JIP_id = [_params, compile _pastedText] remoteExec ["spawn",0,_logic];
			_logic setName format ["Execute Code: JIP queue %1", _JIP_id];
			_deleteModuleOnExit = false;
		};
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"