////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/1/17
//	VERSION: 2.0
//  DESCRIPTION: function that allows changing units abilities
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- unit for which abilities are changed; if objNull then selection mode is activated
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit] call Achilles_fnc_changeAbility;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ABILITIES ["AIMINGERROR","ANIM","AUTOCOMBAT","AUTOTARGET","CHECKVISIBLE","COVER","FSM","MOVE","SUPPRESSION","TARGET"]

private ["_selection","_dialogResult","_mode"];

_units = [param [0,ObjNull,[ObjNull]]];

_dialogResult =
[
	"Abilities:",
	[
		["Aiming error:",["true","false"]],
		["Anim:",["true","false"]],
		["Auto combat:",["true","false"]],
		["Autotarget:",["true","false"]],
		["Check visible:",["true","false"]],
		["Cover:",["true","false"]],
		["FSM:",["true","false"]],
		["Move:",["true","false"]],
		["Suppression:",["true","false"]],
		["Target:",["true","false"]]
	]
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
			_ability_type = _x;
			_mode = _attribute_values select _forEachIndex;
			if (local _unit) then
			{
				if (_mode == 0) then {_unit enableAI _ability_type} else {_unit disableAI _ability_type};
			} else
			{
				if (_mode == 0) then {[_unit, _ability_type] remoteExec ["enableAI",_unit]} else {[_unit, _ability_type] remoteExec ["disableAI",_unit]};
			};
		} forEach ABILITIES;
	};
} forEach _units;
