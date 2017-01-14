///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/20/16
//	VERSION: 1.0
//	FILE: Achilles\functions_f_achilles\common\fn_vectorMap.sqf
//  DESCRIPTION: Maps the transposed row vector with given transformation matrix
//
//	ARGUMENTS:
//	_this select 0:			matrix - transformation matrix
//  _this select 1:			vector - row vector
//
//	RETURNS:
//	_this:					vector - row vector
//
//	Example:
//	[_matrix,_vector] call Achilles_fn_vectorMap;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_matrix = param [0,[],[[]]];
_vector = param [1,[],[[]]];

if (count _matrix != count _vector) exitWith {diag_log "Error: matrix multiplication: incompatible dimensions!"};

private _output_vector = [];

{
	_element = _x vectorDotProduct _vector;
	_output_vector pushBack +_element;
} forEach _matrix;

_output_vector;