////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/3/16
//	VERSION: 1.0
//	FILE: achilles\modules_f_ares\Equipment\functions\fn_EquipmentFlashlightIRLaserOnOff.sqf
//  DESCRIPTION: Module for forcing units to use tactical light / IR laser pointer
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_units","_taclight","_IR"];
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _unitUnderCursor) then
{
	// select players
	private _dialogResult = [
		localize "STR_AMAE_TOGGLE_TACLIGHT_IR",
		[
			[localize "STR_AMAE_MODE",[localize "STR_AMAE_ALL",localize "STR_AMAE_SELECTION",localize "STR_AMAE_SIDE"]],
			[localize "STR_AMAE_SIDE","SIDE"],
			[localize "STR_AMAE_TAC_LIGHT",[localize "STR_AMAE_AUTOMATIC",localize "STR_AMAE_FORCED_ON",localize "STR_AMAE_FORCED_OFF"]],
			[localize "STR_AMAE_IR_LASER_POINTER",[localize "STR_AMAE_FORCED_OFF",localize "STR_AMAE_FORCED_ON"]]
		],
		"Achilles_fnc_RscDisplayAttributes_selectAIUnits"
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	_units = switch (_dialogResult select 0) do
	{
		case 0:
		{
			allUnits select {alive _x};
		};
		case 1:
		{
			private _selection = [toLower localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_selection select {alive _x};
		};
		case 2:
		{
			private _side_index = _dialogResult select 1;
			private _side = [east,west,independent,civilian] select (_side_index - 1);
			allUnits select {(alive _x) and (side _x == _side)};
		};
	};

	if (isNil "_units") exitWith {};
	if (_units isEqualTo []) exitWith {	[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage };
	_taclight = ["AUTO","forceOn","forceOff"] select (_dialogResult select 2);
	_IR = [false,true] select (_dialogResult select 3);
}
else
{
	private _dialogResult =
	[
		localize "STR_AMAE_TOGGLE_TACLIGHT_IR",
		[
			[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_ENTIRE_GROUP", localize "STR_AMAE_SELECTED_PLAYER"]],
			[localize "STR_AMAE_TAC_LIGHT",[localize "STR_AMAE_AUTOMATIC",localize "STR_AMAE_FORCED_ON",localize "STR_AMAE_FORCED_OFF"]],
			[localize "STR_AMAE_IR_LASER_POINTER",[localize "STR_AMAE_FORCED_OFF",localize "STR_AMAE_FORCED_ON"]]
		]
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	_units = [units (group _unitUnderCursor), [_unitUnderCursor]] select (_dialogResult select 0);

	_taclight = ["AUTO","forceOn","forceOff"] select (_dialogResult select 1);
	_IR = [false,true] select (_dialogResult select 2);
};

if (isNil "_units") exitWith {};

{
	private _unit = _x;
	if (local _unit) then
	{
		_unit enableGunLights _taclight;
		_unit enableIRLasers _IR;
	} else
	{
		[_unit, _taclight] remoteExecCall ["enableGunLights", _unit];
		[_unit, _IR] remoteExecCall ["enableIRLasers", _unit];
	};
} forEach _units;

[localize "STR_AMAE_APPLIED_MODULE_TO_X_UNITS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
