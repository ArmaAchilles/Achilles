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

params[["_units", objNull, [[objNull]]]];
private _anim = "TERMINATE";

private _dialogResult =
[
	localize "STR_AMAE_AMBIENT_ANIMATION",
	[
		[localize "STR_AMAE_TYPE",
			[
				"Stop Animation",
				"Sit On Floor",
				"Lean On Wall",
				"Watch",
				"Stand Idle",
				"Stand Idle (no weapon)",
				"At Ease",
				"Listen Briefing",
				"Briefing",
				"Briefing (Interactive)",
				"Listening (Civilian)",
				"Talking (Civilian)",
				"Listen To Radio",
				"Shield From Sun",
				"Navigate Aircraft",
				"Showing Vehicle The Way",
				"Treat Wounded",
				"Combat Wounded",
				"Wounded (General)",
				"Wounded (Head)",
				"Wounded (Chest)",
				"Wounded (Arm)",
				"Wounded (Leg)",
				"Shocked Civilian",
				"Hiding Civilian",
				"Sit Captured",
				"Repair Vehicle (Prone)",
				"Repair Vehicle (Kneel)",
				"Repair Vehicle (Stand)",
				"Dead (Leaned)",
				"Dead (Erect)",
				"Weapon Ready (Kneel)",
				"Leaned On Table",
				"Bored",
				"Sit (Binoc)",
				"Sit (Weapon)",
				"Squat (Weapon)",
				"Squat",
				"Guard (Pistol)"
				]
		],
		["Combat Ready", [localize "STR_AMAE_TRUE",localize "STR_AMAE_FALSE"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _persistent = _dialogResult select 1;

_anim = switch (_dialogResult select 0) do
{
	case 0:	{"TERMINATE"};
	case 1: 
	{
		selectRandom ["SIT_LOW_1", "SIT_LOW_2", "SIT_LOW_3", "SIT_LOW_4", "SIT_LOW_5", "SIT_LOW_6"]; 
	};
	case 2: {"LEAN"};
	case 3:
	{
		selectRandom ["WATCH_1", "WATCH_2"];
	};
	case 4:
	{
		selectRandom ["STAND_1", "STAND_2"];
	};
	case 5:
	{
		selectRandom ["STAND_NO_WEAP_1", "STAND_NO_WEAP_2", "STAND_NO_WEAP_3", "STAND_NO_WEAP_4", "STAND_NO_WEAP_5"];
	};
	case 6: {"GUARD"};
	case 7: {"LISTEN_BRIEFING"};
	case 8: {"BRIEFING"};
	case 9:
	{
		selectRandom ["BRIEFING_INTERACTIVE_1", "BRIEFING_INTERACTIVE_2"];
	};
	case 10: {"LISTEN_CIV"};
	case 11: {"TALK_CIV"};
	case 12: {"LISTEN_TO_RADIO"};
	case 13: {"SHIELD_FROM_SUN"};
	case 14: {"NAVIGATE"};
	case 15: {"SHOWING_THE_WAY"};
	case 16:
	{
		selectRandom ["KNEEL_TREAT_1", "KNEEL_TREAT_2"];
	};
	case 17: {"PRONE_INJURED"};
	case 18:
	{
		selectRandom ["PRONE_INJURED_NO_WEAP_1", "PRONE_INJURED_NO_WEAP_2"];
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
	case 29: 
	{
		selectRandom ["DEAD_LEAN_1", "DEAD_LEAN_2"];
	};
    case 30: 
	{
		selectRandom ["DEAD_SIT_1", "DEAD_SIT_2", "DEAD_SIT_3"];
	};
	case 31: {"KNEEL_WEAP_UP"};
	case 32: {"TABLE"};
	case 33: {"BORED"};
	case 34: {"BINOC"};
	case 35:
	{
		selectRandom ["SIT_WEAP_1", "SIT_WEAP_2", "SIT_WEAP_3", "SIT_WEAP_4"];
	};
	case 36: {"SQUAT_WEAP"};
	case 37: {"SQUAT"};
	case 38: 
	{
		selectRandom ["STAND_GUARD_P1", "STAND_GUARD_P2", "STAND_GUARD_P3", "STAND_GUARD_P4"];
	};
};
if (isNull (_units select 0)) then
{
	_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
};
if (_units isEqualTo []) exitWith {};
if (isNil "_units") exitWith {};

{
	private _unit = _x;
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
