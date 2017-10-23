/*
	Author: CreepPork_LV, shay_gman

	Description:
	Creates a fake (very small) explosion.

  Parameters:
    _this select: 0 - ARRAY - Spawn position

  Returns:
    Nothing
*/

private _spawnPos = _this select 0;

private _explosive = "SmallSecondary" createVehicle _spawnPos;
_explosive setPos _spawnPos;
