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

private ["_anim"];

private _units = [param [0,ObjNull,[ObjNull]]];

private _dialogResult =
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
				"listing (civilian)",
				"talking (civilian)",
				"listen to radio",
				"shield from sun",
				"navigate aircraft",
				"showing a vehicle the way",
				"treat wounded",
				"combat wounded",
				"wounded (general)",
				"wounded (head)",
				"wounded (chest)",
				"wounded (arm)",
				"wounded (leg)",
				"shocked civilian",
				"hiding civilian",
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
private _persistent = _dialogResult select 1;

_anim = switch (_dialogResult select 0) do
{
	case 0:	{"TERMINATE"};
	case 1: {"SIT_LOW"};
	case 2: {"LEAN"};
	case 3: 
	{
		private _case = round (random 1);
		switch (_case) do
		{
			case 0: {"WATCH_1"};
			case 1: {"WATCH_2"};
		};
	};
	case 4: 
	{
		private _case = round (random 1);
		switch (_case) do
		{
			case 0: {"STAND_1"};
			case 1: {"STAND_2"};
		};
	};
	case 5: 
	{
		private _case = round (random 2);
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
		private _case = round (random 1);
		switch (_case) do
		{
			case 0: {"BRIEFING_INTERACTIVE_1"};
			case 1: {"BRIEFING_INTERACTIVE_2"};
		};
	};
	case 10: {"LISTEN_CIV"};
	case 11: {"TALK_CIV"};
	case 12: {"LISTEN_TO_RADIO"};
	case 13: {"SHIELD_FROM_SUN"};
	case 14: {"NAVIGATE"};
	case 15: {"SHOWING_THE_WAY"};	
	case 16:
	{
		private _case = round (random 1);
		switch (_case) do
		{
			case 0: {"KNEEL_TREAT_1"};
			case 1: {"KNEEL_TREAT_2"};
		};
	};
	case 17: {"PRONE_INJURED"};
	case 18:
	{
		private _case = round (random 1);
		switch (_case) do
		{
			case 0: {"PRONE_INJURED_NO_WEAP_1"};
			case 1: {"PRONE_INJURED_NO_WEAP_2"};
		};
	};
	case 19: {"INJURY_HEAD"};
	case 20: {"INJURY_CHEST"};
	case 21: {"INJURY_ARM"};
	case 22: {"INJURY_LEG"};
	case 23: {"CIV_SHOCK"};
	case 24: {"CIV_HIDE"};
	case 25: {"CAPTURED_SIT"};
	case 26: {"REPAIR_VEH_PRONE"};
	case 27: {"REPAIR_VEH_KNEEL"};
	case 28: {"REPAIR_VEH_STAND"};
};
if (isNull (_units select 0)) then
{
	_units = [localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_units") exitWith {};
if (count _units == 0) exitWith {};

{
	_unit = _x;
	if (_persistent == 0) then
	{
		// combat ready = can break out the animation
		[_unit,_anim,true] remoteExec ["Achilles_fnc_ambientAnim",_unit];
	} else
	{
		// cannot break out
		[_unit,_anim,false] remoteExec ["Achilles_fnc_ambientAnim",_unit];
	};
} forEach _units;