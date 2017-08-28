////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: 		Anton Struyk, Kex, CreepPork_LV
//	DATE: 			3/16/17
//	VERSION: 		AMAE004
//  DESCRIPTION: 	Function for "artillery fire mission" module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private ["_objects","_guns","_rounds","_ammo","_targetPos", "_artilleryAmmoDisplayName", "_ammoSelectedDisplayName"];

_objects = nearestObjects [(_this select 0), ["All"], 150, true];

// Filter for artillery
_filteredObjects = [];
{
	_ammo = getArtilleryAmmo [_x];
	if (count _ammo > 0) then
	{
		_filteredObjects pushBack _x;
	};

} forEach _objects;


/**
 * Group by type. The structure of batteries is
 * [
 *   ["Type name", [Unit1, unit2, ...], [ammotype1, ammotype2, ...]],
 *   ["Type name", [Unit1, unit2, ...], [ammotype1, ammotype2, ...]]
 * ]
 */
_batteries = [];
{
	_type = getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
	_alreadyContained = false;
	{
		if (_x find _type > -1) then
		{
			_alreadyContained = true;
		};
	} forEach _batteries;

	if (!_alreadyContained) then
	{
		_ammo = getArtilleryAmmo [_x];
		_batteries pushBack [_type, [_x], _ammo];
	}
	else
	{
		_unit = _x;
		{
			_battery = _x;
			_units = _battery select 1;
			_unitType = getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");

			if (_unitType == (_battery select 0)) then
			{
			  _units pushBack _unit;
			};

		} forEach _batteries;
	};

} forEach _filteredObjects;

// pick battery
_batteryTypes = [];
{
	_batterytypes pushBack (_x select 0);
} forEach _batteries;
if (count _batteries == 0) exitWith { [localize "STR_NO_NEARBY_ARTILLERY_UNITS"] call Ares_fnc_ShowZeusMessage; };

// Pick a battery
_pickBatteryResult = [
		localize "STR_SELECT_BATTERY_TO_FIRE",
		[
			[localize "STR_BATTERY", _batteryTypes],
			[format [localize "STR_TARGET", " "],[localize "STR_MARKER",localize "STR_GRID"]]
		]] call Ares_fnc_ShowChooseDialog;
if (count _pickBatteryResult == 0) exitWith {};
_battery = _batteries select (_pickBatteryResult select 0);
_mode = _pickBatteryResult select 1;

// Pick fire mission details
_fireMission = nil;
_units = _battery select 1;
_artilleryAmmo = _battery select 2;

_artilleryAmmoDisplayName = [];
{
	_artilleryAmmoDisplayName pushBack (getText (configFile >> "CfgMagazines" >> _x >> "displayName"));
} forEach (_battery select 2);
diag_log _artilleryAmmoDisplayName;

_numberOfGuns = [];
{
	_numberOfGuns pushBack (str (_forEachIndex + 1));
} forEach _units;

