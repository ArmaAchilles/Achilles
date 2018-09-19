/*
	Function:
		Achilles_arrayStdDev
	
	Authors:
		Kex
	
	Description:
		Returns the population standard deviation of the array for _ddof = 0
		Returns the sample standard deviation of the array for _ddof = 1
	
	Parameters:
		_array		- <ARRAY> The array from which the standard deviation is computed from
		_ddof		- <INTEGER> [0] The delta degrees of freedom (see description above)
	
	Returns:
		_stdDev		- <SCALAR> The standard deviation
	
	Exampes:
		(begin example)
		(end)
*/
params ["_array", ["_ddof", 0, [0]]];
private _N = (count _array) - _ddof;
if (_N <= 0) exitWith {0};
private _mean = _array call Achilles_fnc_arrayMean;
private _array = _array apply {(_x - _mean)^2};
private _sum = _array call Achilles_fnc_sum;
sqrt (_sum / _N)
