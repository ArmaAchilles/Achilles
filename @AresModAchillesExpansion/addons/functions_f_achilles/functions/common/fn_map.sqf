////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_map.sqf
//  DESCRIPTION: Similar to Python function map, but only supports one array atm
//
//	ARGUMENTS:
//	_this select 0:		CODE	- code that defines how the array elements are mapped: _x ¦---> _y
//	_this select 1:		ARRAY	- array that is processed
//
//	RETURNS:
//	_this:				ARRAY	- output array
//
//	Example:
//	[{_this+1},[1,2]] call Achilles_fnc_map; //returns [2,3]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private '_new_array';

_fnc = _this select 0;
_array = _this select 1;
_new_array = [];

{
	_y = _x call _fnc;
	_new_array pushBack _y;
} forEach _array;
_new_array;