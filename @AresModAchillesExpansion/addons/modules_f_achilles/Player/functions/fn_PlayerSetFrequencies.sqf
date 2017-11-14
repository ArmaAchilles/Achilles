/*
	Author: CreepPork_LV

	Description:
		Creates a dialog that allows the setting of TFAR frequencies for radios.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

if (!isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {[localize "STR_TFAR_HAS_TO_BE_LOADED"] call Achilles_fnc_ShowZeusErrorMessage};

if(isNil "Achilles_var_set_frequency_init_done") then
{
	publicVariable "Achilles_fnc_setSRFrequencies";
	publicVariable "Achilles_fnc_setLRFrequencies";
	Achilles_var_set_frequency_init_done = true;
};

private _firstDialogResult =
[
	localize "STR_SELECT_RADIOS",
	[
		[localize "STR_SET_SR_RADIO_FREQ", [localize "STR_YES", localize "STR_NO"]],
		[localize "STR_SET_LR_RADIO_FREQ", [localize "STR_YES", localize "STR_NO"], 1]
	]
] call Ares_fnc_ShowChooseDialog;

if (_firstDialogResult isEqualTo []) exitWith {};

private _setSR = _firstDialogResult select 0;
private _setLR = _firstDialogResult select 1;

private _channelsSR = [1, 2, 3, 4, 5, 6, 7, 8];
private _channelsLR = [1, 2, 3, 4, 5, 6, 7, 8, 9];

private _secondDialogResult = [];
private _thirdDialogResult = [];

private _entriesForSR = [];
{
	_entriesForSR pushBack [format [localize "STR_CHANNEL_X_FREQ", _x], "", Achilles_var_setRadioFrequenciesSR_Default];
} forEach _channelsSR;

private _entriesForLR = [];
{
	_entriesForLR pushBack [format [localize "STR_CHANNEL_X_FREQ", _x], "", Achilles_var_setRadioFrequenciesLR_Default];
} forEach _channelsLR;

// Set only SR radio frequencies
if (_setSR == 0 && _setLR == 1) then
{
	_secondDialogResult =
	[
		localize "STR_SET_SR_FREQ",
		_entriesForSR
	] call Ares_fnc_ShowChooseDialog;

	if (_secondDialogResult isEqualTo []) exitWith {};

	{
		[_forEachIndex + 1, _x] remoteExecCall ["Achilles_fnc_setSRFrequencies", 0];
	} forEach _secondDialogResult;
};

// Set only LR radio frequencies
if (_setSR == 1 && _setLR == 0) then
{
	_secondDialogResult =
	[
		localize "STR_SET_LR_FREQ",
		_entriesForLR
	] call Ares_fnc_ShowChooseDialog;

	if (_secondDialogResult isEqualTo []) exitWith {};

	{
		[_forEachIndex + 1, _x] remoteExecCall ["Achilles_fnc_setLRFrequencies", 0];
	} forEach _secondDialogResult;
};

// Set frequencies for both radio types
if (_setSR == 0 && _setLR == 0) then
{
	// Set SR frequencies
	_secondDialogResult =
	[
		localize "STR_SET_SR_FREQ",
		_entriesForSR
	] call Ares_fnc_ShowChooseDialog;

	if (_secondDialogResult isEqualTo []) exitWith {};

	{
		[_forEachIndex + 1, _x] remoteExecCall ["Achilles_fnc_setSRFrequencies", 0];
	} forEach _secondDialogResult;

	// Set LR frequencies
	_thirdDialogResult =
	[
		localize "STR_SET_LR_FREQ",
		_entriesForLR
	] call Ares_fnc_ShowChooseDialog;

	if (_thirdDialogResult isEqualTo []) exitWith {};

	{
		[_forEachIndex + 1, _x] remoteExecCall ["Achilles_fnc_setLRFrequencies", 0];
	} forEach _thirdDialogResult;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
