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
			[_vehicle, 0.9] call Achilles_fnc_setVehicleAmmoDef;
		(end)
*/
params ["_vehicle", ["_percentage", 1, [1]]];

private _pylonMags = getPylonMagazines _vehicle;
private _turretMags = magazinesAllTurrets _vehicle select {!((_x select 0) in _pylonMags)};
private _configMags = configFile >> "CfgMagazines";

{
	private _pylonIndex = _forEachIndex + 1;
	private _magMaxAmmo = getNumber (_configMags >> _x >> "count");

	_vehicle setAmmoOnPylon [_pylonIndex, _magMaxAmmo * _percentage];
} forEach _pylonMags;

private _turretMagCount = (_turretMags apply {[_x select 0, _x select 1]}) call CBA_fnc_getArrayElements;
{
	_x pushBack (getNumber (_configMags >> (_x select 0) >> "count"));
	_x pushBack (_turretMagCount select ((_forEachIndex + 1) * 2) - 1);
} forEach (_turretMagCount select {_x isEqualType []});
_turretMagCount = _turretMagCount select {_x isEqualType []};

{
	_x params ["_name", "_turret", "_magMaxAmmo", "_magCount"];
	private _turretMag = round (_magMaxAmmo * _magCount * _percentage);
	if (!(_vehicle turretLocal _turret)) then
	{
		[_vehicle, _x, _turretMag] remoteExecCall ["Achilles_fnc_setVehicleMags", _vehicle turretUnit _turret];
	}
	else
	{
		[_vehicle, _x, _turretMag] call Achilles_fnc_setVehicleMags;
	};
} forEach _turretMagCount;
