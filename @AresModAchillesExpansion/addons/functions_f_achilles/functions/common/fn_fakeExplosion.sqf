/*
	Author: CreepPork_LV, shay_gman

	Description:
	Creates a fake (very small) explosion.

  Parameters:
    _this select: 0 - ARRAY - Spawn position

  Returns:
    Nothing
*/

params ["_spawnPos"];

private _explosive = "SmallSecondary" createVehicle _spawnPos;
_explosive setPos _spawnPos;
