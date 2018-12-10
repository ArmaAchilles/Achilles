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
// Generate leveled vector dir and up
private _vectDir = [cos(_dir), sin(_dir), 0];
private _vectUp = [0,0,1];
// Get the pitch rotation matrix
private _world_to_model = [_vectDir, _vectUp, _vectDir vectorCrossProduct _vectUp];
private _model_to_world = [_world_to_model] call CBA_fnc_matrixTranspose;
private _rotMatrix_pitch = [_model_to_world, [[[cos(_pitch),-sin(_pitch),0],[sin(_pitch),cos(_pitch),0],[0,0,1]], _world_to_model] call CBA_fnc_matrixProduct3D] call CBA_fnc_matrixProduct3D;
// Get the bank rotation matrix
private _model_to_world = [_rotMatrix_pitch, _model_to_world] call CBA_fnc_matrixProduct3D;
private _world_to_model = [_model_to_world] call CBA_fnc_matrixTranspose;
private _rotMatrix_bank = [_model_to_world, [[[1,0,0],[0,cos(_bank),-sin(_bank)],[0,sin(_bank),cos(_bank)]], _world_to_model] call CBA_fnc_matrixProduct3D] call CBA_fnc_matrixProduct3D;
// Rotate vector dir and up
_vectDir = [_rotMatrix_pitch, _vectDir] call CBA_fnc_vectMap3D;
_vectUp = [_rotMatrix_pitch, _vectUp] call CBA_fnc_vectMap3D;
_vectUp = [_rotMatrix_bank, _vectUp] call CBA_fnc_vectMap3D;
// return
[_vectDir, _vectUp]
