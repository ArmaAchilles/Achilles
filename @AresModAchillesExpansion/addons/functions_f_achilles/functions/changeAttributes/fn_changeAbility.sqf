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

#define ABILITIES ["AIMINGERROR","ANIM","AUTOCOMBAT","AUTOTARGET","CHECKVISIBLE","COVER","FSM","MOVE","SUPPRESSION","TARGET","PATH"]

private _units = [param [0,ObjNull,[ObjNull]]];
private _abilityCount = count ABILITIES;
private _dialogResult =
[
	"Abilities",
	[
		[localize "STR_AMAE_ABIL_AIMING_ERROR",[localize "STR_AMAE_YES", localize "STR_AMAE_FALSE"]],
		[localize "STR_AMAE_ABIL_ANIM",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_AUTO_COMBAT",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_AUTOTARGET",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_CHECK_VISIBLE",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_COVER",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_FSM",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_MOVE",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_SUPPRESSION",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_TARGET",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_PATH",[localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_ABIL_COWARDICE","SLIDER", 0.5]
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
