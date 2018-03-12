////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_LV
//	DATE: 22/12/17
//	VERSION: 1.1
//  DESCRIPTION: Forces the group of the given unit to suppress the given target
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Unit that is injured
//	_this select 1:		OBJECT	- Logic
//	_this select 2:		ARRAY	- Target position given in world position (see getPosWorld)
//  _this select 3:		STRING	- Weapon muzzle to fire
//	_this select 4:		SCALAR	- (optional) Stance index: 0:prone, 1:crouch, 2:stand (1 by default)
//	_this select 5:		BOOL	- (optional) Line up before firing (false by default)
//	_this select 6:		SCALAR	- (optional) Stance index: 0:auto, 1:burst, 2:single, 3:talking guns (0 by default)
//	_this select 7:		SCALAR	- (optional) Duration in sec (20 by default)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,_worldPos, _weaponToFire] call Achilles_fnc_SuppressiveFire; // group goes prone and use automatic fire on target for 10 sec
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define BLACKLIST_WEAPONS ["FakeHorn", "AmbulanceHorn", "TruckHorn", "CarHorn", "SportCarHorn", "BikeHorn", "TruckHorn2", "TruckHorn3", "SmokeLauncher"]

params
[
	["_unit", objNull, [objNull]],
	["_logic", objNull, [objNull]],
	["_targetPos", [0,0,0], [[]], 3],
	["_weaponToFire", 0, [0]],
	["_stanceIndex", 1, [0]],
	["_doLineUp", false, [false]],
	["_fireModeIndex", 0, [0]],
	["_duration", 20, [0]]
];

if (isNull _logic) exitWith {};

private _old_group = group _unit;
private _units = units _old_group;

//create target logic
private _selectedTarget = (createGroup sideLogic) createUnit ["Module_f", [0,0,0], [], 0, "NONE"];
_selectedTarget setPos _targetPos;

//save and remove waypoints
private _current_wp_id = currentWaypoint _old_group;
private _waypoint_count = count waypoints _old_group;
private _waypoints = [];
private "_start_wp_pos";
if (_current_wp_id < _waypoint_count) then
{
	for "_i" from (_waypoint_count - 1) to 1 step -1 do
	{
		_waypoints pushBack
		[
			waypointPosition [_old_group, _i],
			waypointType [_old_group, _i],
			waypointBehaviour [_old_group, _i],
			waypointCombatMode [_old_group, _i],
			waypointFormation [_old_group, _i],
			waypointSpeed [_old_group, _i],
			waypointScript [_old_group, _i]
		];
		deleteWaypoint [_old_group, _i];
	};
	_start_wp_pos = waypointPosition [_old_group, 0];
	[_old_group, 0] setWaypointPosition [position leader _old_group, 0];
	_old_group setCurrentWaypoint [_old_group, 0];
};

// force unit to change formation if not in combat
private _oldFormation = formation _old_group;
if (_doLineUp) then
{
	// set formation
	_old_group setBehaviour "AWARE";
	_units apply {_x setUnitPos "MIDDLE"};
	if (formation _old_group != "LINE") then
	{
		_old_group setFormation "LINE";
		// wait until unit is in formation
		sleep 2;
		waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _units == 0};
	};
	// orientate line perpendicular to target
	_old_group setFormDir (leader _old_group getDir _selectedTarget);
	// wait until unit is in formation
	sleep 2;
	waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _units == 0};
	_units apply {_x setUnitPos "AUTO"};
};

// get rid of vehicle crew except gunner
_units = _units select {gunner vehicle _x == _x};

// store original group in place holder
private _placeholder = _old_group createUnit ["B_Story_Protagonist_F", [0,0,0], [], 0, "NONE"];
_placeholder setPos [0,0,0];

