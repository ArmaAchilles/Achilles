////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/28/17
//	VERSION: 1.0
//  DESCRIPTION: opens the "ammo" dialog for vehicles.
//
//	ARGUMENTS:
//	_this select 0		_vehicle (optional)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_vehicle] call Achilles_fnc_changePylonAmmo;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (isNil {uiNamespace getVariable "Achilles_var_PylonMagDataCache"}) then
{
	private _pylonMagDataCache = [];
	private _mag_cfgs = (configFile >> "cfgMagazines") call BIS_fnc_returnChildren;
	{
		private _hardpoints = [_x, "hardpoints", []] call BIS_fnc_returnConfigEntry;
		if (count _hardpoints > 0) then
		{
			_pylonMagDataCache pushBack [_x, _hardpoints];
		};
	} forEach _mag_cfgs;
	_pylonMagDataCache = [_pylonMagDataCache, [], {getText (_x select 0 >> "displayName")}] call BIS_fnc_sortBy;
	uiNamespace setVariable ["Achilles_var_PylonMagDataCache", _pylonMagDataCache];
};

params ["_plane"];
private _planeType = typeOf _plane;
if (not isClass (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent")) exitWith {[localize "STR_NO_DYNAMIC_LOADOUT"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

private _allCurrentPylonMagazines = getPylonMagazines _plane;
private _pylon_cfgs = (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent" >> "pylons") call BIS_fnc_returnChildren;
private _entries = [];
private _allPylonMagIndices = [];
{
	private _pylon_cfg = _x;
	private _pylonIndex = _forEachIndex + 1;
	private _pylonMagIndices = [-1];
	private _magazineNames = ["Empty"];
	private _refHardpoints = [_pylon_cfg, "hardpoints", []] call BIS_fnc_returnConfigEntry;
	private _defaultIndex = 0;
	{
		_x params ["_mag_cfg","_hardpoints"];
		private _intersect = _refHardpoints arrayIntersect _hardpoints;
		if (count _intersect > 0) then
		{
			_magazineNames pushBack format ["%1 (%2)", getText (_mag_cfg >> "displayName"), getText (_mag_cfg >> "DisplayNameShort")];
			_pylonMagIndices pushBack _forEachIndex;
			if (configName _mag_cfg == _allCurrentPylonMagazines select (_pylonIndex - 1)) then {_defaultIndex = count _pylonMagIndices - 1};
		};
	} forEach (uiNamespace getVariable "Achilles_var_PylonMagDataCache");
	
	_entries pushBack [configName _pylon_cfg, _magazineNames, _defaultIndex, true];
	_allPylonMagIndices pushBack _pylonMagIndices;
} forEach _pylon_cfgs;

_dialogResult = [localize "STR_AMMO", _entries] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
_curatorSelected = _curatorSelected select {_x isKindOf _planeType};

{
	_plane = _x;
	{
		private _pylonMagIndex = if (_x > 0) then {_allPylonMagIndices select _forEachIndex select _x} else {-1};
		private _magClassName = if (_x > 0) then {configName ((uiNamespace getVariable "Achilles_var_PylonMagDataCache") select _pylonMagIndex select 0)} else {""};
		if (local _plane) then
		{
			_plane setPylonLoadOut [_forEachIndex + 1, _magClassName];
		} else
		{
			[_plane, [_forEachIndex + 1, _magClassName]] remoteExecCall ["setPylonLoadOut", _plane];
		};
	} forEach _dialogResult;
} forEach _curatorSelected;