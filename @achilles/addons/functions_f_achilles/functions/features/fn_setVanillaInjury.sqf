////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/30/17
//	VERSION: 1.0
//  DESCRIPTION: Sets vanilla damage on units
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Unit that is injured
//	_this select 1:		ARRAY	- array of injury values between 0 and 1 in the order of ["head","body","hands","legs"] selections
//								- alternatively an entry can be code which takes the unit as _this select 0 and returns the injury value
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,[0.5,0.5,0.5,{random 1}]] call Achilles_fnc_setVanillaInjury;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_unit","_value_list"];
{
	private _value = _value_list select _forEachIndex;
	private _injury_value = if (_value isEqualType {}) then { [_unit] call _value } else { _value };
	_unit setHit [_x, _injury_value];
} forEach ["head","body","hands","legs"];
