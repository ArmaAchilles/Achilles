/*
	Authors:
		NeilZar

	Description:
		Set the ammo of a magazine in a turret

	Parameters:
		_this select 0:	OBJECT - Vehicle for which the ammo is set
		_this select 1: ARRAY - Turret to add the magazine to
		_this select 2: NUMBER - Percentage of total possible ammo to add

	Returns:
		none

	Examples:
		(begin example)
			[_vehicle, [0], 0.8] call Achilles_fnc_setTurretAmmo;
		(end)
*/
params ["_vehicle", "_turretPath", "_percentage"];

private _magazines = _vehicle magazinesTurret _turretPath;
private _pylonMagazines = getPylonMagazines _vehicle;

{
    private _magazineClass = _x;

    if !(_magazineClass in _pylonMagazines) then {
        private _magazineCount = {_x == _magazineClass} count _magazines;
        [_vehicle, _turretPath, _magazineClass, _magazineCount, _percentage] call Achilles_fnc_setMagazineAmmo;
    };
} forEach (_magazines arrayIntersect _magazines);
