/*
	Authors:
		NeilZar

	Description:
		Set the ammo of a magazine in a turret

	Parameters:
		_this select 0:	OBJECT - Vehicle for which the ammo is set
		_this select 1: ARRAY - Turret to add the magazine to
		_this select 2: STRING - Class name of the magazine
		_this select 3: NUMBER - Amount of magazines of the given class in the turret
		_this select 4: NUMBER - Percentage of total possible ammo to add

	Returns:
		none

	Examples:
		(begin example)
			[_vehicle, [0], "680Rnd_35mm_AA_shells_Tracer_Red", 2, 0.8] call Achilles_fnc_setMagazineAmmo;
		(end)
*/
params ["_vehicle", "_turretPath", "_magazineClass", "_magazineCount", "_percentage"];

private _maxRoundsPerMag = getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count");
private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

_vehicle removeMagazinesTurret [_magazineClass, _turretPath];

for "_i" from 1 to _magazineCount do {
	_vehicle addMagazineTurret [_magazineClass, _turretPath, 0 max _totalRounds min _maxRoundsPerMag];
    _totalRounds = _totalRounds - _maxRoundsPerMag;
};
