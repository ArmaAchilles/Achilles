////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9/2/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\fn_setUnitAmmoDef.sqf
//  DESCRIPTION: set unit's magazine count based on given percentage
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- unit for which the ammo is changed
//	_this select 1:		SCALAR	- ammo value in range [0,1]
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit, 0.9] call Achilles_fnc_settUnitAmmoDef;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_unit = _this select 0;
_percentage = _this select 1;

// clear cargo
{_unit removeMagazine _x;} foreach (magazines _unit);

// get config unit magazines (does not include backpacks)
_cfgMagazines = getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "magazines");

_MagazinesClassName = [];
_MagazinesCount = [];
private _i = 0;
{
	_index = _MagazinesClassName find _x;
	if (_index == -1) then
	{
		_MagazinesClassName pushBack _x;
		_MagazinesCount pushBack 1;
	} else
	{
		_MagazinesCount set [_index, (_MagazinesCount select _index) + 1];
	};
} forEach _cfgMagazines;

// get config backpack magazines
_backpackClassName =  backpack _unit;
if (_backpackClassName != "") then
{
	_CfgBackpackContent =  (configFile >> "CfgVehicles" >> _backpackClassName >> "TransportMagazines");
	_cfgBackpackMagazines = [_CfgBackpackContent, 0, true] call BIS_fnc_returnChildren;
	{
		_backpackMagazineClassName = getText (_x >> "magazine");
		_backpackMagazineAmmoCount = getNumber (_x >> "count");
		
		_index = _MagazinesClassName find _backpackMagazineClassName;
		if (_index == -1) then
		{
			_MagazinesClassName pushBack _backpackMagazineClassName;
			_MagazinesCount pushBack _backpackMagazineAmmoCount;			
		} else
		{
			_MagazinesCount set [_index, (_MagazinesCount select _index) + _backpackMagazineAmmoCount];
		};
	} forEach _cfgBackpackMagazines;
};

// set ammo according to percentage

{
	_count = round (_x * _percentage);
	_magazine = _MagazinesClassName select _forEachIndex;
	_unit addMagazines [_magazine,_count];
} forEach _MagazinesCount;

