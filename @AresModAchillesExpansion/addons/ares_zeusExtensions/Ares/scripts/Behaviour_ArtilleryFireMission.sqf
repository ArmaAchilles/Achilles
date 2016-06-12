[
	"AI Behaviours",
	"Artillery Fire Mission",
	{
		// get all units within range
		_nearObjects = nearestObjects [(_this select 0), ["All"], 150];

		// Filter for artillery
		_filteredObjects = [];
		{
			_ammo = getArtilleryAmmo [_x];
			if (count _ammo > 0) then
			{
				_filteredObjects pushBack _x;
			};
			
		} forEach _nearObjects;

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
		if (count _batteries == 0) exitWith { ["No nearby artillery units."] call Ares_fnc_ShowZeusMessage; };

		// Pick a battery
		_pickBatteryResult = [
				"Pick battery to fire.",
				[
					["Battery", _batteryTypes]
				]] call Ares_fnc_ShowChooseDialog;
		if (count _pickBatteryResult == 0) exitWith { ["Fire mission aborted."] call Ares_fnc_ShowZeusMessage; };
		_battery = _batteries select (_pickBatteryResult select 0);

		// Pick fire mission details
		_fireMission = nil;
		_units = _battery select 1;
		_artilleryAmmo = _battery select 2;
		
		_numberOfGuns = [];
		{
			_numberOfGuns pushBack (str (_forEachIndex + 1));
		} forEach _units;

		// pick guns, rounds, ammo and coordinates
		_pickFireMissionResult = [
			"Pick fire mission details.",
			[
				["Guns", _numberOfGuns],
				["Rounds", ["1", "2", "3", "4", "5"]],
				["Ammo", _artilleryAmmo],
				["Grid East-West", ""],
				["Grid North-South", ""]
			]] call Ares_fnc_ShowChooseDialog;

		if (count _pickFireMissionResult == 0) exitWith { ["Fire mission aborted."] call Ares_fnc_ShowZeusMessage; };
		// TODO: Add validation that coordinates are actually numbers.
		_guns = parseNumber (_numberOfGuns select (_pickFireMissionResult select 0));
		_rounds = (_pickFireMissionResult select 1) + 1; // +1 since the options are 0-based. (0 actually fires a whole clip)
		_ammo = (_artilleryAmmo select (_pickFireMissionResult select 2));
		_targetX = _pickFireMissionResult select 3;
		_targetY = _pickFireMissionResult select 4;
		_targetPos = [_targetX,_targetY] call CBA_fnc_mapGridToPos;

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
		if (_roundEta == -1) exitWith { ["Target not in range."] call Ares_fnc_ShowZeusMessage; };

		// Fire the guns
		{
			[[_x, _targetPos, _ammo, _rounds], "Ares_FireArtilleryFunction", _x] call BIS_fnc_MP;
		} forEach _gunsToFire;
		["Firing %1 rounds of '%2' at target. ETA %3", _rounds, _ammo, _roundEta] call Ares_fnc_ShowZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;
