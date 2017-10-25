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

params[["_matrix", [], [[]]], ["_vector", [], [[]]]];

if (count _matrix != count _vector) exitWith {diag_log "Error: matrix multiplication: incompatible dimensions!"};

private _output_vector = [];

{
	_output_vector pushBack (_x vectorDotProduct _vector);
} forEach _matrix;

_output_vector;