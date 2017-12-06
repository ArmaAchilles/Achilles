////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR:			Kex
// DATE: 			6/16/17
// VERSION: 		AMAE004
// DESCRIPTION: 	function that allows changing units skills
//
// ARGUMENTS:		0: OBJECT - unit for which skills are changed; if objNull then selection mode is activated
//
// RETURNS:			nothing
//
// Example:			[_unit] call Achilles_fnc_changeSkills;
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
	["SLIDER", localize "STR_AIMING_ACCURACY"],
	["SLIDER", localize "STR_AIMING_SHAKE"],
	["SLIDER", localize "STR_AIMING_SPEED"],
	["SLIDER", localize "STR_ENDURANCE"],
	["SLIDER", localize "STR_SPOT_DISTANCE"],
	["SLIDER", localize "STR_SPOT_TIME"],
	["SLIDER", localize "STR_COURAGE"],
	["SLIDER", localize "STR_RELOAD_SPEED"],
	["SLIDER", localize "STR_COMMANIDNG"]
];

private _skillRange = getArray (configFile >> "Cfg3DEN" >> "Attributes" >> "Skill" >> "Controls" >> "Value" >> "sliderRange");
private _curatorSelected = [];
if (_is_single_unit) then 
{
	{
		_skill_value = _entity skill (SKILLS select _forEachIndex);
		_x append [[_skillRange], _skill_value, true];
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
			["COMBOBOX", localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_CLS", localize "STR_DOCTOR"], _medic_class, true],
			["COMBOBOX", localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber ([_entity] call ace_common_fnc_isEngineer), true],
			["COMBOBOX", localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber ([_entity] call ace_common_fnc_isEOD), true]
		]
	} else
	{
		_number_of_traits = N_TRAITS;
		[
			["COMBOBOX", localize "STR_MEDICINE",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "medic"), true],
			["COMBOBOX", localize "STR_ENGINEER",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "engineer"), true],
			["COMBOBOX", localize "STR_EOD",[localize "STR_FALSE", localize "STR_TRUE"], parseNumber (_entity getUnitTrait "explosiveSpecialist"), true]
		]
	};
	_choices append _skill_choices;
} else 
{
	_entity = leader _entity;
	{
		_skill_value = _entity skill (SKILLS select _forEachIndex);
		_x append [[_skillRange], _skill_value, true];
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
] call Achilles_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_trait_values = if (_is_single_unit) then 
{
	_dialogResult select [0,_number_of_traits];
};
_skill_values = _dialogResult select [_number_of_traits,count SKILLS];

{
	private _unit = _x;
	{
		private _skill_type = _x;
		private _skill_value = _skill_values select _forEachIndex;
		if (local _unit) then
		{
			_unit setSkill [_skill_type, _skill_value];
		} else
		{
			[_unit, [_skill_type, _skill_value]] remoteExecCall ["setSkill", _unit];
		};
	} forEach SKILLS;
	
	if (_is_single_unit) then
	{
		if (_ace_loaded) then
		{
			_unit setVariable ["ace_medical_medicClass",_trait_values select 0,true];
			private _trait_value = if(_trait_values select 1 == 0) then {false} else {true};
			_unit setVariable ["ACE_isEngineer",_trait_value,true];
			_trait_value = if(_trait_values select 2 == 0) then {false} else {true};
			_unit setVariable ["ACE_isEOD",_trait_value,true];
		} else
		{
			{
				private _trait_type = _x;
				private _trait_value = if (_trait_values select _forEachIndex == 0) then {false} else {true};
				if (local _unit) then
				{
					_unit setUnitTrait [_trait_type, _trait_value];
				} else
				{
					[_unit, [_trait_type, _trait_value]] remoteExecCall ["setUnitTrait", _unit];
				};
			} forEach VANILLA_TRAITS;
		};
	};
} forEach _curatorSelected;
