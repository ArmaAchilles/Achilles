/*
	Authors:
		Kex, CoxLedere, CreepPork_LV, NeilZar

	DESCRIPTION:
		Opens the "ammo" dialog for vehicles.

	Parameters:
	   _this:  OBJECT - Vehicle to edit

	Returns:
	   none

	Examples:
		(begin example)
			[_vehicle] call Achilles_fnc_changePylonAmmo;
		(end)
*/

params ["_plane"];
private _planeType = typeOf _plane;
if (!isClass (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent")) exitWith { [localize "STR_AMAE_NO_DYNAMIC_LOADOUT"] call Achilles_fnc_ShowZeusErrorMessage; };

private _hasGunner = !(fullCrew [_plane, "gunner", true] isEqualTo []);
private _allCurrentPylonMagazines = getPylonMagazines _plane;
private _pylonCfgs = configProperties [configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent" >> "pylons", "isClass _x"];
private _entries = [];
private _addWeaponsTo = [];
if (_hasGunner) then
{
	_addWeaponsTo = [1, 0] select (_plane getVariable ["Achilles_var_changePylonAmmo_Assigned", [0]] isEqualTo []);
	_entries pushBack [localize "STR_AMAE_ASSIGN_WEAPONS", [localize "STR_AMAE_DRIVER", localize "STR_AMAE_GUNNER"], _addWeaponsTo, true];
};

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

if (_hasGunner) then
{
	_addWeaponsTo = [[], [0]] select (_dialogResult select 0 == 1);
	_plane setVariable ["Achilles_var_changePylonAmmo_Assigned", _addWeaponsTo, true];
	_dialogResult deleteAt 0
};

{
	private _plane = _x;
	{_plane removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")} forEach _allCurrentPylonMagazines;
	{
		private _magIndex = _x - 1;
		private _pylonIndex = _forEachIndex + 1;
		private _magClassName = if (_x > 0) then {(_compatibleMagazines select _forEachIndex) select _magIndex} else {""};
		_plane setPylonLoadOut [_pylonIndex, _magClassName, false, _addWeaponsTo];
	} forEach _dialogResult;
} forEach _curatorSelected;
