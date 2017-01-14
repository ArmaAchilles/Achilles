////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: S.Crowe
//	DATE: 7/12/16
//	VERSION: 2.0
//	FILE: Achilles\functions\fn_ACEHeal.sqf
//  DESCRIPTION: Function for the module ACE Heal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_injury","_selected_units"];

_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_mode = if (!isNull _unit) then {"single"} else {"multiple"};

_options = [localize "STR_RANDOM",localize "STR_NONE_INJURY",localize "STR_LIGHT_INJURY", localize "STR_SEVERE"];

if (isClass (configfile >> "CfgPatches" >> "ace_main")) then
{
	if (_mode == "single") then
	{
		["Healed"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};
	
	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};
	if (count _selected_units == 0) exitWith {};
	
	{
		[_x, _x] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
	} forEach _selected_units;
} else
{
	
	if (_mode == "single") then
	{
		["Headled"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};
	
	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};
	if (count _selected_units == 0) exitWith {};

	// Vanilla Injury System
	{
		_x setHitPointDamage ["hitHead", 0];
		_x setHitPointDamage ["hitBody", 0];
		_x setHitPointDamage ["hitHands", 0];
		_x setHitPointDamage ["hitLegs", 0];
		_x setDamage 0;
	} forEach _selected_units;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
