/*
	Function:
		Achilles_fnc_interpolation_cubicBezier1D_slope
	
	Authors:
		Kex
	
	Description:
		Returns the slope for the given x of a 1D cubic Bézier curve y(x)
	
	Parameters:
		_x				- <SCALAR> The function variable
		_y_start		- <SCALAR> Function value for the start node
		_y_end			- <SCALAR> Function value for the end node
		_y_ddx_start	- <SCALAR> Slope for the start node
		_y_ddx_end		- <SCALAR> Slope for the end node
		_x_start		- <SCALAR> [0] Variable value for the start node
		_x_end			- <SCALAR> [1] Variable value for the end node
	
	Returns:
		_y_ddx			- <SCALAR> The slope for the given _x.
	
	Exampes:
		(begin example)
		(end)
*/
params ["_x", "_y_start", "_y_end", "_y_ddx_start", "_y_ddx_end", ["_x_start",0,[0]], ["_x_end",1,[0]]];
private _dx = _x_end - _x_start;
private _lambda = (_x - _x_start)/_dx;
private _y0 = -3*_y_start*(1 - _lambda)^2/_dx;
private _y1 = 3*(1 - _lambda)^2*(_dx*_y_ddx_start/3 + _y_start)/_dx - 6*(1 - _lambda)*_lambda*(_dx*_y_ddx_start/3 + _y_start)/_dx;
private _y2 = (3 - 3*_lambda)*2*_lambda*(-_dx*_y_ddx_end/3 + _y_end)/_dx - 3*_lambda^2*(-_dx*_y_ddx_end/3 + _y_end)/_dx;
private _y3 = 3*_y_end*_lambda^2/_dx;
// return
(_y0+_y1+_y2+_y3)
