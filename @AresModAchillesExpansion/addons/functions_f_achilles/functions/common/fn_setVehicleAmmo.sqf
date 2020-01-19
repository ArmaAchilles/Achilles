/*
	Authors:
		NeilZar

	Description:
		Set vehicle's magazine count based on given percentage

	Parameters:
		_this select 0:	OBJECT - vehicle for which the ammo is changed
		_this select 1:	SCALAR - ammo value in range [0,1]

	Returns:
		none

	Examples:
		(begin example)
			[_vehicle, 0.9] call Achilles_fnc_setVehicleAmmo;
		(end)
*/
params ["_vehicle", ["_percentage", 1, [1]]];

private _pylonMagazines = getPylonMagazines _vehicle;
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _pylonMagazine = _x;

    if (_pylonMagazine != "") then {
        private _magazineCount = {_x == _pylonMagazine} count _pylonMagazines;
        private _maxRoundsPerMag = getNumber (_cfgMagazines >> _pylonMagazine >> "count");

        private _totalRounds = round (_magazineCount * _maxRoundsPerMag * _percentage);

        {
            if (_x == _pylonMagazine) then {
                private _roundsOnPylon = 0 max _totalRounds min _maxRoundsPerMag;
                _totalRounds = _totalRounds - _roundsOnPylon;

                [_vehicle, [_forEachIndex + 1, _roundsOnPylon]] remoteExecCall ["setAmmoOnPylon", _vehicle];
            };
        } forEach _pylonMagazines;
    };
} forEach (_pylonMagazines arrayIntersect _pylonMagazines);

{
	private _turretUnit = _vehicle turretUnit _x;
	if (!local _turretUnit) then
	{
		[_vehicle, _x, _percentage] remoteExecCall ["Achilles_fnc_setTurretAmmo", _turretUnit];
	}
	else
	{
		[_vehicle, _x, _percentage] call Achilles_fnc_setTurretAmmo;
	};
} forEach (_vehicle call Achilles_fnc_getAllTurrets);
