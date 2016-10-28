////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\functions\fn_arrayMean.sqf
//  DESCRIPTION: Determines the mean of an array
//
//	ARGUMENTS:
//	_this:				ARRAY	- array of numbers
//
//	RETURNS:
//	_this:				SCALAR	- mean value
//
//	Example:
//	[1,2,3] call Achilles_fnc_arrayMean; //returns 3
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_sum"];

_sum = 0;
{
	_sum = _sum + _x;
} forEach _this;
_sum / (count _this);