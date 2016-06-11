////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_changeAbility.sqf
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
	_units = ["units"] call Achilles_fnc_SelectUnits;
};
if (count _units == 0) exitWith {};
{
	[_x,_dialogResult] spawn 
	{
		_unit = _this select 0;
		_dialogResult = _this select 1;
		{
			_section = _x;
			_mode = _dialogResult select _forEachIndex;
			if (_mode == 0) then {_unit enableAI _section} else {_unit disableAI _section};
		} forEach ["AIMINGERROR","ANIM","AUTOCOMBAT","AUTOTARGET","CHECKVISIBLE","COVER","FSM","MOVE","SUPPRESSION","TARGET"];
	};
} forEach _units;
