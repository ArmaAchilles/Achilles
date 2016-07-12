////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/26/16
//	VERSION: 2.0
//	FILE: Achilles\functions\fn_ACEInjury.sqf
//  DESCRIPTION: Function for the module ACE Injury
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\ares_zeusExtensions\Ares\module_header.hpp"

private ["_injury","_selected_units"];

_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_mode = if (!isNull _unit) then {"single"} else {"multiple"};

_options = [localize "STR_RANDOM",localize "STR_NONE_INJURY",localize "STR_LIGHT_INJURY", localize "STR_SEVERE"];

if (isClass (configfile >> "CfgPatches" >> "ace_main")) then
{
	// ACE Injury System
	_dialogResult =
	[
		localize "STR_ACE_INJURY",
		[
			[localize "STR_HEAD",_options],
			[localize "STR_TORSO",_options],
			[localize "STR_RIGHT_ARM",_options],
			[localize "STR_LEFT_ARM",_options],
			[localize "STR_RIGHT_LEG",_options],
			[localize "STR_LEFT_LEG",_options],
			[localize "STR_UNCONSIOUS_",[localize "STR_TRUE",localize "STR_False"]]
		]
	] call Ares_fnc_ShowChooseDialog;

	// handle escape dialog
	if (count _dialogResult == 0) exitWith {};

	_injury = [];

	// get critical injuries
	for "_i" from 0 to 1 step 1 do
	{
		_index = _dialogResult select _i;
		_injury_val = switch (_index) do
		{
			case 0: {round (random [0,1,2]) / 7};
			case 1: {0};
			case 2: {0.15};
			case 3: {0.3};
		};
		_injury pushBack _injury_val;
	};
	// get limb injuries
	for "_i" from 2 to 5 step 1 do
	{
		_index = _dialogResult select _i;
		_injury_val = switch (_index) do
		{
			case 0: {round (random [0,1.5,2]) / 2};
			case 1: {0};
			case 2: {0.5};
			case 3: {1};
		};
		_injury pushBack _injury_val;
	};

	// get unconscious boolean
	_injury pushBack (if (_dialogResult select 6 == 0) then {true} else {false});

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
		[_x,_injury] spawn
		{
			_unit = _this select 0;
			_injury = _this select 1;
			{
				_hit = _injury select _forEachIndex;
				[_unit, _hit, _x, "bullet"] call ace_medical_fnc_addDamageToUnit;
				sleep 0.1;
			} forEach ["head", "body", "hand_r", "hand_l","leg_r", "leg_l"];
			
			_unconscious = _injury select 6;
			if (_unconscious) then {[_unit, true, 10e10, true] call ace_medical_fnc_setUnconscious;};
		};
	} forEach _selected_units;
} else
{
	// Vanilla Injury System
	_dialogResult =
	[
		localize "STR_INJURY_WITHOUT_ACE",
		[
			[localize "STR_HEAD",_options],
			[localize "STR_TORSO",_options],
			[localize "STR_ARMS",_options],
			[localize "STR_LEGS",_options]
		]
	] call Ares_fnc_ShowChooseDialog;
	// handle escape dialog
	if (count _dialogResult == 0) exitWith {};
	
	if (_mode == "single") then
	{
		[localize "STR_HEALTH_CHANGED"] call Ares_fnc_ShowZeusMessage;
		_selected_units = [_unit];
	} else
	{
		_selected_units = ["units"] call Achilles_fnc_SelectUnits;
	};
	
	// get and set hits
	{
		_unit = _x;
		{
			_index = _dialogResult select _forEachIndex;
			_injury_val = switch (_index) do
			{
				case 0: {round (random [0,0.5,0.9])};
				case 1: {0};
				case 2: {0.5};
				case 3: {0.9};
			};
			_unit setHit [_x, _injury_val];
		} forEach ["head","body","hands","legs"];
	} forEach _selected_units;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
