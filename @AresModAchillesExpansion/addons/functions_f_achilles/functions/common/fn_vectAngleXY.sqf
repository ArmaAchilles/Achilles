/*
	Function:
		Achilles_fnc_vectAngleXY

	Authors:
		Kex

	Description:
		Calculates the signed angle from the first to the second vector in xy-plane
		Positive sign means counterclockwise
		Returns an angle from (-180,180]

	Parameters:
		_vecA	- <ARRAY> First 3D vector
		_vecB	- <ARRAY> Second 3D vector

	Returns:
		_angle	- <SCALAR> The measured angle

	Exampes:
		(begin example)
		// returns 90
		[[1,0,0],[0,1,0]] call Achilles_fnc_vectAngleXY;
		(end)
*/

params
[
	["_vecA", [0,0,0], [[]], 3],
	["_vecB", [0,0,0], [[]], 3]
];
_vecA set [2, 0];
_vecB set [2, 0];
private _angle = acos (_vecA vectorCos _vecB);
// The sign of det(_vecA_XY _vecB_XY) tells us the orientation of the basis
private _determinat = (_vecA select 0) * (_vecB select 1) - (_vecB select 0) * (_vecA select 1);
if (_determinat < 0) then
{
	_angle = -_angle;
};
// return
_angle
