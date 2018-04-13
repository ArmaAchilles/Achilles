/*
	Author: CreepPork_LV, modified by Kex

	Description:
		Sets a vehicle flag.

	Parameters:
		_this select 0: OBJECT - Vehicle the flag should be applied to.

	Returns:
		Nothing
*/

params ["_vehicle"];

private _flags = [[], []]; // [["Flag Display Name"], ["Flag File Path"]]

(_flags select 0) pushBack (localize "STR_AMAE_NO_FLAG");
(_flags select 1) pushBack "";

{
	private _displayName = getText (_x >> "displayName");
	if (_displayName != "") then
	{
		private _eventHandlerInit = getText (_x >> "EventHandlers" >> "init");
		if (_eventHandlerInit != "") then
		{
			(_flags select 0) pushBack _displayName; // Display Name

			(_flags select 1) pushBack toLower ((_eventHandlerInit splitString "'''") select 1); // File path
		};
	};
} forEach ("(str _x find 'Flag') >= 0" configClasses (configFile >> "CfgVehicles"));

private _defaultIdx = (_flags select 1) find (["\", getForcedFlagTexture _vehicle] joinString "");
if (_defaultIdx isEqualTo -1) then {_defaultIdx = 0};

private _controls = [];
_controls pushBack ["COMBOBOX", localize "STR_AMAE_FLAG_SC", _flags select 0, _defaultIdx, true, [], _flags select 1];
if (isClass (configfile >> "CfgVehicles" >> typeOf _vehicle >> "PlateInfos")) then
{
	_controls pushBack ["TEXT", localize "STR_AMAE_NUMBER_PLATE", [], getPlateNumber _vehicle, true];
};
private _dialogResult =
[
	format [localize "STR_AMAE_CHANGE_ACCESSORIES_FOR_X", getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")],
	_controls
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_flag", ["_plateText", -1, ["",0]]];
_flag = (_flags select 1) select _flag;

// get all selected units of the same kind
private _mode = if (_vehicle isKindOf "Man") then {"man"} else {"vehicle"};
private _curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
{
	_x forceFlagTexture "";
	// If the flag is not set to None, then add a flag (the flag has already been removed)
	if !(_flag isEqualTo "") then
	{
		_x forceFlagTexture _flag;
	};
	// set the plate number if the vehicle has one
	if !(_plateText isEqualTo -1) then
	{
		if (local _x) then
		{
			_x setPlateNumber _plateText;
		}
		else
		{
			[_x, _plateText] remoteExecCall ["setPlateNumber", _x];
		};
	};
} forEach _curatorSelected;
