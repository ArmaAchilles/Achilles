////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 10/4/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\functions\fn_findInDict.sqf
//  DESCRIPTION: Push back element in nested arrays
//
//	ARGUMENTS:
//	_this select 0:		ARRAY		- input nested array in dict format
//  _this select 1:		ARRAY		- array of strings in order ["category","subcategory",...]
//  _this select 2:		ANYTHING	- object that is searched
//
//	RETURNS:
//	_this:				ARRAY		- array of indices: path of the object
//
//	Example:
//	[ ["myDict",[["category0",[1,2]],["category1",[3,2]]], ["category1"]], 2] call Achilles_fnc_findInDict; //returns [1,0]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_input_dict", [], [[]]], ["_category_array", [], [[]]], "_element"];

private _input_array = [];
private _indice_array = [];
private _temp_element = [];

private _dictName = _input_dict select 0;
_dictStorage = compile format ["Achilles_var_dictStorage_%1",_dictName];
if (isNil "_dictStorage") then {} else {};

if (count _indice_array == 0) exitWith { _input_array + [_element] };

// unpack array
private _temp_array = [_input_array];
{
	_temp_element = _temp_array select ((count _temp_array) - 1);
	_temp_array pushBack (_temp_element select _x);
} forEach _indice_array;

// push back element
_temp_array set [0, (_temp_array select 0) + [_element]];

reverse _indice_array;
reverse _temp_array;

// pack array
_temp_element = _temp_array select 0;
for "_i" from 0 to ((count _temp_array) - 2) do
{
	_old_element = _temp_element;
	_temp_element = _temp_array select (_i + 1);
	_temp_element set [_indice_array select _i, _old_element];
};

_temp_element
