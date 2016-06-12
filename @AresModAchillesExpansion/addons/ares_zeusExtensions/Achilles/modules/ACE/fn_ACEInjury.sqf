////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_ACEInjury.sqf
//  DESCRIPTION: Function for the module ACE Injury
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\ares_zeusExtensions\Ares\module_header.hpp"

private ["_injury","_selected_units"];

_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_mode = if (!isNull _unit) then {"Single Unit"} else {"Multiple Units by Selection"};

_dialogResult =
[
	format ["ACE Injury (Mode: %1):", _mode],
	[
		["Head:",["random","no","light","severe"]],
		["Torso:",["random","no","light","severe"]],
		["Right Arm:",["random","no","light","severe"]],
		["Left Arm:",["random","no","light","severe"]],
		["Right Leg:",["random","no","light","severe"]],
		["Left Leg:",["random","no","light","severe"]],
		["Unconscious:",["True","False"]]
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

if (_mode == "Single Unit") then
{
	["Unit's health changed!"] call Ares_fnc_ShowZeusMessage;
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

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
