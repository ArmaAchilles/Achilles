////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_LV
//	DATE: 22/12/17
//	VERSION: 1.1
//  DESCRIPTION: Forces the group of the given unit to suppress the given target
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Unit that is injured
//	_this select 1:		OBJECT 	- Target game logic
//  _this select 2:		SCALAR	- (optional) weapon index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
//  _this select 3:		SCALAR	- (optional) muzzle index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
//  _this select 4:		SCALAR	- (optional) magazine index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines) (0 by default)
//	_this select 5:		SCALAR	- (optional) Stance index: 0:auto, 1:burst, 2:single, 3:talking guns (0 by default)
//	_this select 6:		SCALAR	- (optional) Stance index: 0:prone, 1:crouch, 2:stand (1 by default)
//	_this select 7:		BOOL	- (optional) Line up before firing (false by default)
//	_this select 8:		SCALAR	- (optional) Duration in sec (20 by default)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,_targetLogic] call Achilles_fnc_suppressiveFire; // group goes prone and use automatic fire on target for 20 sec
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_unit", objNull, [objNull]],
	["_targetLogic", objNull, [objNull]],
	["_weapIdx", 0, [0]],
	["_muzzleIdx", 0, [0]],
	["_magIdx", 0, [0]],
	["_fireModeIndex", 0, [0]],
	["_stanceIndex", 1, [0]],
	["_doLineUp", false, [false]],
	["_duration", 20, [0]]
];

// exit if objNull was passed
if ((isNull _targetLogic) or {isNull _unit}) exitWith {};
// exit if the unid is already suppressing
if (not (_unit getVariable ["Achilles_var_suppressiveFire_ready", true])) exitWith {};

private _old_group = group _unit;
private _allUnits = units _old_group;

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
	_allUnits apply {_x setUnitPos "MIDDLE"};
	if (formation _old_group != "LINE") then
	{
		_old_group setFormation "LINE";
		// wait until unit is in formation
		sleep 2;
		waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _allUnits == 0};
	};
	// orientate line perpendicular to target
	_old_group setFormDir (leader _old_group getDir _targetLogic);
	// wait until unit is in formation
	sleep 2;
	waitUntil {sleep 1; {(speed _x > 0) and (alive _x)} count _allUnits == 0};
	_allUnits apply {_x setUnitPos "AUTO"};
};

// select gunners
// in case of a vehicle: replace crew by the vehicle
private _i = 0;
private _filteredUnits = +_allUnits;
while {count _filteredUnits > _i} do
{
	private _unit = _filteredUnits select _i;
	if (not isNull objectParent _unit) then
	{
		private _vehicle = vehicle _unit;
		_filteredUnits = [_vehicle] + (_filteredUnits - crew _vehicle);
	};
	_i = _i + 1;
};

// store original group in place holder
private _placeholder = _old_group createUnit ["B_Story_Protagonist_F", [0,0,0], [], 0, "NONE"];
_placeholder setPos [0,0,0];

// Talking guns
if (_fireModeIndex == 3) then
{
	[_filteredUnits, _duration] spawn
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
	{_x setVariable ["Achilles_var_fireGranted", true]} forEach _filteredUnits;
};

