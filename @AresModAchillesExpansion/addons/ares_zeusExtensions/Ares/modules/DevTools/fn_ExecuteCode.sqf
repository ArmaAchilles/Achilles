#include "\ares_zeusExtensions\Ares\module_header.hpp"

disableSerialization;

_position = position _logic;
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
_params = [_position,_unitUnderCursor];

if (not (missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true])) exitWith
{
	["This module has been disabled by the mission creator."] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_ExecuteCode_Dialog_Result", -1];
_default_target = uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Constraint', 0];
createDialog "Ares_ExecuteCode_Dialog";
_dialog = findDisplay 123;
_combobox = _dialog displayCtrl 4000;
{_combobox lbAdd _x} forEach ["local","server","global"];
_combobox lbSetCurSel _default_target;
waitUntil { dialog };
waitUntil { !dialog };
_dialogResult = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Result", -1];
if (_dialogResult == 1) then
{
	_params spawn
	{
		_params = _this;
		_target = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Constraint", 0];
		_pastedText = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Text", "[]"];
		try
		{
			switch (_target) do
			{
				case 0: {_params call (compile _pastedText);};
				case 1: {[(compile _pastedText), _params, 2] call Ares_fnc_BroadcastCode;};
				case 2: {[(compile _pastedText), _params, 0] call Ares_fnc_BroadcastCode;};
			};
		}
		catch
		{
			diag_log _exception;
			["Failed to parse code. See RPT for error."] call Ares_fnc_ShowZeusMessage;
		};
	};
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"