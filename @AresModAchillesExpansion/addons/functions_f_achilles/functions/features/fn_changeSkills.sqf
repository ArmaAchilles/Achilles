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

private ["_dialogResult","_mode","_number_of_traits","_trait_values","_choices"];

_entity = param [0, ObjNull, [grpNull, ObjNull]];
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

_curatorSelected = [];
if (_is_single_unit) then 
{
	_mode = if (_entity isKindOf "Man") then {"man"} else {"vehicle"};
	_curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
	_choices = if (_ace_loaded) then
	{
		_number_of_traits = count ACE_TRAITS;
		[
			[localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_CLS", localize "STR_DOCTOR"]],
			[localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"]],
			[localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"]]
		]
	} else
	{
		_number_of_traits = count VANILLA_TRAITS;
		[
			[localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_TRUE"]],
			[localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"]],
			[localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"]]
		]
	};
	_choices append _skill_choices;
} else 
{
	_mode = "group";
	_curatorSelectedGrps = [_mode] call Achilles_fnc_getCuratorSelected;
	{_curatorSelected append units _x} forEach _curatorSelectedGrps;
	_number_of_traits = 0;
	_units = units _entity;
	_choices = _skill_choices;
};

_dialogResult =
[
	localize "STR_SKILL",
	_choices,
	"Achilles_fnc_RscDisplayAtttributes_ChangeSkills"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_trait_values = if (_is_single_unit) then 
{
	_dialogResult select [0,_number_of_traits];
};
_skill_values = _dialogResult select [_number_of_traits,count SKILLS];

if (_is_single_unit) then
{
	if (_ace_loaded) then
	{
		_code =
		{
			params ["_unit", "_skill_values"];
			{
				_skill_type = _x;
				_skill_value = _skill_values select _forEachIndex;
				_skill_value = linearConversion [0,1,_skill_value,0.2,1];
				_unit setSkill [_skill_type, _skill_value];
			} forEach SKILLS;				
		};
		{
			_unit = _x;
			{
				_trait_type = _x;
				_trait_value = _trait_values select _forEachIndex;
				_unit setVariable [_trait_type,_trait_value,true];
			} forEach ACE_TRAITS;
			
			if (local _unit) then
			{
				[_unit, _skill_values] spawn _code;
			} else
			{
				[[_unit, _skill_values], _code] remoteExec ["spawn", _x];
			};
		} forEach _curatorSelected;
	} else
	{
		_code =
		{
			params ["_unit", "_trait_values", "_skill_values"];
			{
				_trait_type = _x;
				_trait_value = if (_trait_values select _forEachIndex == 0) then {false} else {true};
				_unit setUnitTrait [_trait_type, _trait_value];
			} forEach VANILLA_TRAITS;
			
			{
				_skill_type = _x;
				_skill_value = _skill_values select _forEachIndex;
				_skill_value = linearConversion [0,1,_skill_value,0.2,1];
				_unit setSkill [_skill_type, _skill_value];
			} forEach SKILLS;				
		};
		{
			_unit = _x;
			if (local _unit) then
			{
				[_unit, _trait_values, _skill_values] spawn _code;
			} else
			{
				[[_unit, _trait_values, _skill_values], _code] remoteExec ["spawn", _x];
			};
		} forEach _curatorSelected;
	};
} else
{
	_code =
	{
		params ["_unit", "_skill_values"];
		{
			_skill_type = _x;
			_skill_value = _skill_values select _forEachIndex;
			_skill_value = linearConversion [0,1,_skill_value,0.2,1];
			_unit setSkill [_skill_type, _skill_value];
		} forEach SKILLS;				
	};
	{
		_unit = _x;
		if (local _unit) then
		{
			[_unit, _skill_values] spawn _code;
		} else
		{
			[[_unit, _skill_values], _code] remoteExec ["spawn", _x];
		};
	} forEach _curatorSelected;
};