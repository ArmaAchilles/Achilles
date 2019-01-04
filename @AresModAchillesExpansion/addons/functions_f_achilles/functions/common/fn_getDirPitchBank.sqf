/*
	Function:
		Achilles_fnc_getDirPitchBank
	
	Authors:
		Kex
	
	Description:
		Returns dir, pitch and bank angle of the object
		Unlike for getDir, the dir angle is 0 for vector dir [1,0,0] 
			and is positive in counterclockwise direction (i.e. mathematical angle instead of azimuth)
	
	Parameters:
		_object			- <OBJECT> first 3D vector
	
	Returns:
		_dirPitchBank	- <ARRAY> List with dir, pitch and bank angle.
	
	Examples:
		(begin example)
		[_object] call Achilles_fnc_getDirPitchBank;
		(end)
*/

params ["_object"];
private _vectDir = vectorDirVisual _object;
private _vectUp = vectorUpVisual _object;
// Get pitch
private _pitch = asin(_vectDir#2);
// Get dir
private _dir = asin(_vectDir#1 / cos(_pitch));
// Handle the other half of the unit circle
if (_vectDir vectorDotProduct [1,0,0] < 0) then
{
	_dir = - _dir + ([-180, 180] select (_dir >= 0));
};
// _phi is the pitch angle when _vectUp is treated as _vectDir 
private _phi = 90 + _pitch;
private _vectUp_unBanked = [cos(_dir)*cos(_phi), sin(_dir)*cos(_phi), sin(_phi)];
// Get bank
private _vectPerp = _vectDir vectorCrossProduct _vectUp_unBanked;
private _world_to_model = [_vectUp_unBanked, _vectPerp, _vectDir];
private _vectUp_model = [_world_to_model, _vectUp] call CBA_fnc_vectMap3D;
private _bank = asin(_vectUp_model#1);
// Handle the other half of the unit circle
if (_vectUp_model vectorDotProduct [1,0,0] < 0) then
{
	_bank = - _bank + ([-180, 180] select (_bank >= 0));
};
// Return
[_dir, _pitch, _bank]
