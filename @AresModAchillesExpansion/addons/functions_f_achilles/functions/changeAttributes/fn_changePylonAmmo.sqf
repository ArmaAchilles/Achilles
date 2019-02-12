////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CoxLedere, CreepPork_LV
//	DATE: 07/10/2017 (DD/MM/YYYY)
//	VERSION: 3.0
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

params ["_plane"];
private _planeType = typeOf _plane;
if (!isClass (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent")) exitWith { [localize "STR_AMAE_NO_DYNAMIC_LOADOUT"] call Achilles_fnc_ShowZeusErrorMessage; };

private _allCurrentPylonMagazines = getPylonMagazines _plane;
private _pylonCfgs = configProperties [configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent" >> "pylons", "isClass _x"];
private _pylonTurrets = _pylonCfgs apply { getArray (_x >> "turret") };
private _entries = [];
private _compatibleMagazines = (_plane getCompatiblePylonMagazines 0);
{
	private _pylonIndex = _forEachIndex;
	private _magazineNames = ["Empty"];
	private _defaultIndex = 0;
	{
		private _magCfg = configFile >> "cfgMagazines" >> _x;
		_magazineNames pushBack format ["%1 (%2)", getText (_magCfg >> "displayName"), getText (_magCfg >> "DisplayNameShort")];
		if (_x == _allCurrentPylonMagazines select _pylonIndex) then { _defaultIndex = _forEachIndex + 1 };
	} forEach _x;

	_entries pushBack [configName (_pylonCfgs select _pylonIndex), _magazineNames, _defaultIndex, true];
} forEach _compatibleMagazines;

private _dialogResult = [localize "STR_AMAE_LOADOUT", _entries] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
_curatorSelected = _curatorSelected select {_x isKindOf _planeType};

{
	private _plane = _x;
	{_plane removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")} forEach _allCurrentPylonMagazines;
	{
		private _magIndex = _x - 1;
		private _pylonIndex = _forEachIndex + 1;
		private _magClassName = if (_x > 0) then {(_compatibleMagazines select _forEachIndex) select _magIndex} else {""};
		_plane setPylonLoadOut [_pylonIndex, _magClassName, false, _pylonTurrets select _forEachIndex];
	} forEach _dialogResult;
} forEach _curatorSelected;
