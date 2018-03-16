////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_Lv
//	DATE: 22/12/17
//	VERSION: 8.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

#define BLACKLIST_WEAPONS ["FakeHorn", "AmbulanceHorn", "TruckHorn", "CarHorn", "SportCarHorn", "BikeHorn", "TruckHorn2", "TruckHorn3", "SmokeLauncher"]

// find unit to perform suppressiove fire
private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _unit) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};
if (_unit isKindOf "Thing") exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

//Broadcast suppression functions
if (isNil "Achilles_var_suppressiveFire_init_done") then
{
	publicVariable "Achilles_fnc_checkLineOfFire2D";
	publicVariable "Achilles_fnc_SuppressiveFire";
	Achilles_var_suppressiveFire_init_done = true;
};
//Broadcast set ammo function
if (isNil "Achilles_var_setammo_init_done") then {
	publicVariableServer "Achilles_fnc_setUnitAmmoDef";
	publicVariableServer "Achilles_fnc_setVehicleAmmoDef";
	Achilles_var_setammo_init_done = true;
};

// get list of possible targets
private _allTargetsData = ["Achilles_Create_Suppression_Target_Module"] call Achilles_fnc_getLogics;
_allTargetsData params ["_allTargetNames","_allTargetLogics"];
if (_allTargetNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_TARGET_MARKER"] call Achilles_fnc_ShowZeusErrorMessage};
private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
_targetChoices append _allTargetNames;

// list available fire modes
private _fireModes = [localize "STR_AMAE_AUTOMATIC", localize "STR_AMAE_BURST", localize "STR_AMAE_SINGLE_SHOT"];

private _weaponsToFire = [];
if (_unit isKindOf "Man") then
{
	// talking guns is only available for more than a single unit
	if (count (units _unit) > 1) then {_fireModes pushBack (localize "STR_AMAE_TALKING_GUNS")};
	
	// get all available muzzles for the unit's primary weapon
	private _weapon = primaryWeapon _unit;
	if !(_weapon isEqualTo "") then
	{
		private _configEntry = configFile >> "CfgWeapons" >> _weapon;
		private _weaponName = getText (_configEntry >> "displayName");
		// filter the muzzle "SAFE" found in RHS weapon configs
		private _muzzleArray = getArray (_configEntry >> "muzzles") select {_x != "SAFE"};
		if (count _muzzleArray > 1) then
		{
			{
				if (getText (_configEntry >> _weapon >> "displayName") isEqualTo "") then
				{
					_weaponsToFire pushBack _weaponName;
				}
				else
				{
					_weaponsToFire pushBack (format ["%1 (%2)", _weaponName, getText (_configEntry >> _weapon >> "displayName")]);
				};
			} forEach _muzzleArray;
		}
		else
		{
			_weaponsToFire pushBack _weaponName;
		};
	};
}
else
{
	// If all of the group units are in the same vehicle then don't add the Talking Guns mode.
	if (count ((units _unit) - (crew _unit)) > 0) then {_fireModes pushBack (localize "STR_AMAE_TALKING_GUNS")};
	// get all available muzzles for all occupied turrets
	private _turrets = [[-1]] + (allTurrets _unit);
	[_turrets, "_turrets"] call Achilles_fnc_log;
	{
		if (not isNull turretUnit _x) then
		{
			{
				[_x, "_x"] call Achilles_fnc_log;
				if !(_x isEqualTo "" || _x in BLACKLIST_WEAPONS) then
				{
					private _configEntry = configFile >> "CfgWeapons" >> _x;
					private _weaponName = getText (_configEntry >> "displayName");
					private _muzzleArray = getArray (_configEntry >> "muzzles");
					if (count _muzzleArray > 1) then
					{
						{
							_weaponsToFire pushBack (format ["%1 (%2)", _weaponName, _x]);
						} forEach _muzzleArray;
					}
					else
					{
						_weaponsToFire pushBack _weaponName;
					};
				};
			} forEach (_unit weaponsTurret _x);
		};
		[_unit weaponsTurret _x, "_unit weaponsTurret _x"] call Achilles_fnc_log;
	} forEach _turrets;
};
if (_weaponsToFire isEqualTo []) exitWith {[localize "STR_AMAE_NO_VALID_WEAPON_AVAILABLE"] call Achilles_fnc_ShowZeusErrorMessage};

// select parameters
private _dialogResult =
[
	localize "STR_AMAE_SUPPRESIVE_FIRE",
	[
		[format [localize "STR_AMAE_SUPPRESS_X", " "], _targetChoices],
		[localize "STR_AMAE_STANCE", [localize "STR_AMAE_PRONE",localize "STR_AMAE_CROUCH",localize "STR_AMAE_STAND"], 1],
		[localize "STR_AMAE_LINE_UP", [localize "STR_AMAE_YES",localize "STR_AMAE_NO"], 1],
		[localize "STR_AMAE_WEAPON_TO_FIRE", _weaponsToFire],
		[localize "STR_AMAE_FIRE_MODE", _fireModes],
		[localize "STR_AMAE_DURATION", "", "20"]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_targetChooseAlgorithm",
	"_stanceIndex",
	"_doLineUp",
	"_weaponToFire",
	"_fireModeIndex",
	"_duration"
];
_doLineUp = _doLineUp == 0;
_duration = parseNumber _duration;

// Choose a target to fire at
private _selectedTargetLogic = [position _logic, _allTargetLogics, _targetChooseAlgorithm] call Achilles_fnc_logicSelector;

// Spawn our dummy logic (if executing client does not have Achilles)
private _dummyTargetLogic = [_selectedTargetLogic] call Achilles_fnc_createDummyLogic;

if (local _unit) then
{
	// Executing with call because we are in a suspension-enabled enviornment (see module_header.hpp).
	[_unit,_dummyTargetLogic,_weaponToFire,_stanceIndex,_doLineUp,_fireModeIndex,_duration] call Achilles_fnc_SuppressiveFire;
} else
{
	// Executing here with remoteExec (with suspension) because on the other machines it won't be a suspended enviornment.
	[_unit,_dummyTargetLogic,_weaponToFire,_stanceIndex,_doLineUp,_fireModeIndex,_duration] remoteExec ["Achilles_fnc_SuppressiveFire", _unit];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
