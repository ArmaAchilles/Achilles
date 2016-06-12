////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_animation.sqf
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
	"Animation:",
	[
		["Type:",
		[
			"sit on floor (combat ready)",
			"lean on wall (combat ready)",
			"watch (combat ready)",
			"at ease",
			"briefing",
			"treat wounded",
			"wounded",
			"combat wounded",
			"repair vehicle prone",
			"repair vehicle kneel",
			"repair vehicle stand"
		]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
switch (_dialogResult select 0) do
{
	case 0: {_anim = 'SIT_LOW';};
	case 1: {_anim = 'LEAN';};
	case 2: 
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {_anim = "WATCH"};
			case 1: {_anim = "WATCH2"};
		};
	};
	case 3: {_anim = "GUARD"};
	case 4: {_anim = "BRIEFING"};
	case 5: {_anim = "KNEEL_TREAT"};
	case 6:
	{
		_case = round (random 1);
		switch (_case) do
		{
			case 0: {_anim = "PRONE_INJURED_U1"};
			case 1: {_anim = "PRONE_INJURED_U2"};
		};
	};
	case 7: {_anim = "PRONE_INJURED"};
	case 8: {_anim = "REPAIR_VEH_PRONE"};
	case 9: {_anim = "REPAIR_VEH_KNEEL"};
	case 10: {_anim = "REPAIR_VEH_STAND"};
};
if (isNull (_units select 0)) then
{
	_units = ["units"] call Achilles_fnc_SelectUnits;
};
if (count _units == 0) exitWith {};
{
	_unit = _x;
	if ((_dialogResult select 0) < 3) then 
	{
		// combat ready = can break out the animation
		[_unit,_anim,"ASIS"] call BIS_fnc_ambientAnimCombat;
	} else
	{
		// cannot break out
		[_unit,_anim,"ASIS"] call BIS_fnc_ambientAnim;
	};
	_unit spawn {sleep 1; detach _this;};
} forEach _units;