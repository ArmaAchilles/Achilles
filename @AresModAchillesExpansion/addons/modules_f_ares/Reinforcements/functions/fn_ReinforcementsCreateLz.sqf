#include "\achilles\modules_f_ares\module_header.hpp"

if (isNil "Ares_ReinforcementLzCount") then
{
	Ares_ReinforcementLzCount = 0;
};

_deleteModuleOnExit = false;

_targetPhoneticName = [Ares_ReinforcementLzCount] call Ares_fnc_GetPhoneticName;
_target_name = format ["LZ %1", _targetPhoneticName];
_dialogResult = 
[
	localize "STR_CREATE_NEW_LZ",
	[
		[localize "STR_NAME", "", _target_name]
	]
] call Ares_fnc_showChooseDialog;
if (count _dialogResult == 0) exitWith {_deleteModuleOnExit = true};
_logic setName (_dialogResult select 0);
_logic setVariable ["SortOrder", Ares_ReinforcementLzCount];
[objNull, format ["Created LZ '%1'", _targetPhoneticName]] call bis_fnc_showCuratorFeedbackMessage;
Ares_ReinforcementLzCount = Ares_ReinforcementLzCount + 1;
publicVariable "Ares_ReinforcementLzCount";

// create a LZ object for AI
_h_pad = "Land_HelipadEmpty_F" createVehicle position _logic;
_h_pad attachTo [_logic,[0,0,0]];
[_logic, _h_pad] spawn {waitUntil {sleep 10; isNull (_this select 0)}; deleteVehicle (_this select 1);};

#include "\achilles\modules_f_ares\module_footer.hpp"
