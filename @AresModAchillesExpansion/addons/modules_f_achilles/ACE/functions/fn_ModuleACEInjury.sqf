////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/19/16
//	VERSION: 3.0
//	FILE: Achilles\functions\fn_ACEInjury.sqf
//  DESCRIPTION: Function for the module ACE Injury
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.inc.sqf"

#define INJURY_TYPES	["bullet", "grenade", "explosive", "shell", "stab", "vehiclecrash"]
#define HEARTH_RATES	[160, 80, 40, 19]
#define BLOOD_PRESSURES	[100, 70, 40]

private ["_injury_value_list","_selected_units","_value"];

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
private _mode = ["multiple", "single"] select (!isNull _unit);

if (isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	// ACE Injury System

	//Broadcast set injury function
	if (isNil "Achilles_var_setInjury_init_done") then
	{
		publicVariable "Achilles_fnc_setACEInjury";
		Achilles_var_setInjury_init_done = true;
	};

	private _severity_options = [localize "STR_AMAE_NONE_INJURY", localize "STR_AMAE_RANDOM", localize "STR_AMAE_MODERATE_INJURY", localize "STR_AMAE_SEVERE_INJURY"];

	private _dialogResult =
	[
		localize "STR_AMAE_ACE_INJURY",
		[
			["COMBOBOX", localize "STR_AMAE_TYPE",[localize "STR_AMAE_BULLET", localize "STR_AMAE_GRENADE", localize "STR_AMAE_EXPLOSIVE", localize "STR_AMAE_SHRAPNEL", localize "STR_AMAE_STAB", localize "STR_AMAE_CRASH"]],
			["COMBOBOX", localize "STR_AMAE_HEAD",_severity_options],
			["COMBOBOX", localize "STR_AMAE_TORSO",_severity_options],
			["COMBOBOX", localize "STR_AMAE_RIGHT_ARM",_severity_options],
			["COMBOBOX", localize "STR_AMAE_LEFT_ARM",_severity_options],
			["COMBOBOX", localize "STR_AMAE_RIGHT_LEG",_severity_options],
			["COMBOBOX", localize "STR_AMAE_LEFT_LEG",_severity_options],
			["SLIDER", localize "STR_AMAE_PAIN_LEVEL"],
			["COMBOBOX", localize "STR_AMAE_HEARTH_RATE", [[localize "STR_AMAE_HIGH", format ["(%1 BPM)", (HEARTH_RATES select 0)]], [localize "STR_AMAE_NORMAL", format ["(%1 BPM)", (HEARTH_RATES select 1)]], [localize "STR_AMAE_LOW", format ["(%1 BPM)", (HEARTH_RATES select 2)]], [localize "STR_AMAE_TOO_LOW", format ["(%1 BPM)", (HEARTH_RATES select 3)]]], 1],
			["COMBOBOX", localize "STR_AMAE_BLOOD_PRESSURE",[[localize "STR_AMAE_NORMAL", format ["(%1 systolic)", (BLOOD_PRESSURES select 0)]], [localize "STR_AMAE_LOW", format ["(%1 systolic)", (BLOOD_PRESSURES select 1)]], [localize "STR_AMAE_TOO_LOW", format ["(%1 systolic)", (BLOOD_PRESSURES select 2)]]]],
			["COMBOBOX", localize "STR_AMAE_FORCE_UNCONSIOUSNESS",[localize "STR_AMAE_NO",localize "STR_AMAE_YES"]]
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
		[localize "STR_AMAE_HEALTH_CHANGED"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};

	// handle the case the selection was cancled
	if (isNil "_selected_units") exitWith {};

	{
		_unit = _x;
        if (local _unit) then {
			[_unit,_injury_type,_injury_value_list] spawn Achilles_fnc_setACEInjury;
		} else
		{
			[_unit,_injury_type,_injury_value_list] remoteExec ["Achilles_fnc_setACEInjury",_unit]
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

	private _severity_options = [[localize "STR_AMAE_NONE_INJURY", "(0)"], localize "STR_AMAE_RANDOM", [localize "STR_AMAE_MODERATE_INJURY", "(0.5)"], [localize "STR_AMAE_SEVERE_INJURY", "(0.9)"]];

	private _dialogResult =
	[
		localize "STR_AMAE_INJURY_WITHOUT_ACE",
		[
			["COMBOBOX", localize "STR_AMAE_HEAD",_severity_options],
			["COMBOBOX", localize "STR_AMAE_TORSO",_severity_options],
			["COMBOBOX", localize "STR_AMAE_ARMS",_severity_options],
			["COMBOBOX", localize "STR_AMAE_LEGS",_severity_options]
		]
	] call Achilles_fnc_ShowChooseDialog;

	// handle escape dialog
	if (_dialogResult isEqualTo []) exitWith {};

	if (_mode == "single") then
	{
		[localize "STR_AMAE_HEALTH_CHANGED"] call Ares_fnc_ShowZeusMessage;
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
			[_unit,_injury_value_list] remoteExec ["Achilles_fnc_setVanillaInjury", _unit]
		};
	} forEach _selected_units;
};

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
