/*
	Author: CreepPork_LV, shay_gman

	Description:
	 Creates a medium sized explosion that can disable units.

  Parameters:
    _this select: 0 - ARRAY - Spawn position
    _this select: 1 - NUMBER - Explosion Size

  Returns:
    Nothing
*/

params["_spawnPos", "_explosionSize"];
private _random	= 0;
private _hitRadius = 0;
private _killRadius = 0;

switch (_explosionSize) do
{
   case 0:
	{
	   "SmallSecondary" createVehicle _spawnPos;
	   _hitRadius 	= 20;
	   _killRadius	= 10;
	};

	case 1:
	{
	   "M_AT" createVehicle _spawnPos;
		_hitRadius = 30;
		_killRadius	= 20;
	};

	case 2:
	{
	   "M_AT" createVehicle _spawnPos;
	   _hitRadius = 50;
	   _killRadius	= 30;
	};
};

private _targetUnits = _spawnPos nearObjects _hitRadius;

{
	_random = random 10;
	if(_x isKindOf "Man") then
	{
		if (((_x distance _spawnPos) < _killRadius) && (_random > 1))then
		{
			_x setHit ["legs", 0.9];
			_x setdamage 0.7;
		};
	};

	if(_x isKindOf "Car") then
	{
		if (((_x distance _spawnPos) < _killRadius) && (_random > 1))then
		{
			_x setdamage 0.7;
			sleep 15;
			_x setdamage 1;
		}
		else
		{
			_x setdamage 0.4;
		}
	};

	if(_x isKindOf "Tank") then
	{
		if (((_x distance _spawnPos) < _killRadius) && (_random > 1))then
		{
			_x setdamage 0.7;
			sleep 15;
			_x setdamage 1;
		};
	};
} forEach _targetUnits;