{
	[_x, _filteredUnits, _stanceIndex, _fireModeIndex, _duration, _weapIdx, _muzzleIdx, _magIdx, _targetLogic] spawn
	{
		params
		[
			"_unit",
			"_filteredUnits",
			"_stanceIndex",
			"_fireModeIndex",
			"_duration",
			"_weapIdx",
			"_muzzleIdx",
			"_magIdx",
			"_targetLogic"
		];
		// unit is suppressing: prevents applying the module multiple times
		_unit setVariable ["Achilles_var_suppressiveFire_ready", false];
		// get the vehicle
		private _vehicle = objNull;
		if (not (_unit isKindOf "Man")) then {_vehicle = _unit};
		
		// get weapon, muzzle, magazine info and unpack it
		private _weaponsAndMuzzlesAndMagazines = [_unit] call Achilles_fnc_getWeaponsMuzzlesMagazines;
		// cease fire if no weapon is not present
		if (_weaponsAndMuzzlesAndMagazines isEqualTo []) exitWith {_unit setVariable ["Achilles_var_suppressiveFire_ready", true]};
		if (count _weaponsAndMuzzlesAndMagazines <= _weapIdx) then {_weapIdx = 0};
		(_weaponsAndMuzzlesAndMagazines select _weapIdx) params [["_weaponAndTurret","",["",[]]], ["_muzzlesAndMagazines",[""],[[]]]];
		// get the weapon and gunner
		_weaponAndTurret params [["_weapon","",[""]], ["_turretPath",[],[[]]]];
		private _gunner = if (_turretPath isEqualTo []) then {_unit} else {_vehicle turretUnit _turretPath};
		// cease fire if group mate is too close to line of fire
		if (not ([_gunner, _targetLogic, _filteredUnits - [_unit], 2] call Achilles_fnc_checkLineOfFire2D)) exitWith {_unit setVariable ["Achilles_var_suppressiveFire_ready", true]};
		// get the muzzle and magazines
		if (count _muzzlesAndMagazines <= _muzzleIdx) then {_muzzleIdx = 0};
		(_muzzlesAndMagazines select _muzzleIdx) params [["_muzzle","",[""]], ["_magazines",[""],[[]]]];
		if (count _magazines <= _magIdx) then {_magIdx = 0};
		private _magazine = _magazines select _magIdx;
		// get the correct muzzle
		private _muzzleCfg = configNull;
		if (_muzzle == "this") then
		{
			_muzzle = _weapon;
			_muzzleCfg = (configFile >> "CfgWeapons" >> _weapon);
		}
		else
		{
			_muzzleCfg = (configFile >> "CfgWeapons" >> _weapon >> _muzzle);
		};	
		// get the weapon mode
		private _mode = "this";
		if (isNull _vehicle) then
		{
			_gunner selectWeapon _muzzle; 
			_mode = (weaponState _gunner) select 2;
		}
		else
		{
			_vehicle selectWeaponTurret [_muzzle, _turretPath];
			_mode = (weaponState [_vehicle, _turretPath, _weapon])select 2;
		};
		// get the reload time
		private _reloadTime = 0.1;
		if (_mode == "this") then
		{
			_reloadTime = getNumber (_muzzleCfg >> "reloadTime");
		}
		else
		{
			_reloadTime = getNumber (_muzzleCfg >> _mode >> "reloadTime");
		};
		
		// adjust skill for more spread
		private _aiming = _gunner skill "aimingAccuracy";
		_gunner setSkill ["aimingAccuracy", 0.2];
		_gunner setUnitPos (["DOWN","MIDDLE","UP"] select _stanceIndex);
		// select muzzle and the corresponding turret
		// get fire mode parameters
		private _params = [[10,0],[3,0.7],[1,0.9],[10,0]] select _fireModeIndex;
		_params params ["_repeatFireCount", "_ceaseFireTime"];
		// move gunner to a new group
		private _new_group = createGroup (side _gunner);
		[_gunner] join _new_group;
		_new_group setBehaviour "COMBAT";
		
		// this looks ugly, because working with AI is a pain in the neck
		_gunner lookAt objNull;
		_gunner doWatch objNull;
		_gunner doWatch _targetLogic;
		_gunner lookAt _targetLogic;
		_gunner lookAt _targetLogic;
		_gunner doTarget _targetLogic;
		_gunner doTarget _targetLogic;
		
		// delay for targeting
		if (_fireModeIndex == 3) then
		{
			sleep 3;
		}
		else
		{
			// ensure asynchronous fire within a group
			sleep (random [3,4,5]);
		};
		
		// add event handlers to non-vehicles
		private _fireEh = if ((isNull _vehicle) and {_fireModeIndex == 3}) then
		{
			// talking guns: they would reload during the break, but we just give them infinite ammo instead				
			_gunner addEventHandler ["Fired", {(_this select 0) setAmmo [_this select 1, 100000]}];
		} else {nil};
		private _reloadEh = if (isNull _vehicle) then
		{
			// give the soldier infinite reloads
			_gunner addEventHandler ["Reloaded", {(_this select 0) addMagazine (_this select 3 select 0)}];
		};
		
		// now let's suppress the enemy!
		scopeName "whileLoop";
		private _startTime = time;
		while {(time < _startTime + _duration) and {alive _gunner} and {alive _targetLogic}} do
		{
			// fire the weapon for _repeatFireCount times
			for "_" from 1 to _repeatFireCount do
			{
				if ((_unit getVariable ["Achilles_var_fireGranted", false]) and {time < _startTime + _duration} and {alive _gunner} and {alive _targetLogic}) then
				{
					// fire the weapon and wait for the next shot
					private _ammoRemained = [_targetLogic, _gunner, _muzzle, _magazine, _vehicle, _turretPath] call Achilles_fnc_forceWeaponFire;
					if (_ammoRemained isEqualTo -1) exitWith {breakOut "whileLoop"};
					if (_ammoRemained > 0) then
					{
						sleep _reloadTime;
					}
					else
					{
						// Reloading is buggy, especially for GLs...
						// this delay ensures that reloading works more or less properly
						sleep 2;
						_gunner setAmmo [_muzzle, 1E6];
					};
				};
			};
			// cease the fire (for semi-auto and burst)
			if (_ceaseFireTime > 0) then
			{
				sleep random [_ceaseFireTime-0.3,_ceaseFireTime,_ceaseFireTime+0.3];
			};
			if (not isNull _vehicle) then
			{
				_vehicle setVehicleAmmo 1;
			};
		};
		
		// remove the event handlers and reset behaviour
		if (isNull _vehicle) then
		{
			_gunner removeEventHandler ["Reloaded", _reloadEh];
			if (_fireModeIndex == 3) then
			{
				_gunner removeEventHandler ["Fired", _fireEh];
			};
		};
		_gunner lookAt objNull;
		_gunner doWatch objNull;
		_gunner setSkill ["aimingAccuracy", _aiming];
		_gunner setUnitPos "AUTO";
		// we are done!
		_unit setVariable ["Achilles_var_suppressiveFire_ready", true];
	};
} forEach _filteredUnits;

//clean up
// Wait untill all units are ready (have done their task or the module has been deleted)
waitUntil {sleep 1; {alive _x and not (_x getVariable ["Achilles_var_suppressiveFire_ready", false])} count _filteredUnits == 0};
// unset variables
{_x setVariable ["Achilles_var_fireGranted", nil]} forEach _filteredUnits;
{_x setVariable ["Achilles_var_suppressiveFire_ready", nil]} forEach _filteredUnits;
// move gunners back to old group and reset group behaviour
_filteredUnits joinSilent _old_group;
_old_group setFormation _oldFormation;
_old_group setBehaviour "AWARE";
// delete the empty groups
[] spawn {{deleteGroup _x} forEach (allGroups select {units _x isEqualTo []})};
// add the waypoints back
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
// delete the group placeholder
deleteVehicle _placeholder;

