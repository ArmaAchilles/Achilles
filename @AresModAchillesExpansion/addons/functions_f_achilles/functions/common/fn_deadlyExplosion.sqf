/*
	Author: CreepPork_LV, shay_gman

	Description:
	Creates a deadly IED explosion.

  Parameters:
    _this select: 0 - ARRAY - Center of explosion
    _this select: 1 - NUMBER - Explosion Size

  Returns:
    Nothing
*/

params["_spawnPos", "_explosionSize"];

private _explosiveClass = ["DemoCharge_Remote_Ammo_Scripted", "IEDUrbanSmall_Remote_Ammo", "IEDUrbanBig_Remote_Ammo"] select _explosionSize;

private _IED = _explosiveClass createVehicle _spawnPos;

hideObjectGlobal _IED;
_IED setPosATL _spawnPos;

sleep 0.1;

_IED setDamage 1;
