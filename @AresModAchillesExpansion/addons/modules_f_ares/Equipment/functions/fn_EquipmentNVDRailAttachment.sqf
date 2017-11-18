////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/3/16
//	VERSION: 1.0
//	FILE: achilles\modules_f_ares\Equipment\functions\fn_EquipmentNVDRailAttachment.sqf
//  DESCRIPTION: Module for changing unit equipment (NVD and weapon accessoires)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_units","_NVD","_TacLight_IR"];
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _unitUnderCursor) then
{
	// select players
	private _dialogResult = [
		localize "STR_NVD_TACLIGHT_IR",
		[
			[localize "STR_MODE",[localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE"]],
			[localize "STR_SIDE","SIDE"],
			[localize "STR_NVD",[localize "STR_UNCHANGED",localize "STR_NVD",localize "STR_THERMALS",localize "STR_NONE_EQUIPMENT"]],
			[localize "STR_TACLIGHT_IR",[localize "STR_UNCHANGED",localize "STR_NONE_EQUIPMENT",localize "STR_TAC_LIGHT",localize "STR_IR_LASER_POINTER"]]
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
			private _selection = [toLower localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
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
	if (_units isEqualTo []) exitWith { [localize "STR_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage };
	_NVD = _dialogResult select 2;
	_TacLight_IR = _dialogResult select 3;
}
else
{
	private _dialogResult =
	[
		localize "STR_NVD_TACLIGHT_IR",
		[
			[localize "STR_SELECTION", [localize "STR_ENTIRE_GROUP", localize "STR_SELECTED_PLAYER"]],
			[localize "STR_NVD",[localize "STR_UNCHANGED",localize "STR_NVD",localize "STR_THERMALS",localize "STR_NONE_EQUIPMENT"]],
			[localize "STR_TACLIGHT_IR",[localize "STR_UNCHANGED",localize "STR_NONE_EQUIPMENT",localize "STR_TAC_LIGHT",localize "STR_IR_LASER_POINTER"]]
		]
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

    _units = [units (group _unitUnderCursor), [_unitUnderCursor]] select (_dialogResult select 0);

	_NVD = _dialogResult select 1;
	_TacLight_IR = _dialogResult select 2;
};

if (isNil "_units") exitWith {};
{
	private _unit = _x;

	if (_NVD > 0) then
	{
		switch (_NVD) do
		{
			case 1:
			{
				[[_unit, "NVGoggles"] remoteExecCall ["linkItem", _unit], _unit linkItem "NVGoggles"] select (local _unit);
			};
			case 2:
			{
                [[_unit, "NVGogglesB_blk_F"] remoteExecCall ["linkItem", _unit], _unit linkItem "NVGogglesB_blk_F"] select (local _unit);
			};
			case 3:
			{
				if (local _unit) then
				{
					{
						_unit unassignItem _x;
						_unit removeItem _x;
					} forEach ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP","O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","NVGoggles_tna_F"];
				} else
				{
					{
						[_unit, _x] remoteExecCall ["unassignItem", _unit];
						[_unit, _x] remoteExecCall ["removeItem", _unit];
					} forEach ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP","O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","NVGoggles_tna_F"];
				};
			};
		};
	};
	if (_TacLight_IR > 0) then
	{
		switch (_TacLight_IR) do
		{
			case 1:
			{
				if (local _unit) then
				{
					_unit removePrimaryWeaponItem "acc_flashlight";
					_unit removePrimaryWeaponItem "acc_pointer_IR";
				} else
				{
					[_unit, "acc_flashlight"] remoteExecCall ["removePrimaryWeaponItem", _unit];
					[_unit, "acc_pointer_IR"] remoteExecCall ["removePrimaryWeaponItem", _unit];
				};
			};
			case 2:
			{
				if (local _unit) then
				{
					_unit removePrimaryWeaponItem "acc_pointer_IR";
					_unit addPrimaryWeaponItem "acc_flashlight";
				} else
				{
					[_unit, "acc_pointer_IR"] remoteExecCall ["removePrimaryWeaponItem", _unit];
					[_unit, "acc_flashlight"] remoteExecCall ["addPrimaryWeaponItem", _unit];
				};
			};
			case 3:
			{
				if (local _unit) then
				{
					_unit removePrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "acc_pointer_IR";
				} else
				{
					[_unit, "acc_flashlight"] remoteExecCall ["removePrimaryWeaponItem", _unit];
					[_unit, "acc_pointer_IR"] remoteExecCall ["addPrimaryWeaponItem", _unit];
				};
			};
		};
	};
} forEach _units;

[localize "STR_APPLIED_MODULE_TO_X_UNITS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
