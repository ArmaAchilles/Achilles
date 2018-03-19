////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_LV
//	DATE: 22/12/17
//	VERSION: 1.1
//  DESCRIPTION: Forces the group of the given unit to suppress the given target
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Unit that is injured
//	_this select 1:		OBJECT or 3D POSITION	- Target logic or position
//  _this select 2:		STRING	- Weapon muzzle to fire
//	_this select 3:		SCALAR	- (optional) Stance index: 0:prone, 1:crouch, 2:stand (1 by default)
//	_this select 4:		BOOL	- (optional) Line up before firing (false by default)
//	_this select 5:		SCALAR	- (optional) Stance index: 0:auto, 1:burst, 2:single, 3:talking guns (0 by default)
//	_this select 6:		SCALAR	- (optional) Duration in sec (20 by default)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,_worldPos, _muzzleIdxToFire] call Achilles_fnc_SuppressiveFire; // group goes prone and use automatic fire on target for 10 sec
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define BLACKLIST_WEAPONS ["FakeHorn", "AmbulanceHorn", "TruckHorn", "CarHorn", "SportCarHorn", "BikeHorn", "TruckHorn2", "TruckHorn3", "SmokeLauncher"]

params
[
	["_unit", objNull, [objNull]],
	["_target", objNull, [objNull,[]], 3],
	["_muzzleIdxToFire", 0, [0]],
	["_stanceIndex", 1, [0]],
	["_doLineUp", false, [false]],
	["_fireModeIndex", 0, [0]],
	["_duration", 20, [0]]
];

// exit if objNull was passed
if (_target isEqualTo objNull) exitWith {};

// assign target logic, position and cease fire condition
private _targetLogic = objNull;
private _targetPos = [0,0,0];
private _condition = {false};
if (_target isEqualType objNull) then
{
	_targetLogic = _target;
	_targetPos = position _targetLogic;
	// cease fire condition: if unit or logic is dead
	_condition = {{alive _x} count _this < count _this};
}
else
{
	_targetPos = _target;
	// cease fire condition: if unit is dead
	_condition = {not alive param[0]};
};

private _old_group = group _unit;
private _units = units _old_group;

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

// select gunners
// in case of a vehicle: replace crew by the vehicle
private _i = 0;
private _gunners = +_units;
while {count _gunners > _i} do
{
	private _gunner = _gunners select _i;
	if (not isNull objectParent _unit) then
	{
		private _vehicle = vehicle _gunner;
		_gunners = [_vehicle] + (_gunners - crew _vehicle);
	};
	_i = _i + 1;
} forEach _gunners;

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
	[_x, _gunners, _targetPos, _stanceIndex, _fireModeIndex, _duration, _muzzleIdxToFire, _targetLogic, _condition] spawn
	{
		params
		[
			"_gunner",
			"_gunners",
			"_targetPos",
			"_stanceIndex",
			"_fireModeIndex",
			"_duration",
			"_muzzleIdxToFire",
			"_targetLogic",
			"_condition"
		];
		
		// Get all muzzles.
		private _weapons = [];
		private _muzzles = [];
		private _turrets = [];
		if (_gunner isKindOf "Man") then
		{
			// case: gunner is a soldier
			private _weapon  = primaryWeapon _gunner;
			if !(_weapon isEqualTo "") then
			{
				private _muzzleArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles") select {_x != "SAFE"};
				{
					private _muzzle = _x;
					if (_muzzle == "this") then
					{
						_muzzles pushBack _weapon;
					}
					else
					{
						_muzzles pushBack _muzzle;
					};
					_weapons pushBack _weapon;
				} forEach _muzzleArray;
			};
		}
		else
		{
			// case: gunner is a vehicle
			{
				private _turretPath = _x;
				if (not isNull (_unit turretUnit _turretPath)) then
				{
					{
						private _weapon = _x;
						if !(_weapon isEqualTo "" || _weapon in BLACKLIST_WEAPONS) then
						{
							private _configEntry = configFile >> "CfgWeapons" >> _weapon;
							private _muzzleArray = getArray (_configEntry >> "muzzles");
							{
								private _muzzle = _x;
								if (_muzzle isEqualTo "this") then
								{
									_muzzles pushBack _weapon;
								}
								else
								{
									_muzzles pushBack _muzzle;
								};
								_weapons pushBack _weapon;
								_turrets pushBack _turretPath;
							} forEach _muzzleArray;
						};
					} forEach (_unit weaponsTurret _turretPath);
				};
			} forEach ([[-1]] + (allTurrets _unit));
		};
		// cease fire if no weapon is not present
		if (_muzzles isEqualTo []) exitWith {};
		// cease fire if group mate is too close to line of fire
		if (!([_unit, _target, _units - [_unit], 2] call Achilles_fnc_checkLineOfFire2D)) exitWith {};

		private _old_group = group _placeholder;
		private _aiming = _unit skill "aimingAccuracy";
		_unit setSkill ["aimingAccuracy", 0.2];
		_unit setUnitPos (["DOWN","MIDDLE","UP"] select _stanceIndex);
		// if muzzle index is out of range, then set it to 0
		if (count _muzzles <= _muzzleIdxToFire) then {_muzzleIdxToFire = 0};
		// select muzzle and the corresponding turret
		private _weapon = _weapons select _muzzleIdxToFire;
		private _muzzle = _muzzles select _muzzleIdxToFire;
		private _turret = if (count _turrets > 0) then {_turrets select _muzzleIdxToFire} else {[]};
		private _weaponFireRateDelay = 0.05 + getNumber (configFile >> "CfgWeapons" >> _weapon >> "reloadTime");
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
		
		deleteVehicle _placeholder;
		_unit setVariable ["Achilles_var_suppressiveFire_ready", true];
	};
} forEach _units;

//clean up
// Wait untill all units are ready (have done their task or the module has been deleted)
waitUntil {sleep 1; {alive _x and not (_x getVariable ["Achilles_var_suppressiveFire_ready", false])} count _gunners == 0};
sleep 3;
// unset variables
{_x setVariable ["Achilles_var_fireGranted", nil]} forEach _gunners;
{_x setVariable ["Achilles_var_suppressiveFire_ready", nil]} forEach _gunners;

_units joinSilent _old_group;
_old_group setFormation _oldFormation;
_old_group setBehaviour "AWARE";
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
