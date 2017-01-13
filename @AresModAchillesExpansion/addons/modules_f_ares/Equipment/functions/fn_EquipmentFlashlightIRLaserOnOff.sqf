////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/3/16
//	VERSION: 1.0
//	FILE: achilles\modules_f_ares\Equipment\functions\fn_EquipmentFlashlightIRLaserOnOff.sqf
//  DESCRIPTION: Module for forcing units to use tactical light / IR laser pointer
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_units","_taclight","_IR"];
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _unitUnderCursor) then
{
	// select players
	_dialogResult = [
		localize "STR_TACLIGHT_IR_ON_OFF",
		[ 
			[localize "STR_MODE",[localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE"]],
			[localize "STR_SIDE","SIDE"],
			[localize "STR_TAC_LIGHT",[localize "STR_AUTOMATIC",localize "STR_FORCED_ON",localize "STR_FORCED_OFF"]],
			[localize "STR_IR_LASER_POINTER",[localize "STR_FORCED_OFF",localize "STR_FORCED_ON"]]
		],
		"Achilles_fnc_RscDisplayAttributes_selectAIUnits"
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult == 0) exitWith {};
	
	_units = switch (_dialogResult select 0) do
	{
		case 0:
		{
			allUnits select {alive _x};
		};
		case 1: 
		{
			_selection = [toLower localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_selection select {alive _x};
		};
		case 2: 
		{
			_side_index = _dialogResult select 1;
			_side = [east,west,independent,civilian] select (_side_index - 1);
			allUnits select {(alive _x) and (side _x == _side)};
		};
	};

	if (count _units == 0) exitWith 
	{
		[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; 
		playSound "FD_Start_F";
	};
	_taclight = ["AUTO","forceOn","forceOff"] select (_dialogResult select 2);
	_IR = [false,true] select (_dialogResult select 3);
}
else
{
	_dialogResult = 
	[
		localize "STR_TACLIGHT_IR_ON_OFF",
		[
			[localize "STR_SELECTION", [localize "STR_ENTIRE_GROUP", localize "STR_SELECTED_PLAYER"]],
			[localize "STR_TAC_LIGHT",[localize "STR_AUTOMATIC",localize "STR_FORCED_ON",localize "STR_FORCED_OFF"]],
			[localize "STR_IR_LASER_POINTER",[localize "STR_FORCED_OFF",localize "STR_FORCED_ON"]]
		]
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult == 0) exitWith {};
	
		switch (_dialogResult select 0) do
		{
			case 0:
			{
				_units = units (group _unitUnderCursor);
			};
			case 1:
			{
				_units = [_unitUnderCursor];
			};
		};

		_taclight = ["AUTO","forceOn","forceOff"] select (_dialogResult select 1);
	_IR = [false,true] select (_dialogResult select 2);
};

if (isNil "_units") exitWith {};

{
	_unit = _x;
	if (local _unit) then
	{
		_unit enableGunLights _taclight;
		_unit enableIRLasers _IR;
	} else
	{
		[[_unit,_taclight,_IR],
		{
			params ["_unit","_taclight","_IR"];
			_unit enableGunLights _taclight;
			_unit enableIRLasers _IR;			
		}] remoteExec ["spawn",_unit];
	};
} forEach _units;

[localize "STR_APPLIED_MODULE_TO_X_UNITS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"

