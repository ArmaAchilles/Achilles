#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;

waitUntil {([player] call Ares_fnc_IsZeus)};
[["Ares", "PlacingModules"]] call BIS_fnc_advHint;

// key event handler for remote controlled unit
_display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", { _this call Ares_fnc_HandleRemoteKeyPressed; }];

while {true} do {
	//["Monitor curator display..."] call Ares_fnc_LogMessage;
	
	// Wait for the player to become zeus again (if they're not - eg. if on dedicated server and logged out)
	waitUntil {([player] call Ares_fnc_IsZeus)};

	//Wait for the curator screen to be displayed
	waitUntil {!isNull (findDisplay IDD_RSCDISPLAYCURATOR)};
	
	_display = findDisplay IDD_RSCDISPLAYCURATOR;
	_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_MODEMODULES;
	//_ctrl ctrlAddEventHandler ["buttonclick", format ["['%1'] spawn Ares_fnc_OnModuleTreeLoad;", _category]];
	// key press variables;
	Ares_Ctrl_Key_Pressed = false;
	Ares_Shift_Key_Pressed = false;
	
	_display displayAddEventHandler ["KeyDown", { _this call Ares_fnc_HandleCuratorKeyPressed; }];
	_display displayAddEventHandler ["KeyUp", { _this call Ares_fnc_HandleCuratorKeyReleased; }];

	[false] call Ares_fnc_OnModuleTreeLoad;

	//Wait for the curator screen to be removed
	waitUntil {isNull (findDisplay IDD_RSCDISPLAYCURATOR)};
};