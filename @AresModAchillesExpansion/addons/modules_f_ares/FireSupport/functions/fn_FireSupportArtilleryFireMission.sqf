////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: 		Anton Struyk, Kex, CreepPork_LV
//	DATE: 			3/16/17
//	VERSION: 		AMAE004
//  DESCRIPTION: 	Function for "artillery fire mission" module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.h"

private ["_objects","_guns","_rounds","_ammo","_targetPos", "_artilleryAmmoDisplayName", "_ammoSelectedDisplayName", "_precision"];

_objects = nearestObjects [(_this select 0), ["All"], 150, true];

/**
 * Group by type. The structure of batteries is
 * [
 *   ["Type name", [Unit1, unit2, ...], [ammotype1, ammotype2, ...]],
 *   ["Type name", [Unit1, unit2, ...], [ammotype1, ammotype2, ...]]
 * ]
 */
private _batteries = [];
{
	if (_x isKindOf "B_Ship_MRLS_01_base_F") then
	{
		// handle VLS
		_ammo = magazines _x;
	}
	else
	{
		_ammo = getArtilleryAmmo [_x];
	};
	if (count _ammo > 0) then
	{
		private _type = getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
		private _alreadyContained = count (_batteries select {_x find _type > -1}) > 0;

		if (!_alreadyContained) then
		{
			_batteries pushBack [_type, [_x], _ammo];
		}
		else
		{
			private _unit = _x;
			{
				private _battery = _x;
				private _units = _battery select 1;
				private _unitType = getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");

				if (_unitType == (_battery select 0)) then { _units pushBack _unit };
			} forEach _batteries;
		};
	};
} forEach _objects;

// pick battery
if (_batteries isEqualTo []) exitWith { [localize "STR_AMAE_NO_NEARBY_ARTILLERY_UNITS"] call Ares_fnc_ShowZeusMessage; };
private _batteryTypes = _batteries apply {_x select 0};

// Pick a battery
private _pickBatteryResult = [
	localize "STR_AMAE_SELECT_BATTERY_TO_FIRE",
	[
		[localize "STR_AMAE_BATTERY", _batteryTypes],
		[format [localize "STR_AMAE_TARGET", " "],[localize "STR_AMAE_MARKER",localize "STR_AMAE_GRID"]]
	]] call Ares_fnc_ShowChooseDialog;
if (_pickBatteryResult isEqualTo []) exitWith {};
private _battery = _batteries select (_pickBatteryResult select 0);
private _mode = _pickBatteryResult select 1;

// Pick fire mission details
private _fireMission = nil;
_battery params ["_", "_units", "_artilleryAmmo"];
private _firstUnit = _units param [0, objNull];
private _isVLS = _firstUnit isKindOf "B_Ship_MRLS_01_base_F";
private _artilleryAmmoDisplayName = _artilleryAmmo apply {getText (configFile >> "CfgMagazines" >> _x >> "displayName")};

private _numberOfGuns = [];
{
	_numberOfGuns pushBack (str (_forEachIndex + 1));
} forEach _units;

private _selectedTarget = objNull;
if (_mode == 0) then
{
	private _allTargetsUnsorted = allMissionObjects "Achilles_Create_Universal_Target_Module";
	if (_allTargetsUnsorted isEqualTo []) exitWith {[localize "STR_AMAE_NO_TARGET_MARKER"] call Achilles_fnc_ShowZeusErrorMessage};
	private _allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
	private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
    _targetChoices append (_allTargets apply {name _x});

	// pick guns, rounds, ammo and coordinates
	private _pickFireMissionResult = [
		format ["%1 (%2)",localize "STR_AMAE_ARTILLERY_FIRE_MISSION",localize "STR_AMAE_MARKER"],
		[
			[localize "STR_AMAE_NUMBER_OF_UNITS_INVOLVED", _numberOfGuns],
			[localize "STR_AMAE_ROUNDS", "", "1"],
			[localize "STR_AMAE_FS_AMMO", _artilleryAmmoDisplayName],
			[format [localize "STR_AMAE_TARGET"," "], _targetChoices, 1],
			[localize "STR_AMAE_PRECISION", "", "0"]
		]] call Ares_fnc_ShowChooseDialog;

	if (_pickFireMissionResult isEqualTo []) exitWith {};
	// TODO: Add validation that coordinates are actually numbers.
	_guns = parseNumber (_numberOfGuns select (_pickFireMissionResult select 0));
	_rounds = parseNumber (_pickFireMissionResult select 1);
	_ammo = (_artilleryAmmo select (_pickFireMissionResult select 2));
	_ammoSelectedDisplayName = (_artilleryAmmoDisplayName select (_pickFireMissionResult select 2));
	_precision = parseNumber (_pickFireMissionResult select 4);

	private _targetChooseAlgorithm = _pickFireMissionResult select 3;

	// Make sure we only consider targets that are in range.
	private _targetsInRange = if (_isVLS) then
	{
		_allTargets
	}
	else
	{
		_allTargets select {(position _x) inRangeOfArtillery [[_units select 0], _ammo]}
	};
	
	if (count _targetsInRange > 0) then
	{
		// Choose a target to fire at
		_selectedTarget = switch (_targetChooseAlgorithm) do
		{
			case 0: // Random
			{
				_targetsInRange call BIS_fnc_selectRandom;
			};
			case 1: // Nearest
			{
				[position _logic, _targetsInRange] call Ares_fnc_GetNearest;
			};
			case 2: // Furthest
			{
				[position _logic, _targetsInRange] call Ares_fnc_GetFarthest;
			};
			default // Specific target
			{
                _allTargets select (_targetChooseAlgorithm - 3);
			};
		};
		_targetPos = position _selectedTarget;
	};
} else
{
	// pick guns, rounds, ammo and coordinates
	private _pickFireMissionResult = [
		format ["%1 (%2)",localize "STR_AMAE_ARTILLERY_FIRE_MISSION",localize "STR_AMAE_GRID"],
		[
			[localize "STR_AMAE_NUMBER_OF_UNITS_INVOLVED", _numberOfGuns],
			[localize "STR_AMAE_ROUNDS", "", "1"],
			[localize "STR_AMAE_FS_AMMO", _artilleryAmmoDisplayName],
			[localize "STR_AMAE_GRID_EAST_WEST_XXX", "","000"],
			[localize "STR_AMAE_GRID_NORTH_SOUTH_XXX", "","000"],
			[localize "STR_AMAE_PRECISION", "", "0"]
		]] call Ares_fnc_ShowChooseDialog;

	if (_pickFireMissionResult isEqualTo []) exitWith {};
	// TODO: Add validation that coordinates are actually numbers.
	_guns = parseNumber (_numberOfGuns select (_pickFireMissionResult select 0));
	_rounds = parseNumber (_pickFireMissionResult select 1);
	_ammo = (_artilleryAmmo select (_pickFireMissionResult select 2));
	_ammoSelectedDisplayName = (_artilleryAmmoDisplayName select (_pickFireMissionResult select 2));
	private _targetX = _pickFireMissionResult select 3;
	private _targetY = _pickFireMissionResult select 4;
	_targetPos = [_targetX,_targetY] call CBA_fnc_mapGridToPos;
	_precision = parseNumber (_pickFireMissionResult select 5);
};

