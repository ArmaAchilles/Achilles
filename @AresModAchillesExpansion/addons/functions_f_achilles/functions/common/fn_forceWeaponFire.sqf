////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			06.04.18
// VERSION: 		AMAE.1.0.2
// DESCRIPTION: 	Forces the foot soldier or unit in a turret to fire the selected magazine
//					Note that the weapon and magazine has to be loaded beforehand!
//
// ARGUMENTS:		0: OBJECT - A game logic. Required to get it working...
//					1: OBJECT - The gunner (either a foot soldier or in a vehicle).
//					2: STRING - Class name of the muzzle to fire.
//					3: STRING - Class name of the magazine to fire.
//					4: OBJECT - (Optional): Vehicle the gunner is in (default: objNull).
//					5: OBJECT - (Optional): Turret path (default: [0]).
//
// RETURNS:			SCALAR - Ammo count remained in the current magazine or -1 in case of a failure.
//
// Example:			[_targetLogic, _soldier, "arifle_MX_ACO_pointer_F", "30Rnd_65x39_caseless_mag"] call Achilles_fnc_forceWeaponFire;
//					[_targetLogic, gunner _marshall, "HE", "60Rnd_40mm_GPR_Tracer_Red_shells", _marshall, [0]] call Achilles_fnc_forceWeaponFire;
//					[_targetLogic, gunner _marshall, "LMG_M200_body", "2000Rnd_65x39_Belt", _marshall, [0]] call Achilles_fnc_forceWeaponFire;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_logic", objNull, [objNull]],
	["_gunner", objNull, [objNull]],
	["_muzzle", "", [""]],
	["_magazine", "", [""]],
	["_vehicle", objNull, [objNull]],
	["_turretPath", [0], [[]]]
];
private _success = 2;
private _ammoRemaining = _gunner ammo _muzzle;
if ((isNull _vehicle) or {_vehicle isKindOf "Man"}) then
{
	private _magIdx = (magazines _gunner) find _magazine;
	if (_magIdx isEqualTo -1) exitWith {_ammoRemaining = -1};
	if (_ammoRemaining == 0) exitWith {};
	((magazinesDetail _gunner select _magIdx) splitString "[]:/") params ["","","","","_id","_owner"];  
	_logic action ["UseMagazine", _gunner, _gunner, parseNumber _owner, parseNumber _id];
	_success = 0;
}
else
{
	if ((_vehicle currentMagazineTurret _turretPath) != _magazine) exitWith {_ammoRemaining = -1};
	if (_ammoRemaining == 0) exitWith {_success = 1};
	((_vehicle currentMagazineDetailTurret _turretPath) splitString "[]:/") params ["","","","","_id","_owner"];
	_logic action ["UseMagazine", _vehicle, _gunner, parseNumber _owner, parseNumber _id];
	_success = 0;
};
if (_success == 0) then
{
	_ammoRemaining = _ammoRemaining - 1;
	_gunner setAmmo [_muzzle, _ammoRemaining];
};
_ammoRemaining;