// Talking guns
if (_fireModeIndex == 3) then
{
	[_units, _duration] spawn
	{
		params ["_units", "_duration"];
		_units = _units call BIS_fnc_arrayShuffle;
		private _number_of_switches = round ((_duration + 2) / 2);
		sleep 3;
		for "_i_switch" from 1 to _number_of_switches do
		{
			if (_units isEqualTo []) exitWith {};
			private _unit = _units select (_i_switch mod count _units);
			if (not alive _unit or {isNull _unit}) then
			{
				// remove unit if it is dead or non-existent
				_i_switch = _i_switch - 1;
				_units = _units - [_unit];
			}
			else
			{
				// grant the unit fire
				_unit setVariable ["Achilles_var_fireGranted", true];
				sleep random [1.6,2.0,2.4];
				[_unit] spawn 
				{
					params ["_unit"];
					sleep random [0.0,0.2,0.4];
					_unit setVariable ["Achilles_var_fireGranted", nil];
				};
			};
		};
		{_x setVariable ["Achilles_var_fireGranted", nil]} forEach _units;
	};
// Other modes
} else
{
	{_x setVariable ["Achilles_var_fireGranted", true]} forEach _units;
};

{
	[_x, _units, _selectedTarget, _stanceIndex, _fireModeIndex, _duration, _placeholder, _weaponToFire, _logic] spawn
	{
		params
		[
			"_unit",
			"_units",
			"_target",
			"_stanceIndex",
			"_fireModeIndex",
			"_duration",
			"_placeholder",
			"_weaponToFire",
			"_logic"
		];
		_unit = gunner _unit;

		// Find and make usage of the selected weapon by user.
		private _weapons = [];
		if (isNull objectParent _unit) then
		{
			private _weapon  = primaryWeapon _unit;
			if !(_weapon isEqualTo "") then
			{
				private _muzzleArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles") select {_x != "SAFE"};
				if (count _muzzleArray > 1) then
				{
					{
						private _muzzle = _x;
						if (_muzzle == "this") then
						{
							_weapons pushBack _weapon;
						}
						else
						{
							_weapons pushBack _muzzle;
						};
					} forEach _muzzleArray;
				}
				else
				{
					_weapons pushBack _weapon;
				};
			};
		}
		else
		{
			private _vehicle = vehicle _unit;
			private _turrets = [[-1]];
			_turrets pushBack ((allTurrets _vehicle) select 0);
			{
				{
					if !(_x isEqualTo "" || _x in BLACKLIST_WEAPONS) then
					{
						private _muzzleArray = getArray (configFile >> "CfgWeapons" >> _x >> "muzzles");
						if (count _muzzleArray > 1) then
						{
							{
								_weapons pushBack _x;
							} forEach _muzzleArray;
						}
						else
						{
							_weapons pushBack _x;
						};
					};
				} forEach (_vehicle weaponsTurret _x);
			} forEach _turrets;
		};
		// cease fire if no weapon is not present
		if (_weapons isEqualTo []) exitWith {};
		// cease fire if group mate is too close to line of fire
		if (!([_unit, _target, _units - [_unit], 2] call Achilles_fnc_checkLineOfFire2D)) exitWith {};

		private _old_group = group _placeholder;
		private _aiming = _unit skill "aimingAccuracy";
		_unit setSkill ["aimingAccuracy", 0.2];
		_unit setUnitPos (["DOWN","MIDDLE","UP"] select _stanceIndex);
		// select muzzle
		private _muzzle = if (count _weapons > _weaponToFire) then {_weapons select _weaponToFire} else {_weapons select 0};
		// get fire mode parameters
		private _params = [[10,0],[3,0.7],[1,0.9],[10,0]] select _fireModeIndex;
		_params params ["_fireRepeater", "_ceaseFireTime"];

		private _new_group = createGroup (side _unit);
		[_unit] join _new_group;
		_new_group setBehaviour "COMBAT";

		_unit doWatch objNull;
		_unit doWatch _target;
		_unit doTarget _target;
		_unit doTarget _target;
		_unit lookAt _target;

		if (_fireModeIndex == 3) then
		{
			sleep 3;
		} else
		{
			//ensure asynchronous fire within a group
			sleep (random [2,3,4]);
		};

		// Object is on foot
		if (isNull objectParent _unit) then
		{
			private _fireEh = if (_fireModeIndex == 3) then
			{
				// talking guns: they would reload during the break, but we just give them infinite ammo instead				
				_unit addEventHandler ["Fired", {(_this select 0) setAmmo [_this select 1, 100000]}];
			} else {nil};
			private _reloadEh =_unit addEventHandler ["Reloaded", {(_this select 0) addMagazine (_this select 3 select 0)}];
			
			scopeName "forLoop";
			for "_" from 1 to _duration do
			{
				for "_" from 1 to _fireRepeater do
				{
					if (isNil "_logic" || {isNull _logic}) then {breakOut "forLoop"};
					sleep 0.1;
					if (_unit getVariable ["Achilles_var_fireGranted", false]) then
					{
						[_unit, _muzzle] call BIS_fnc_fire;
					};
				};
				if (_ceaseFireTime > 0) then
				{
					sleep random [_ceaseFireTime-0.3,_ceaseFireTime,_ceaseFireTime+0.3];
				};
			};
			if (_fireModeIndex == 3) then
			{
				_unit removeEventHandler ["Fired", _fireEh];
			};
			_unit removeEventHandler ["Reloaded", _reloadEh];
		}
		else
		{
			private _vehicle = vehicle _unit;
			private _weaponFireRateDelay = getNumber (configFile >> "CfgWeapons" >> _muzzle >> "reloadTime");
			if (_unit == gunner _vehicle) then
			{
				scopeName "forLoop";
				for "_" from 0 to _duration do
				{
					for "_" from 1 to _fireRepeater do
					{
						if (isNil "_logic" || {isNull _logic}) then {breakOut "forLoop"};
						_unit lookAt _target;
						sleep _weaponFireRateDelay;
						if (_unit getVariable ["Achilles_var_fireGranted", false]) then
						{
							// _unit fireAtTarget [_vehicle, _muzzle]; // Needs a _turret argument
							[_vehicle, _muzzle] call BIS_fnc_fire;
						};
					};
					sleep _ceaseFireTime;
					_vehicle setVehicleAmmo 1;
				};
			};
		};
		_unit setSkill ["aimingAccuracy", _aiming];
		_unit setUnitPos "AUTO";
		_units joinSilent _old_group;
		_old_group setBehaviour "AWARE";
		deleteVehicle _placeholder;
		_unit setVariable ["Achilles_var_suppressiveFire_ready", true];
	};
} forEach _units;

//clean up
// Wait untill all units are ready (have done their task or the module has been deleted)
waitUntil {sleep 1; {_x getVariable ["Achilles_var_suppressiveFire_ready", false]} forEach _units};
sleep 3;
{_x setVariable ["Achilles_var_fireGranted", nil]} forEach _units;
{_x setVariable ["Achilles_var_suppressiveFire_ready", nil]} forEach _units;
deleteVehicle _selectedTarget;
if (!isNull _old_group) then {_old_group setFormation _oldFormation};
[] spawn {{deleteGroup _x} forEach (allGroups select {units _x isEqualTo []})};
if (count _waypoints > 0 and !(isNull _old_group)) then
{
	reverse _waypoints;
	{
		private _wp = _old_group addWaypoint [_x select 0, 0];
		_wp setWaypointType (_x select 1);
		_wp setWaypointBehaviour (_x select 2);
		_wp setWaypointCombatMode (_x select 3);
		_wp setWaypointFormation (_x select 4);
		_wp setWaypointSpeed (_x select 5);
		_wp setWaypointScript (_x select 6);
	} forEach _waypoints;
	[_old_group, 0] setWaypointPosition [_start_wp_pos, 0];
	_old_group setCurrentWaypoint [_old_group, _current_wp_id];
};
