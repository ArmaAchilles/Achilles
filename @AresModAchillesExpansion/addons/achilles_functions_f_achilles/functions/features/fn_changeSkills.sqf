////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/1/17
//	VERSION: 2.0
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
		_attribute_values = _this select 1;
		{
			_skill_type = _x;
			_skill_value = _attribute_values select _forEachIndex;
			_skill_value = linearConversion [0,1,_skill_value,0.2,1];
			if (local _unit) then
			{
				_unit setSkill [_skill_type, _skill_value];
			} else
			{
				[_unit, [_skill_type, _skill_value]] remoteExec ["setSkill", _unit];
			};
		} forEach SKILLS;
	};
} forEach _units;