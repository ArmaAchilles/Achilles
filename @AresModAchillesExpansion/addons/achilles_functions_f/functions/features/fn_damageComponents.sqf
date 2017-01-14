////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/1/17
//	VERSION: 3.0
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

if (local _vehicle) then
{
	{
		_vehicle setHitIndex [_forEachIndex,_x];
	} forEach _dialogResult;
} else
{
	[[_vehicle,_dialogResult],
	{
		_vehicle = _this select 0;
		_attribute_values = _this select 1;
		{
			_vehicle setHitIndex [_forEachIndex,_x];
		} forEach _attribute_values;
	}] remoteExec ["spawn",_vehicle];
};