////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/19/16
//	VERSION: 2.0
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
private _n_items = count _this;
if (_n_items == 0) exitWith {0};
private _sum = 0;
{
	_sum = _sum + _x;
} forEach _this;
_sum / _n_items;