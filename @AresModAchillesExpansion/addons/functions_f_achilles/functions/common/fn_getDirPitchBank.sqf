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
private _pitch = 90 - acos(_vectDir vectorCos [0,0,1]);
// Get bank
private _vectPerpY = _vectDir vectorCrossProduct [0,0,1];
private _vectPerpZ = _vectPerpY vectorCrossProduct _vectDir;
private _world_to_model = [_vectPerpZ, _vectPerpY, _vectDir];
private _bank = [[1,0,0], [_world_to_model, _vectUp] call CBA_fnc_vectMap3D] call Achilles_fnc_vectAngleXY;
// Get dir
private _dir = [[1,0,0], _vectDir] call Achilles_fnc_vectAngleXY;
// Return
[_dir, _pitch, _bank]
