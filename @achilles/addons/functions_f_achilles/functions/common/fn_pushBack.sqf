////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 10/4/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\functions\fn_pushBack.sqf
//  DESCRIPTION: Push back element in nested arrays
//
//	ARGUMENTS:
//	_this select 0:		ARRAY		- input array
//  _this select 1:		ARRAY		- array of indices; selects the sub-array where the element is appended (e.g [0,1] => _sub_array = _input_array select 0 select 1)
//  _this select 2:		ANYTHING	- object that is pushed back
//
//	RETURNS:
//	_this:				ARRAY		- output array
//
//	Example:
//	[ [[1,2],[4,5]], [1], 6] call Achilles_fnc_pusBack; //returns [[1,2],[4,5,6]]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
params[["_input_array", [], [[]]], ["_indice_array", [], [[]]], "_element"];

if (_indice_array isEqualTo []) exitWith {_input_array + [_element]};

// unpack array
private _temp_array = [_input_array];
{
	private _temp_element = _temp_array select ((count _temp_array) - 1);
	_temp_array pushBack (_temp_element select _x);
} forEach _indice_array;

// push back element
_temp_array set [0, (_temp_array select 0) + [_element]];

reverse _indice_array;
reverse _temp_array;

// pack array
private _temp_element = _temp_array select 0;
for "_i" from 0 to ((count _temp_array) - 2) do
{
	private _old_element = _temp_element;
	_temp_element = _temp_array select (_i + 1);
	_temp_element set [_indice_array select _i, _old_element];
};

_temp_element
