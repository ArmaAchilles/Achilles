/*
	Authors:
    	NeilZar

	Description:
    	Set the ammo of a magazine in a turret

	Parameters:
		_this:	OBJECT - Vehicle for which the ammo is counted

	Returns:
		none

	Examples:
    	(begin example)
		_vehicle call Achilles_fnc_getVehicleAmmoDef;
        (end)
*/
params ["_vehicle", "_magazine", "_totalAmmo"];
_magazine params ["_name", "_turret", "_magMaxAmmo", "_magCount"];

_vehicle removeMagazines _name;
for "_i" from 1 to _magCount do {
    private _magAmmo = _magMaxAmmo min _totalAmmo;
    _vehicle addMagazineTurret [_name, _turret, _magAmmo];
    _totalAmmo = _totalAmmo - _magMaxAmmo;
};