if (isNil "_targetPos") exitWith {[localize "STR_AMAE_NO_TARGET_IN_RANGE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

private _roundEta = 99999;
// Generate a list of the actual units to fire.
private _gunsToFire = _units select [0, _guns];
if (_isVLS) then
{
	// handle VLS
	private _weaponClass = (weapons _firstUnit) param [0,""];
	private _missileClass = getText (configfile >> "CfgMagazines" >> _ammo >> "ammo");
	private _missileMaxSpeed = getNumber (configfile >> "CfgAmmo" >> _missileClass >> "maxSpeed");
	private _reloadTime = getNumber (configFile >> "cfgWeapons" >> _weaponClass >> "reloadTime");
	private _magazineReloadTime = (1.3*getNumber (configfile >> "CfgWeapons" >> _weaponClass >> "magazineReloadTime"));
	_roundEta = _roundEta min ((_targetPos distance _firstUnit) / _missileMaxSpeed);
	{
		[_x, _weaponClass, _ammo, _rounds, _roundEta, _reloadTime, _magazineReloadTime, _targetPos, _selectedTarget, _precision] spawn
		{
			params ["_unit", "_weaponClass", "_ammo", "_rounds", "_roundEta", "_reloadTime", "_magazineReloadTime", "_targetPos", "_selectedTarget", "_precision"];
			// switch the magazine if needed
			if (_unit currentMagazineTurret [0] != _ammo) then
			{
				[_unit, [[0], _weaponClass, _ammo]] remoteExecCall ["loadMagazine", _unit];
				sleep _magazineReloadTime;
			};
			// create and reveal the target
			private _theta = random 360;
			private _deviation = [sin _theta, cos _theta, 0] vectorMultiply (random _precision);
			private _target = (createGroup sideLogic) createUnit ["module_f", _targetPos vectorAdd _deviation, [], 0, "CAN_COLLIDE"];
			if !(isNull _selectedTarget) then
			{
				_target attachTo [_selectedTarget, _deviation];
			};
			[side _unit, [_target, ((1.3 * _roundEta) max 10) + _reloadTime*_rounds]] remoteExecCall ["reportRemoteTarget", _unit];
			// fire the rounds
			for "_i" from 1 to _rounds do
			{
				[_unit, [gunner _unit, _weaponClass, 0]] remoteExecCall ["setWeaponReloadingTime", _unit];
				[_unit, [_target]] remoteExecCall ["fireAtTarget", _unit];
				sleep _reloadTime;
			};
			sleep ((1.3 * _roundEta) max 10);
			detach _target;
			deleteVehicle _target;
		};
	} forEach _gunsToFire;
}
else
{
	// handle artillery

	// Get the ETA and exit if any one of the guns can't reach the target.
	{
		_roundEta = _roundEta min (_x getArtilleryETA [_targetPos, _ammo]);
	} forEach _gunsToFire;
	if (_roundEta == -1) exitWith { [localize "STR_AMAE_NO_TARGET_IN_RANGE"] call Ares_fnc_ShowZeusMessage; };

	// Fire the guns
	{
		private _theta = random 360;
		private _deviation = [sin _theta, cos _theta, 0] vectorMultiply (random _precision);
		[_x, [_targetPos vectorAdd _deviation, _ammo, _rounds]] remoteExecCall ["commandArtilleryFire", _x];
	} forEach _gunsToFire;
};
[localize "STR_AMAE_FIRE_ROUNDS_AND_ETA", _rounds, _ammoSelectedDisplayName, _roundEta] call Ares_fnc_ShowZeusMessage;


#include "\achilles\modules_f_ares\module_footer.h"
