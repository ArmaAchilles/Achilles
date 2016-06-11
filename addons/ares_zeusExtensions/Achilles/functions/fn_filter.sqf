////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_filter.sqf
//  DESCRIPTION: Similar to Python function filter
//
//	ARGUMENTS:
//	_this select 0:		CODE	- condition to be fullfilled by the array element
//	_this select 1:		ARRAY	- array that is processed
//
//	RETURNS:
//	_this:				ARRAY	- output array
//
//	Example:
//	[{_this>1},[1,2,3]] call Achilles_fnc_filter; //returns [2,3]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_condition","_array","_new_array"];

_condition = _this select 0;
_array = _this select 1;
_new_array = [];

{
	if (_x call _condition) then
	{
		_new_array pushBack _x;
	};
} forEach _array;
_new_array;