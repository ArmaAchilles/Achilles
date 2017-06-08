////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/3/16
//	VERSION: 1.0
//	FILE: achilles\modules_f_ares\Equipment\functions\fn_EquipmentNVDRailAttachment.sqf
//  DESCRIPTION: Module for changing unit equipment (NVD and weapon accessoires)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_units","_NVD","_TacLight_IR"];
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _unitUnderCursor) then
{
	// select players
	_dialogResult = [
		localize "STR_NVD_TACLIGHT_IR",
		[ 
			[localize "STR_MODE",[localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE"]],
			[localize "STR_SIDE","SIDE"],
			[localize "STR_NVD",[localize "STR_UNCHANGED",localize "STR_NVD",localize "STR_THERMALS",localize "STR_NONE_EQUIPMENT"]],
			[localize "STR_TACLIGHT_IR",[localize "STR_UNCHANGED",localize "STR_NONE_EQUIPMENT",localize "STR_TAC_LIGHT",localize "STR_IR_LASER_POINTER"]]
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
	
	if (isNil "_units") exitWith {};
	if (count _units == 0) exitWith 
	{
		[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; 
		playSound "FD_Start_F";
	};
	_NVD = _dialogResult select 2;
	_TacLight_IR = _dialogResult select 3;
}
else
{
	_dialogResult = 
	[
		localize "STR_NVD_TACLIGHT_IR",
		[
			[localize "STR_SELECTION", [localize "STR_ENTIRE_GROUP", localize "STR_SELECTED_PLAYER"]],
			[localize "STR_NVD",[localize "STR_UNCHANGED",localize "STR_NVD",localize "STR_THERMALS",localize "STR_NONE_EQUIPMENT"]],
			[localize "STR_TACLIGHT_IR",[localize "STR_UNCHANGED",localize "STR_NONE_EQUIPMENT",localize "STR_TAC_LIGHT",localize "STR_IR_LASER_POINTER"]]
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

		_NVD = _dialogResult select 1;
		_TacLight_IR = _dialogResult select 2;
};

if (isNil "_units") exitWith {};
{
	[
		[_x,_NVD,_TacLight_IR],
		{
			_unit = _this select 0;
			_NVD = _this select 1;
			_TacLight_IR = _this select 2;
			if (_NVD > 0) then
			{
				switch (_NVD) do
				{
					case 1:
					{
						_unit linkItem "NVGoggles";
					};
					case 2:
					{
						_unit linkItem "NVGogglesB_blk_F";
					};
					case 3:
					{
						{
							_unit unassignItem _x;
							_unit removeItem _x;
						} forEach ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP","O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","NVGoggles_tna_F"];
					};
				};
			};
			if (_TacLight_IR > 0) then
			{
				switch (_TacLight_IR) do 
				{
					case 1:
					{
						_unit removePrimaryWeaponItem "acc_flashlight";
						_unit removePrimaryWeaponItem "acc_pointer_IR";
					};
					case 2:
					{
						_unit removePrimaryWeaponItem "acc_pointer_IR";
						_unit addPrimaryWeaponItem "acc_flashlight";
					};
					case 3:
					{
						_unit removePrimaryWeaponItem "acc_flashlight";
						_unit addPrimaryWeaponItem "acc_pointer_IR";
					};
				};
			};
		}	
	] remoteExec ["spawn",_x];
} forEach _units;

[localize "STR_APPLIED_MODULE_TO_X_UNITS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"

