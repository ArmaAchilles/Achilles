///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kyle Kotowick
//	DATE: 11/20/16
//	VERSION: 1.0
//	FILE: Achilles\functions_f_achilles\common\fn_matrixTranspose.sqf
//  DESCRIPTION: Transposes given matrix 
//
//	ARGUMENTS:
//	_this select 0:			matrix -  input matrix
//
//	RETURNS:
//	_this:					matrix - transposed matrix
//
//	Example:
//	[_matrix] call Achilles_fnc_matrixTranspose;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_matrix = param [0,[],[[]]];

_m = count _matrix;
_n = count (_matrix select 0);

private _outputMatrix = [];

for "_j" from 0 to (_n - 1) do {
	_tmp_row = [];
	for "_i" from 0 to (_m - 1) do {
		_tmp_row pushBack ((_matrix select _i) select _j);
	};
	_outputMatrix pushBack _tmp_row;
};

_outputMatrix;