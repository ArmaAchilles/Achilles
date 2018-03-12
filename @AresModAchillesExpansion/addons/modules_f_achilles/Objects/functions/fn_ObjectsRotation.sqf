/*
	Author: CreepPork_LV

	Description:
	 Adds a possiblity to rotate an object on either the X, Y, Z axis.

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_showZeusErrorMessage};
if (_object isKindOf "Man") exitWith {[localize "STR_AMAE_UNITS_NOT_ALLOWED"] call Achilles_fnc_showZeusErrorMessage};

private _dir = direction _object;
private _vecDir = vectorDir _object;
private _pitch = asin ((vectorDir _vecDir) select 2);
// _basisVecDirPlane1 is a +90 degree rotation of _vecDir on the vecDir-zAxis plane
private _basisVecDirPlane1 = ((vectorNormalized [sin(_dir), cos(_dir), 0]) vectorMultiply -sin(_pitch)) vectorAdd [0, 0, vectorMagnitude [sin(_dir), cos(_dir), 0]];
private _basisVecDirPlane2 = _basisVecDirPlane1 vectorCrossProduct _vecDir;
// dirPlane is the plane perpendicular to the vecDir
private _dirPlaneToStandardBasis = [_vecDir, _basisVecDirPlane1, _basisVecDirPlane2];
private _standardToDirPlaneBasis = [_dirPlaneToStandardBasis] call Achilles_fnc_matrixTranspose;;
private _vecUp = vectorUp _object;
private _vecUp_dirPlane = [_standardToDirPlaneBasis, _vecUp] call Achilles_fnc_vectorMap;

private _dialogResult =
[
	localize "STR_AMAE_ROTATION_MODULE",
	[
		["SLIDER", localize "STR_AMAE_DIRECTION", [[0,360]], _dir, true]
		["SLIDER", localize "STR_AMAE_PITCH_ANGLE", [[-90,90]], _pitch, true],
		["SLIDER", localize "STR_AMAE_ROLL_ANGLE", [[-180,180]], _angles select 1, true],
	]
] call Achilles_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_dir", "_pitch", "_roll"];
private _vecDir = [sin(_dir), cos(_dir), sin(_pitch)];
// _basisVecDirPlane1 is a +90 degree rotation of _vecDir on the vecDir-zAxis plane
private _basisVecDirPlane1 = ((vectorNormalized [sin(_dir), cos(_dir), 0]) vectorMultiply -sin(_pitch)) vectorAdd [0, 0, vectorMagnitude [sin(_dir), cos(_dir), 0]];
private _basisVecDirPlane2 = _basisVecDirPlane1 vectorCrossProduct _vecDir;
// dirPlane is the plane perpendicular to the vecDir
private _dirPlaneToStandardBasis = [_vecDir, _basisVecDirPlane1, _basisVecDirPlane2];
private _vecUp_dirPlane = [sin(_roll), cos(_roll), 0];
private _vecUp = [_dirPlaneToStandardBasis, _vecUp_dirPlane] call Achilles_fnc_vectorMap;

if (local _object) then
{
	_object setVectorDirAndUp [_vecDir, _vecUp];
}
else
{
	[_object, [_vecDir, _vecUp]] remoteExecCall ["setVectorDirAndUp", _object];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