if (_mode == 0) then
{
	_allTargetsUnsorted = allMissionObjects "Ares_Create_Artillery_Target_Module";
	if (count _allTargetsUnsorted == 0) exitWith {[localize "STR_NO_TARGET_MARKER"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
	_allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
	_targetChoices = [localize "STR_RANDOM", localize "STR_NEAREST", localize "STR_FARTHEST"];
	{
		_targetChoices pushBack (name _x);
	} forEach _allTargets;

	// pick guns, rounds, ammo and coordinates
	_pickFireMissionResult = [
		format ["%1 (%2)",localize "STR_ARTILLERY_FIRE_MISSION",localize "STR_MARKER"],
		[
			[localize "STR_NUMBER_OF_UNITS_INVOLVED", _numberOfGuns],
			[localize "STR_ROUNDS", ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]],
			[localize "STR_AMMO", _artilleryAmmoDisplayName],
			[format [localize "STR_TARGET"," "], _targetChoices, 1]
		]] call Ares_fnc_ShowChooseDialog;

	if (count _pickFireMissionResult == 0) exitWith {};
	// TODO: Add validation that coordinates are actually numbers.
	_guns = parseNumber (_numberOfGuns select (_pickFireMissionResult select 0));
	_rounds = (_pickFireMissionResult select 1) + 1; // +1 since the options are 0-based. (0 actually fires a whole clip)
	_ammo = (_artilleryAmmo select (_pickFireMissionResult select 2));
	_ammoSelectedDisplayName = (_artilleryAmmoDisplayName select (_pickFireMissionResult select 2));

	_targetChooseAlgorithm = _pickFireMissionResult select 3;

	// Make sure we only consider targets that are in range.
	_targetsInRange = [];
	{
		if ((position _x) inRangeOfArtillery [[_units select 0], _ammo]) then
		{
			_targetsInRange set [count _targetsInRange, _x];
		};
	} forEach _allTargets;

	if (count _targetsInRange > 0) then
	{
		// Choose a target to fire at
		_selectedTarget = objNull;
		switch (_targetChooseAlgorithm) do
		{
			case 0: // Random
			{
				_selectedTarget = _targetsInRange call BIS_fnc_selectRandom;
			};
			case 1: // Nearest
			{
				_selectedTarget = [position _logic, _targetsInRange] call Ares_fnc_GetNearest;
			};
			case 2: // Furthest
			{
				_selectedTarget = [position _logic, _targetsInRange] call Ares_fnc_GetFarthest;
			};
			default // Specific target
			{
				_selectedTarget = _allTargets select (_targetChooseAlgorithm - 3);
			};
		};
		_targetPos = position _selectedTarget;
	};
} else
{
	// pick guns, rounds, ammo and coordinates
	_pickFireMissionResult = [
		format ["%1 (%2)",localize "STR_ARTILLERY_FIRE_MISSION",localize "STR_GRID"],
		[
			[localize "STR_NUMBER_OF_UNITS_INVOLVED", _numberOfGuns],
			[localize "STR_ROUNDS", ["1", "2", "3", "4", "5"]],
			[localize "STR_AMMO", _artilleryAmmoDisplayName],
			[localize "STR_GRID_EAST_WEST_XXX", "","000"],
			[localize "STR_GRID_NORTH_SOUTH_XXX", "","000"]
		]] call Ares_fnc_ShowChooseDialog;

	if (count _pickFireMissionResult == 0) exitWith { ["Fire mission aborted."] call Ares_fnc_ShowZeusMessage; };
	// TODO: Add validation that coordinates are actually numbers.
	_guns = parseNumber (_numberOfGuns select (_pickFireMissionResult select 0));
	_rounds = (_pickFireMissionResult select 1) + 1; // +1 since the options are 0-based. (0 actually fires a whole clip)
	_ammo = (_artilleryAmmo select (_pickFireMissionResult select 2));
	_ammoSelectedDisplayName = (_artilleryAmmoDisplayName select (_pickFireMissionResult select 2));
	_targetX = _pickFireMissionResult select 3;
	_targetY = _pickFireMissionResult select 4;
	_targetPos = [_targetX,_targetY] call CBA_fnc_mapGridToPos;
};

if (isNil "_targetPos") exitWith {[localize "STR_NO_TARGET_IN_RANGE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

// Generate a list of the actual units to fire.
_gunsToFire = [];
for "_i" from 1 to _guns do
{
	_gunsToFire pushBack (_units select (_i - 1));
};

// Get the ETA and exit if any one of the guns can't reach the target.
_roundEta = 99999;
{
	_roundEta = _roundEta min (_x getArtilleryETA [_targetPos, _ammo]);
} forEach _gunsToFire;
if (_roundEta == -1) exitWith { [localize "STR_NO_TARGET_IN_RANGE"] call Ares_fnc_ShowZeusMessage; };

// Fire the guns
{
	[_x, [_targetPos, _ammo, _rounds]] remoteExecCall ["commandArtilleryFire", _x];
} forEach _gunsToFire;
[localize "STR_FIRE_ROUNDS_AND_ETA", _rounds, _ammoSelectedDisplayName, _roundEta] call Ares_fnc_ShowZeusMessage;


#include "\achilles\modules_f_ares\module_footer.hpp"
