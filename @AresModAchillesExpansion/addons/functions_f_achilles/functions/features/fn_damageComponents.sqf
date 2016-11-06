////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/17/16
//	VERSION: 2.0
//	FILE: functions_f_achilles\functions\features\fn_damageComponents.sqf
//  DESCRIPTION: opens the "damage components" dialog for vehicles.
//
//	ARGUMENTS:
//	_this select 0		_vehicle (optional)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_vehicle] call Achilles_fnc_damageComponents;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// get params
_vehicle = _this select 0;
_components = (getAllHitPointsDamage _vehicle) select 0;

// truncation of array given by dialog space (important components are usually below the truncation)
_components = _components select [0,14];
_entries	= _components apply {[_x,"SLIDER"]};

_dialogResult = 
[
	"Damage Components",
	_entries,
	"Achilles_fnc_RscDisplayAtttributes_DamageComponents"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
{
	_vehicle setHitIndex [_forEachIndex,_x];
} forEach _dialogResult;