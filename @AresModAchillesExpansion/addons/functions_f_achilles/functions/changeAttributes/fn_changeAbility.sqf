////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR Kex
//	DATE 1/1/17
//	VERSION 2.0
//  DESCRIPTION function that allows changing units abilities
//
//	ARGUMENTS
//	_this select 0			OBJECT	- unit for which abilities are changed; if objNull then selection mode is activated
//
//	RETURNS
//	nothing (procedure)
//
//	Example
//	[_unit] call Achilles_fnc_changeAbility;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ABILITIES ["AIMINGERROR","ANIM","AUTOCOMBAT","AUTOTARGET","CHECKVISIBLE","COVER","FSM","MINEDETECTION","MOVE","SUPPRESSION","TARGET","PATH"]

private _units = [param [0,ObjNull,[ObjNull]]];
private _abilityCount = count ABILITIES;
private _dialogResult =
[
	"Abilities",
	[
		["Aiming error",[localize "STR_AMAE_YES", localize "STR_AMAE_FALSE"]],
		["Anim",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Auto combat",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Autotarget",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Check visible",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Cover",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["FSM",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Move",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Mine Detection", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Suppression",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Target",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Path",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		["Allow fleeing","SLIDER", 0.5]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

if (isNull (_units select 0)) then
{
	_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_units") exitWith {};
if (_units isEqualTo []) exitWith {};

{
	private _unit = _x;
	{
		private _ability_type = _x;
		private _mode = _dialogResult select _forEachIndex;
		if (local _unit) then
		{
			if (_mode == 0) then {_unit enableAI _ability_type} else {_unit disableAI _ability_type};
		} else
		{
			if (_mode == 0) then {[_unit, _ability_type] remoteExecCall ["enableAI",_unit]} else {[_unit, _ability_type] remoteExecCall ["disableAI",_unit]};
		};
	} forEach ABILITIES;
	if (local _unit) then
	{
		_unit allowFleeing (_dialogResult select _abilityCount);
	} else
	{
		[_unit, _dialogResult select _abilityCount] remoteExecCall ["allowFleeing", _unit];
	};
} forEach _units;
