////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/19/16
//	VERSION: 3.0
//	FILE: Achilles\functions\fn_ACEInjury.sqf
//  DESCRIPTION: Function for the module ACE Injury
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

#define INJURY_TYPES	["bullet", "grenade", "explosive", "shell", "stab", "vehiclecrash"]
#define HEARTH_RATES	[160, 80, 40, 19]
#define BLOOD_PRESSURES	[100, 70, 40]

private ["_injury_value_list","_selected_units","_value"];

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
private _mode = if (!isNull _unit) then {"single"} else {"multiple"};

if (isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	// ACE Injury System

	//Broadcast set injury function
	if (isNil "Achilles_var_setInjury_init_done") then
	{
		publicVariable "Achilles_fnc_setACEInjury";
		Achilles_var_setInjury_init_done = true;
	};

	private _severity_options = [localize "STR_NONE_INJURY", localize "STR_RANDOM", localize "STR_MODERATE_INJURY", localize "STR_SEVERE"];

	private _dialogResult =
	[
		localize "STR_ACE_INJURY",
		[
			["COMBOBOX", localize "STR_TYPE",[localize "STR_BULLET", localize "STR_GRENADE", localize "STR_EXPLOSIVE", localize "STR_SHRAPNEL", localize "STR_STAB", localize "STR_CRASH"]],
			["COMBOBOX", localize "STR_HEAD",_severity_options],
			["COMBOBOX", localize "STR_TORSO",_severity_options],
			["COMBOBOX", localize "STR_RIGHT_ARM",_severity_options],
			["COMBOBOX", localize "STR_LEFT_ARM",_severity_options],
			["COMBOBOX", localize "STR_RIGHT_LEG",_severity_options],
			["COMBOBOX", localize "STR_LEFT_LEG",_severity_options],
			["SLIDER", localize "STR_PAIN_LEVEL"],
			["COMBOBOX", localize "STR_HEARTH_RATE", [[localize "STR_HIGH", format ["(%1 BPM)", (HEARTH_RATES select 0)]], [localize "STR_NORMAL", format ["(%1 BPM)", (HEARTH_RATES select 1)]], [localize "STR_LOW", format ["(%1 BPM)", (HEARTH_RATES select 2)]], [localize "STR_TOO_LOW", format ["(%1 BPM)", (HEARTH_RATES select 3)]]], 1],
			["COMBOBOX", localize "STR_BLOOD_PRESSURE",[[localize "STR_NORMAL", format ["(%1 systolic)", (BLOOD_PRESSURES select 0)]], [localize "STR_LOW", format ["(%1 systolic)", (BLOOD_PRESSURES select 1)]], [localize "STR_TOO_LOW", format ["(%1 systolic)", (BLOOD_PRESSURES select 2)]]]],
			["COMBOBOX", localize "STR_FORCE_UNCONSIOUSNESS",[localize "STR_FALSE",localize "STR_TRUE"]]
		]
	] call Achilles_fnc_ShowChooseDialog;

	// handle escape dialog
	if (_dialogResult isEqualTo []) exitWith {};

	_injury_value_list = [];

	private _injury_type = INJURY_TYPES select (_dialogResult select 0);
	// get injuries
	for "_i" from 1 to 6 do
	{
		private _index = _dialogResult select _i;
		_value = switch (_index) do
		{
			case 0: {0};
			case 1: {{round (random 2)}};
			case 2: {1};
			case 3: {2};
		};
		_injury_value_list pushBack _value;
	};
	private _pain = 100 * (_dialogResult select 7);
	_injury_value_list pushBack _pain;
	private _hearth_rate = HEARTH_RATES select (_dialogResult select 8);
	_injury_value_list pushBack _hearth_rate;
	private _blood_pressure = BLOOD_PRESSURES select (_dialogResult select 9);
	_injury_value_list pushBack _blood_pressure;
	private _unconscious = if (_dialogResult select 10 == 1) then {true} else {false};
	_injury_value_list pushBack _unconscious;

	if (_mode == "single") then
	{
		[localize "STR_HEALTH_CHANGED"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};

	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};

	{
		_unit = _x;
		if (local _unit) then
		{
			[_unit,_injury_type,_injury_value_list] spawn Achilles_fnc_setACEInjury;
		} else
		{
			[_unit,_injury_type,_injury_value_list] remoteExec ["Achilles_fnc_setACEInjury",_unit];
		};
	} forEach _selected_units;
} else
{
	// Vanilla Injury System

	//Broadcast set injury function
	if (isNil "Achilles_var_setInjury_init_done") then
	{
		publicVariable "Achilles_fnc_setVanillaInjury";
		Achilles_var_setInjury_init_done = true;
	};

	private _severity_options = [[localize "STR_NONE_INJURY", "(0)"], localize "STR_RANDOM", [localize "STR_MODERATE_INJURY", "(0.5)"], [localize "STR_SEVERE", "(0.9)"]];

	private _dialogResult =
	[
		localize "STR_INJURY_WITHOUT_ACE",
		[
			["COMBOBOX", localize "STR_HEAD",_severity_options],
			["COMBOBOX", localize "STR_TORSO",_severity_options],
			["COMBOBOX", localize "STR_ARMS",_severity_options],
			["COMBOBOX", localize "STR_LEGS",_severity_options]
		]
	] call Achilles_fnc_ShowChooseDialog;

	// handle escape dialog
	if (_dialogResult isEqualTo []) exitWith {};

	if (_mode == "single") then
	{
		[localize "STR_HEALTH_CHANGED"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};

	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};
	if (_selected_units isEqualTo []) exitWith {};

	// get dialog results
	_injury_value_list = [];
	{
		_value = switch (_x) do
		{
			case 0: {0};
			case 1: {{selectRandom [0,0.5,0.9]}};
			case 2: {0.5};
			case 3: {0.9};
		};
		_injury_value_list pushBack _value;
	} forEach _dialogResult;

	// get and set hits
	{
		_unit = _x;
		if (local _unit) then
		{
			[_unit,_injury_value_list] spawn Achilles_fnc_setVanillaInjury
		} else
		{
			[_unit,_injury_value_list] remoteExec ["Achilles_fnc_setVanillaInjury", _unit];
		};
	} forEach _selected_units;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
