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
if (not isClass (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent")) exitWith {[localize "STR_NO_DYNAMIC_LOADOUT"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

private _hasGunner = count fullCrew [_plane, "gunner", true] == 1;

private _allCurrentPylonMagazines = getPylonMagazines _plane;
private _pylon_cfgs = (configFile >> "cfgVehicles" >> _planeType >> "Components" >> "TransportPylonsComponent" >> "pylons") call BIS_fnc_returnChildren;
private _entries = [];
if (_hasGunner) then {_entries pushBack [localize "STR_ASSIGN_WEAPONS", [localize "STR_DRIVER", localize "STR_GUNNER"], 1]};
{
	private _pylon_cfg = _x;
	private _pylonIndex = _forEachIndex + 1;
	private _magazineNames = ["Empty"];
	private _defaultIndex = 0;
	{
		_mag_cfg = (configFile >> "cfgMagazines" >> _x);
		_magazineNames pushBack format ["%1 (%2)", getText (_mag_cfg >> "displayName"), getText (_mag_cfg >> "DisplayNameShort")];
		if (configName _mag_cfg == _allCurrentPylonMagazines select (_pylonIndex - 1)) then {_defaultIndex = _forEachIndex + 1};
	} forEach (_plane getCompatiblePylonMagazines _pylonIndex);
	
	_entries pushBack [configName _pylon_cfg, _magazineNames, _defaultIndex, true];
} forEach _pylon_cfgs;

_dialogResult = [localize "STR_LOADOUT", _entries] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
_curatorSelected = _curatorSelected select {_x isKindOf _planeType};

private _addWeaponsTo = "";
if (_hasGunner) then {_addWeaponsTo = _dialogResult select 0};
switch (_addWeaponsTo) do 
{
	case 0: {_addWeaponsTo = []};
	case 1: {_addWeaponsTo = [0]};
	default {_addWeaponsTo = []};
};

if (_hasGunner) then {_dialogResult deleteAt 0};

// This code commented below (there were a lot more attempts) is my attempts to remove empty weapons for the driver. I'm guessing it's a fault
// of BI, because I can't get it to remove the weapons only from the driver. The gunners weapons will be removed. Maybe I'm retarded or something but for
// the love of god I can't figure it out. So if anyone of you have a idea, please let me know. I've spent the whole fucking day trying to fix this.
// Okay, stop rambeling. It's enough.
/*{_this select 1 setPylonLoadOut [_forEachIndex + 1, "", true]} forEach getPylonMagazines (_this select 1);
{(driver (_this select 1)) removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines (_this select 1);
{(gunner (_this select 1)) removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines (_this select 1);

(configProperties [configFile >> "CfgVehicles" >> typeOf (_this select 1) >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
{ (_this select 1) removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines (_this select 1);*/

{
	_plane = _x;
	{ _plane removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach _allCurrentPylonMagazines;
	{
		private _magIndex = _x;
		private _pylonIndex = _forEachIndex + 1;
		private _magClassName = if (_x > 0) then {(_plane getCompatiblePylonMagazines _pylonIndex) select (_magIndex - 1)} else {""};
		if (local _plane) then
		{
			_plane setPylonLoadOut [_pylonIndex, _magClassName, false, _addWeaponsTo];
		}
		else
		{
			[_plane, [_pylonIndex, _magClassName, false, _addWeaponsTo]] remoteExecCall ["setPylonLoadOut", _plane];
		};
	} forEach _dialogResult;
} forEach _curatorSelected;