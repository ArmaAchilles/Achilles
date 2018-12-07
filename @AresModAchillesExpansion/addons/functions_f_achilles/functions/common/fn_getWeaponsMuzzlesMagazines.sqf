////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex, CreepPork_LV
// DATE: 			06.04.18
// VERSION: 		AMAE.1.0.2
// DESCRIPTION: 	Gets all available muzzles and magazines for the primary weapon (unit) / all turret weapons (vehicle)
//
// ARGUMENTS:		0: OBJECT - unit or vehicle.
//
// RETURNS:			ARRAY - Returns the weapons/muzzles/magazines as a nested array:
//					        [[<weapon className>, [<muzzle className>, [<magazine className>, ...], ...], ...], ...]
//					        [[[<weapon className>, <turret path>], [<muzzle className>, [<magazine className>, ...], ...], ...], ...]
//
// Example:			_weaponsToFire = [_unit] call Achilles_fnc_getWeaponsMuzzlesMagazines;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define BLACKLIST_WEAPONS ["FakeHorn", "AmbulanceHorn", "TruckHorn", "CarHorn", "SportCarHorn", "BikeHorn", "TruckHorn2", "TruckHorn3", "SmokeLauncher"]

params [["_unit", objNull, [objNull]]];

private _weaponsToFire = [];
if (_unit isKindOf "Man") then
{
	// if unit is a soldier
	// get all available muzzles for the unit's primary weapon
	private _weapon = primaryWeapon _unit;
	private _availableMagazines = (magazines _unit) apply {toLower _x};
	if !(_weapon isEqualTo "") then
	{
		// get all muzzles for the weapon
		private _muzzleArray = [];
		{
			private _muzzle = _x;
			// filter the muzzle "SAFE" found in RHS weapon configs
			if (_muzzle != "SAFE") then
			{
				// get the available magazines
				private _magazines = [];
				if (_muzzle == "this") then
				{
					_magazines = ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) apply {toLower _x}) arrayIntersect _availableMagazines;
				}
				else
				{
					_magazines = ((getArray (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "magazines")) apply {toLower _x}) arrayIntersect _availableMagazines;
				};
				// filter smoke shells
				_magazines = _magazines select {(toLower getText (configFile >> "CfgMagazines" >> _x >> "displayName") find "smoke") isEqualTo -1};
				if !(_magazines isEqualTo []) then
				{
					_muzzleArray pushBack [_muzzle, _magazines];
				};
			};
		} forEach getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");
		if !(_muzzleArray isEqualTo []) then
		{
			_weaponsToFire pushBack [_weapon, _muzzleArray];
		};
	};
}
else
{
	// get all available turrets
	private _turrets = [[-1]] + (allTurrets _unit);
	{
		private _turretPath = _x;
		private _availableMagazines = (_unit magazinesTurret _turretPath) apply {toLower _x};
		// only consider occupied turrets
		if (not isNull (_unit turretUnit _turretPath)) then
		{
			// for available weapons
			private _weaponArray = [];
			{
				private _weapon = _x;
				// don't consider blacklisted weapons
				if !(_weapon isEqualTo "" || _weapon in BLACKLIST_WEAPONS) then
				{
					// get all muzzles for the weapon
					private _muzzleArray = [];
					{
						// get the available magazines
						private _muzzle = _x;
						private _magazines = [];
						if (_muzzle == "this") then
						{
							_magazines = ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) apply {toLower _x}) arrayIntersect _availableMagazines;
						}
						else
						{
							_magazines = ((getArray (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "magazines")) apply {toLower _x}) arrayIntersect _availableMagazines;
						};
						if !(_magazines isEqualTo []) then
						{
							_muzzleArray pushBack [_muzzle, _magazines];
						};
					} forEach getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");
					if !(_muzzleArray isEqualTo []) then
					{
						_weaponsToFire pushBack [[_weapon, _turretPath], _muzzleArray];
					};
				};
			} forEach (_unit weaponsTurret _turretPath);
		};
	} forEach _turrets;
};
// return
_weaponsToFire;
