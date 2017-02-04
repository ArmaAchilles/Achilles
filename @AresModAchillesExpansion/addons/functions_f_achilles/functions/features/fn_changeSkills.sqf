////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/27/17
//	VERSION: 3.0
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

#define SKILLS			["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"]
#define ACE_TRAITS		["ace_medical_medicClass","ACE_IsEngineer","ACE_isEOD"]
#define VANILLA_TRAITS	["medic","engineer","explosiveSpecialist"]

private ["_dialogResult","_mode","_units","_unit","_choices"];

_entity = _this select 0;
_is_single_unit = (typeName _entity == "OBJECT");
_ace_loaded = isClass (configfile >> "CfgPatches" >> "ace_main");

_skill_choices = 
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
];

if (_is_single_unit and isPlayer (_units select 0)) then
{
} else
{
};

if (_is_single_unit) then 
{
	_unit = _entity;
	_choices = if (_ace_loaded) then
	{
		[
			[local "STR_MEDIC",["STR_FALSE","STR_CLS","STR_DOCTOR"]],
			[local "STR_ENGINEER",["STR_FALSE","STR_TRUE"]],
			[local "STR_EOD",["STR_FALSE","STR_TRUE"]]
		]
	} else
	{
		[
			[local "STR_MEDIC",["STR_FALSE","STR_TRUE"]],
			[local "STR_ENGINEER",["STR_FALSE","STR_TRUE"]],
			[local "STR_EOD",["STR_FALSE","STR_TRUE"]]
		]
	};
	if (not isPlayer _unit) then {_choices append _skill_choices; _mode = 1} else {_mode = 0};
} else 
{
	_units = units _entity;
	_choices = _skill_choices;
	_mode = 2;
};

_dialogResult =
[
	localize "STR_SKILL",
	_choices,
	"Achilles_fnc_RscDisplayAtttributes_ChangeSkills"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

if (isNull (_units select 0)) then
{
	_units = [localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_units") exitWith {};
if (count _units == 0) exitWith {};

_number_of_traits = count VANILLA_TRAITS;
_trait_values = _dialogResult select [0,_number_of_traits];
_skill_values = _dialogResult select [_number_of_traits,count #SKILLS];

{
	[_x,_trait_values,_skill_values,_ace_loaded] spawn 
	{
		params ["_unit","_trait_values","_skill_values","_ace_loaded"];
		if (_ace_loaded) then
		{
			{
				_trait_type = _x;
				_trait_value = _traits select _forEachIndex;
				_unit setVariable [_trait_type,_trait_value,true];
			} forEach ACE_TRAITS;
		} else
		{
			{
				_trait_type = _x;
				_trait_value = if (_traits select _forEachIndex == 0) then {false} else {true};
				_unit setUnitTrait [_trait_type,_trait_value];
			} forEach VANILLA_TRAITS;
		};
		
		{
			_skill_type = _x;
			_skill_value = _skill_values select _forEachIndex;
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