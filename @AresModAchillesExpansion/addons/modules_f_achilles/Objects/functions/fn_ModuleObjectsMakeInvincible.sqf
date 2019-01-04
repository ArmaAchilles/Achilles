////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/17
//	VERSION: 1.0
//  DESCRIPTION: Function for the module "make invincible"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
private _objects = [_object];

private _dialogResult =
[
	localize "STR_AMAE_MAKE_INVINCIBLE",
	[
		[localize "STR_AMAE_MAKE_INVINCIBLE", [localize "STR_AMAE_YES",localize "STR_AMAE_NO"]],
		[localize "STR_AMAE_INCLUDE_CREW", [localize "STR_AMAE_YES",localize "STR_AMAE_NO"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_allowDamage", "_includeCrew"];
_allowDamage = _allowDamage == 1;
_includeCrew = _includeCrew == 0;

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

{
	private _object = _x;
	[_object, _allowDamage] remoteExecCall ["allowDamage"];
	if (_includeCrew) then
	{
		{[_x, _allowDamage] remoteExecCall ["allowDamage"]} forEach crew _object;
	};
} forEach _objects;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
