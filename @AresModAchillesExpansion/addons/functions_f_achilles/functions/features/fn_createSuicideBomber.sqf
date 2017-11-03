/*
	Author: CreepPork_LV, shay_gman, Anton Struyk, Kex

	Description:
	Sets a unit to be a suicide bomber.

  Parameters:
    _this select: 0 - OBJECT - Person to be a Suicide Bomber
    _this select: 1 - NUMBER - Explosion Size
    _this select: 2 - NUMBER - Explosion Effect
    _this select: 3 - [SIDE] - Activation Side
	_this select: 4 - STRING - Patrol Radius
	_this select: 5 - STRING - Activation Distance
	_this select: 6 - BOOL - Add Vest

	Returns:
		Nothing
*/

params["_bomber", "_explosionSize", "_explosionEffect", "_activationSide", "_patrolRadius", "_activationDistance", "_addVest"];

_patrolRadius = parseNumber _patrolRadius;
_activationDistance = parseNumber _activationDistance;

if (typeName _activationSide == typeName sideLogic) then {_activationSide = [_activationSide];};

private _hasSpoken = false;
private _targets = ["Car", "Tank", "Man"];

removeAllWeapons _bomber;

private _dummyObject = "Land_HelipadEmpty_F" createVehicle (getPos _bomber);
_dummyObject attachTo [_bomber,[0,0,0]];

private _bomberGroup = group _bomber;
_bomberGroup setBehaviour "CARELESS";
_bomberGroup setSpeedMode "LIMITED";

if (_addVest) then
{
	removeVest _bomber;
	_bomber addVest "V_HarnessO_brn";
};

if (_patrolRadius > 0) then
{
	private _numberOfWaypoints = 6;
	private _degreesPerWaypoint = 360 / _numberOfWaypoints;
	private _centerPoint = position _bomber;
	for "_waypointNumber" from 0 to (_numberOfWaypoints - 1) do
	{
		private _currentDegrees = _degreesPerWaypoint * _waypointNumber;
		private _waypoint = _bomberGroup addWaypoint [[_centerPoint, _patrolRadius, _currentDegrees] call Bis_fnc_relPos, 5];
	};
	private _waypoint = _bomberGroup addWaypoint [[_centerPoint, _patrolRadius, 0] call BIS_fnc_relPos, 5];
	_waypoint setWaypointType "CYCLE";
};

private _check = true;

while {alive _bomber && _check} do
{
    sleep 1;
		private _nearestObjects = (getPos _bomber) nearObjects 100;

		if ({side _x in _activationSide} count _nearestObjects > 0) then
		{
			while {(alive _bomber) && (_check)} do
			{
				sleep 1;
				private _nearestUnit = [];
				{if (side _x in _activationSide) then {_nearestUnit pushBack _x}} forEach _nearestObjects;
				private _count = count _nearestUnit;

				for "_x" from 0 to _count-1 step 1 do
				{
					private _enemyUnit = _nearestUnit select _x;
					{
						if (_enemyUnit isKindOf _x && alive _enemyUnit) then
						{
							_bomber setSkill 1;
							_bomber doMove (getPos _enemyUnit);
							sleep 5 + random 5;
							if ((_bomber distance _enemyUnit) < 40) then
							{
								_bomberGroup setSpeedMode "FULL";
								_bomberGroup setBehaviour "CARELESS";
								_bomber setUnitPos "UP";
								_bomber disableAI "TARGET";
								_bomber disableAI "AUTOTARGET";

								_bomberGroup setCombatMode "BLUE";
								_bomberGroup allowFleeing 0;
								while {alive _bomber} do
								{
									sleep 1;
									_bomber doMove (getPos _enemyUnit);
									_bomber addRating -10000;

									if (!_hasSpoken) then
									{
										private _selectedMessage = selectRandom ["Allahu Akbar!", "Death to infidels!", "You are all coming with me!", "You all will pay with your blood!"];
										[_bomber, _selectedMessage] remoteExec ["globalChat", 0, false];
										_hasSpoken = true;
									};
								if ((_bomber distance _enemyUnit) <= _activationDistance) exitWith
								{
									_check = false;
									if (alive _bomber) then
									{
										switch (_explosionEffect) do
										{
											case 0:
											{
												[getPos _bomber, _explosionSize] call Achilles_fnc_deadlyExplosion;
												_bomber setDamage 1;
											};
											case 1:
											{
											[getPos _bomber, _explosionSize] call Achilles_fnc_disablingExplosion;
												_bomber setDamage 1;
											};
											case 2:
											{
												[getPos _bomber] call Achilles_fnc_fakeExplosion;
												_bomber setDamage 1;
											};
										};
									};
								};
							};
						};
					};
				} forEach _targets;
			};
		};
	};
};

{
	deleteWaypoint [_bomberGroup, _forEachIndex];
} forEach (waypoints _bomberGroup);

deleteVehicle _dummyObject;
