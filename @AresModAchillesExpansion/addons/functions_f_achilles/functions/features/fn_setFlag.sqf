/*
	Author: CreepPork_LV

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

			(_flags select 1) pushBack ((_eventHandlerInit splitString "'''") select 1); // File path
		};
	};
} forEach ("(str _x find 'Flag') >= 0" configClasses (configFile >> "CfgVehicles"));

diag_log (_flags select 0);
diag_log (_flags select 1);

private _dialogResult =
[
	format [localize "STR_AMAE_SET_FLAG", getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")],
	[
		["COMBOBOX", localize "STR_AMAE_FLAG_SC", _flags select 0, 0, false, [], _flags select 1]
	]
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_vehicle forceFlagTexture "";

_dialogResult params ["_flag"];

// If the flag is not set to None, then add a flag (the flag has been removed already couple lines up)
if (_flag != 0) then
{
	_flag = (_flags select 1) select _flag;

	_vehicle forceFlagTexture _flag;
};
