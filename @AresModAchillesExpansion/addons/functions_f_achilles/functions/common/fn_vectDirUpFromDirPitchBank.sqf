/*
	Function:
		Achilles_fnc_vectDirUpFromDirPitchBank
	
	Authors:
		Kex
	
	Description:
		Returns vector dir and up from dir, pitch and bank angles
		The output is suitable for setVectorDirAndUp
		Rotation order: first dir, then pitch, then bank
		Unlike for setDir, the dir angle is 0 for vector dir [1,0,0] 
			and is positive in counterclockwise direction (i.e. mathematical angle instead of azimuth)

	Parameters:
		_object	- <OBJECT> first 3D vector
	
	Returns:
		_dirPitchBank	- <ARRAY> List with dir, pitch and bank angle.
	
	Examples:
		(begin example)
		// returns [[0,sqrt(0.5),sqrt(0.5)],[sqrt(0.5),-0.5,0.5]]
		[90,45,45] call Achilles_fnc_vectDirUpFromDirPitchBank;
		(end)
*/

params ["_dir", "_pitch", "_bank"];
// _vectDir is just the conversion from spherical to Cartesian coordinates when the radius is 1.
private _vectDir = [cos(_dir)*cos(_pitch), sin(_dir)*cos(_pitch), sin(_pitch)];
// _phi is the pitch angle when _vectUp is treated as _vectDir 
private _phi = 90 + _pitch;
private _vectUp = [cos(_dir)*cos(_phi), sin(_dir)*cos(_phi), sin(_phi)];
// Skip bank if not needed
if !(_bank isEqualTo 0) then
{
	// Get the bank rotation matrix
	private _world_to_model = [_vectUp, _vectDir vectorCrossProduct _vectUp, _vectDir];
	private _model_to_world = [_world_to_model] call CBA_fnc_matrixTranspose;
	private _rotMatrix_bank = [_model_to_world, [[[cos(_bank),-sin(_bank),0],[sin(_bank),cos(_bank),0],[0,0,1]], _world_to_model] call CBA_fnc_matrixProduct3D] call CBA_fnc_matrixProduct3D;
	// Adjust the up vector
	_vectUp = [_rotMatrix_bank, _vectUp] call CBA_fnc_vectMap3D;
};
// return
[_vectDir, _vectUp]
