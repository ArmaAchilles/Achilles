////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\fn_getUnitAmmoDef.sqf
//  DESCRIPTION: estimate for inverse function of setVehicleAmmoDef command (not very accurate)
//
//	ARGUMENTS:
//	_this:				OBJECT	- unit for which the ammo is counted
//
//	RETURNS:
//	_this:				SCALAR	- number between 0 and 1 corresponding to the relative ammo count
//
//	Example:
//	_unit call Achilles_fnc_getUnitAmmoDef;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_unit = _this;

_currentMagazinesClassName = [];
_currentMagazinesAmmoCount = [];

// get current magazines ammo count
{
	_currentMagazinesClassName pushBack (_x select 0);
	_currentMagazinesAmmoCount pushBack (_x select 1);
} forEach (magazinesAmmoFull _unit);

// get config unit magazines (does not include backpacks)
_MagazinesClassName = getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "magazines");

// get config backpack magazines
_backpackClassName =  backpack _unit;
if (_backpackClassName != "") then
{
	_CfgBackpackContent =  (configFile >> "CfgVehicles" >> _backpackClassName >> "TransportMagazines");
	_cfgBackpackMagazines = [_CfgBackpackContent, 0, true] call BIS_fnc_returnChildren;
	{
		_backpackMagazineClassName = getText (_x >> "magazine");
		_backpackMagazineAmmoCount = getNumber (_x >> "count");
		for "_i" from 1 to _backpackMagazineAmmoCount do
		{
			_MagazinesClassName pushBack _backpackMagazineClassName;
		};
	} forEach _cfgBackpackMagazines;
};

// get ammo percentages for all magazines
_percentages = [];
{
	_CfgAmmoCount = getNumber (configFile >> "CfgMagazines" >> _x >> "count");
	_index = _currentMagazinesClassName find _x;
	if (_index != -1) then
	{
		_percentages pushBack ((_currentMagazinesAmmoCount select _index) / _CfgAmmoCount);
		
		// remove the counted magazine from the list
		_currentMagazinesClassName deleteAt _index;
		_currentMagazinesAmmoCount deleteAt _index;
	} else
	{
		_percentages pushBack 0;
	};
} forEach _MagazinesClassName;

// return the mean of all percentages
if (count _percentages != 0) then
{
	(_percentages call Achilles_fnc_arrayMean);
} else
{
	0;
};
