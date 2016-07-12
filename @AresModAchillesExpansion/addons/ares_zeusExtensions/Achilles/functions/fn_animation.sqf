////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/29/16
//	VERSION: 2.0
//	FILE: Achilles\functions\fn_animation.sqf
//  DESCRIPTION: function that allows selecting an animation for a unit.
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- unit that the animation performs; if objNull then selection mode is activated
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit] call Achilles_fnc_Animation;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_anim","_dialogResult"];

_units = [param [0,ObjNull,[ObjNull]]];

_dialogResult =
[
	localize "STR_AMBIENT_ANIMATION",
	[
		[localize "STR_TYPE",
			[
				"stop animation",
				"sit on floor",
				"lean on wall",
				"watch",
				"stand idle",
				"stand idle (no weapon)",
				"at ease",
				"listen briefing",
				"briefing",
				"briefing (interactive)",
				"listen to radio",
				"navigate aircraft",
				"treat wounded",
				"wounded",
				"combat wounded",
				"sit captured",
				"repair vehicle prone",
				"repair vehicle kneel",
				"repair vehicle stand"
			]
		],
		["Combat Ready", [localize "STR_TRUE",localize "STR_FALSE"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_persistent = _dialogResult select 1;

_anim = switch (_dialogResult select 0) do
{
	case 0:	{""};
	case 1: {"SIT_LOW"};
	case 2: {"LEAN"};
	case 3: 
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {"WATCH_1"};
			case 1: {"WATCH_2"};
		};
	};
	case 4: 
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {"STAND_1"};
			case 1: {"STAND_2"};
		};
	};
	case 5: 
	{
		_case = round (random 2);
		switch (_case) do
		{
			case 0: {"STAND_NO_WEAP_1"};
			case 1: {"STAND_NO_WEAP_2"};
			case 2: {"STAND_NO_WEAP_3"};
		};
	};
	case 6: {"GUARD"};
	case 7: {"LISTEN_BRIEFING"};
	case 8: {"BRIEFING"};
	case 9: 
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {"BRIEFING_INTERACTIVE_1"};
			case 1: {"BRIEFING_INTERACTIVE_2"};
		};
	};
	case 10: {"LISTEN_TO_RADIO"};
	case 11: {"NAVIGATE"};

	
	case 12:
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {"KNEEL_TREAT_1"};
			case 1: {"KNEEL_TREAT_2"};
		};
	};
	case 13:
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {"PRONE_INJURED_NO_WEAP_1"};
			case 1: {"PRONE_INJURED_NO_WEAP_2"};
		};
	};
	case 14: {"PRONE_INJURED"};
	case 15: {"CAPTURED_SIT"};
	case 16: {"REPAIR_VEH_PRONE"};
	case 17: {"REPAIR_VEH_KNEEL"};
	case 18: {"REPAIR_VEH_STAND"};
};
if (isNull (_units select 0)) then
{
	_units = [localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
};
if (count _units == 0) exitWith {};

if (_anim == "") exitWith
{
	{
		_unit = _x;
		if (not isNil {_unit getVariable ["Achilles_var_animations",nil]}) then
		{
			[_unit, "TERMINATE"] call Achilles_fnc_ambientAnim;
		};
	} forEach _units;
};

{
	_unit = _x;
	if (not isNil {_unit getVariable ["Achilles_var_animations",nil]}) then
	{
		[_unit, "TERMINATE"] call Achilles_fnc_ambientAnim;
	};
	if (_persistent == 0) then
	{
		// combat ready = can break out the animation
		
		[_unit,_anim,true] call Achilles_fnc_ambientAnim;
	} else
	{
		// cannot break out
		[_unit,_anim,false] call Achilles_fnc_ambientAnim;
	};
} forEach _units;