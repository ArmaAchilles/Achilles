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

_spawnPos = _this select 0;
_explosionSize = _this select 1;

_explosiveClass = switch (_explosionSize) do {
  case 0: {"DemoCharge_Remote_Ammo_Scripted"};
  case 1: {"IEDUrbanSmall_Remote_Ammo"};
  case 2: {"IEDUrbanBig_Remote_Ammo"};
};

_IED = _explosiveClass createVehicle _spawnPos;

hideObjectGlobal _IED;
_IED setPosATL _spawnPos;

sleep 0.1;

_IED setDamage 1;
