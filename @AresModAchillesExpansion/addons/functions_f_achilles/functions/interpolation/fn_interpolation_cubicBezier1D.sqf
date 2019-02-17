/*
	Function:
		Achilles_fnc_interpolation_cubicBezier1D
	
	Authors:
		Kex
	
	Description:
		Returns the function value for the given x of a 1D cubic Bézier curve y(x)
	
	Parameters:
		_x				- <SCALAR> The function variable
		_y_start		- <SCALAR> Function value for the start node
		_y_end			- <SCALAR> Function value for the end node
		_y_ddx_start	- <SCALAR> Slope for the start node
		_y_ddx_end		- <SCALAR> Slope for the end node
		_x_start		- <SCALAR> [0] Variable value for the start node
		_x_end			- <SCALAR> [1] Variable value for the end node
	
	Returns:
		_y				- <SCALAR> The function value for the given _x.
	
	Examples:
		(begin example)
		(end)
*/
params ["_x", "_y_start", "_y_end", "_y_ddx_start", "_y_ddx_end", ["_x_start",0,[0]], ["_x_end",1,[0]]];
private _dx = _x_end - _x_start;
private _lambda = (_x - _x_start)/_dx;
private _y0 = (1 - _lambda)^3*_y_start;
private _y1 = 3*(1 - _lambda)^2*_lambda*(_y_start + _y_ddx_start*_dx/3);
private _y2 = 3*(1 - _lambda)*_lambda^2*(_y_end - _y_ddx_end*_dx/3);
private _y3 = _lambda^3*_y_end;
// return
(_y0+_y1+_y2+_y3)
