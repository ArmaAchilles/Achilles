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
#define N_TRAITS		3
#define VANILLA_TRAITS	["medic","engineer","explosiveSpecialist"]

private ["_dialogResult","_mode","_number_of_traits","_trait_values","_choices","_skill_value","_medic_class"];

_entity = param [0, ObjNull, [grpNull, ObjNull]];
_is_single_unit = (typeName _entity == "OBJECT");
_ace_loaded = isClass (configfile >> "CfgPatches" >> "ace_main");

private _skill_choices = 
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
private _curatorSelected = [];
private _skillRange = getArray (configFile >> "Cfg3DEN" >> "Attributes" >> "Skill" >> "Controls" >> "Value" >> "sliderRange");
if (_is_single_unit) then 
{
	{
		_skill_value = _entity skill (SKILLS select _forEachIndex);
		_skill_value = linearConversion (_skillRange + [_skill_value,0,1,true]);
		_x append [_skill_value, true];
	} forEach _skill_choices;

	_mode = if (_entity isKindOf "Man") then {"man"} else {"vehicle"};
	_curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
	_choices = if (_ace_loaded) then
	{
		_number_of_traits = N_TRAITS;
		_medic_class = _entity getVariable ["ace_medical_medicClass", -1];
		if (_medic_class == -1) then 
		{
			_medic_class = if (_entity getUnitTrait "medic") then {1} else {0};
		};
		[
			[localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_CLS", localize "STR_DOCTOR"], _medic_class, true],
			[localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber ([_entity] call ace_common_fnc_isEngineer), true],
			[localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber ([_entity] call ace_common_fnc_isEOD), true]
		]
	} else
	{
		_number_of_traits = N_TRAITS;
		[
			[localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "medic"), true],
			[localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "engineer"), true],
			[localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "explosiveSpecialist"), true]
		]
	};
	_choices append _skill_choices;
} else 
{
	_entity = leader _entity;
	{
		_skill_value = _entity skill (SKILLS select _forEachIndex);
		_skill_value = linearConversion (_skillRange + [_skill_value,0,1,true]);
		_x append [_skill_value, true];
	} forEach _skill_choices;

	_mode = "group";
	_curatorSelectedGrps = [_mode] call Achilles_fnc_getCuratorSelected;
	{_curatorSelected append units _x} forEach _curatorSelectedGrps;
	_number_of_traits = 0;
	_choices = _skill_choices;
};

_dialogResult =
[
	localize "STR_SKILL",
	_choices
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
			private _skillRange = getArray (configFile >> "Cfg3DEN" >> "Attributes" >> "Skill" >> "Controls" >> "Value" >> "sliderRange");
			{
				_skill_type = _x;
				_skill_value = _skill_values select _forEachIndex;
				_skill_value = linearConversion ([0,1,_skill_value] + _skillRange);
				_unit setSkill [_skill_type, _skill_value];
			} forEach SKILLS;				
		};
		{
			_unit = _x;
			_unit setVariable ["ace_medical_medicClass",_trait_values select 0,true];
			_trait_value = if(_trait_values select 1 == 0) then {false} else {true};
			_unit setVariable ["ACE_isEngineer",_trait_value,true];
			_trait_value = if(_trait_values select 2 == 0) then {false} else {true};
			_unit setVariable ["ACE_isEOD",_trait_value,true];
			
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
			private _skillRange = getArray (configFile >> "Cfg3DEN" >> "Attributes" >> "Skill" >> "Controls" >> "Value" >> "sliderRange");
			{
				_trait_type = _x;
				_trait_value = if (_trait_values select _forEachIndex == 0) then {false} else {true};
				_unit setUnitTrait [_trait_type, _trait_value];
			} forEach VANILLA_TRAITS;
			
			{
				_skill_type = _x;
				_skill_value = _skill_values select _forEachIndex;
				_skill_value = linearConversion ([0,1,_skill_value] + _skillRange);
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