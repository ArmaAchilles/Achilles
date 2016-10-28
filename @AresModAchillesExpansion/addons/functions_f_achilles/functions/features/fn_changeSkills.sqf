////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/17/16
//	VERSION: 1.0
//	FILE: Achilles\functions_f_achilles\functions\features\fn_changeSkills.sqf
//  DESCRIPTION: function that allows changing units skills
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- unit for which skills are changed; if objNull then selection mode is activated
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit] call Achilles_fnc_changeSkills;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define SKILLS		["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"]

private ["_selection","_dialogResult","_mode"];

_entity = _this select 0;
_units = if (typeName _entity == "OBJECT") then {[_entity]} else {units _entity};

_dialogResult =
[
	localize "STR_SKILL",
	[
		[localize "STR_AIMING_ACCURACY","SLIDER"],
		[localize "STR_AIMING_SHAKE","SLIDER"],
		[localize "STR_AIMING_SPEED","SLIDER"],
		[localize "STR_ENDURANCE","SLIDER"],
		[localize "STR_SPOT_DISTANCE","SLIDER"],
		[localize "STR_SPOT_TIME","SLIDER"],
		[localize "STR_COURAGE","SLIDER"],
		[localize "STR_RELOAD_SPEED","SLIDER"],
		[localize "STR_COMMANIDNG","SLIDER"]
	],
	"Achilles_fnc_RscDisplayAtttributes_ChangeSkills"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

if (isNull (_units select 0)) then
{
	_units = [localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_units") exitWith {};
if (count _units == 0) exitWith {};
{
	[_x,_dialogResult] spawn 
	{
		_unit = _this select 0;
		_dialogResult = _this select 1;
		{
			_skillValue = linearConversion [0,1,(_dialogResult select _forEachIndex),0.2,1];
			_unit setSkill [_x, _skillValue];
		} forEach SKILLS;
	};
} forEach _units;
