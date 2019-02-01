////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: S.Crowe
//	DATE: 7/12/16
//	VERSION: 2.0
//	FILE: Achilles\functions\fn_ACEHeal.sqf
//  DESCRIPTION: Function for the module ACE Heal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.inc.sqf"

#include "\a3\functions_f_mp_mark\revive\defines.inc"

private ["_injury","_selected_units"];

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

private _isSingleSelection = !isNull _unit;

// ACE Medical System
if (isClass (configfile >> "CfgPatches" >> "ace_medical")) exitWith
{
	if (_isSingleSelection) then
	{
		["Healed"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
	};

	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};
	if (_selected_units isEqualTo []) exitWith {};

	{
		if (local _x) then
		{
			[_x, _x] call ace_medical_fnc_treatmentAdvanced_fullHealLocal
		} else
		{
			[_x, _x] remoteExec ["ace_medical_fnc_treatmentAdvanced_fullHealLocal", _x]
		};
	} forEach _selected_units;
};


// Farooq's Revive System
if (!isNil "FAR_ReviveMode") exitWith
{
	if (_isSingleSelection) then
	{
		_selected_units = [_unit];
	} else
	{
		_selected_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
	};

	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};
	if (_selected_units isEqualTo []) exitWith {};

	// check if any unit is unconscious
	if ({  _x getVariable ["FAR_isUnconscious", 0] == 1 } count _selected_units > 0) then
	{
		[localize "STR_AMAE_REVIVE_FEW_SECONDS"] call Ares_fnc_ShowZeusMessage;
	} else
	{
		["Healed"] call Ares_fnc_ShowZeusMessage;
	};

	{
		if (_x getVariable ["FAR_isUnconscious", 0] == 1) then
		{
			_x setVariable ["FAR_isUnconscious", 0, true];
			_x setVariable ["FAR_isDragged", 0, true];
		} else
		{
			_x setDamage 0;
		};
	} forEach _selected_units;
};

// Vanilla Injury System

if (_isSingleSelection) then
{
	["Healed"] call Ares_fnc_ShowZeusMessage;
	_selected_units = [_unit];
} else
{
	_selected_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
};

// handle the case the selection was cancled
if (isNil "_selected_units") exitWith {};
if (_selected_units isEqualTo []) exitWith {};

{
	if (REVIVE_ENABLED(_x) && {lifeState _x == "INCAPACITATED"} && {IS_DISABLED(_x)}) then
	{
		SET_STATE(_x, STATE_REVIVED);
	} else
	{
		_x setDamage 0;
	};
} forEach _selected_units;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
