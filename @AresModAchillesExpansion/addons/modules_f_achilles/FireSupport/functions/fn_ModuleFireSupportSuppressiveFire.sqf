////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_Lv
//	DATE: 22/12/17
//	VERSION: 8.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

// find unit to perform suppressiove fire
private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _unit) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

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
private _allTargetsData = ["Achilles_Create_Suppression_Target_Module"] call Achilles_fnc_getPosLogicsData;
_allTargetsData params ["_allTargetNames","_allTargetPositions"];
if (_allTargetNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_TARGET_MARKER"] call Achilles_fnc_ShowZeusErrorMessage};
private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
_targetChoices append _allTargetNames;

private _weaponsToFire = [];
if (isNull objectParent (gunner _unit)) then
{
	{
		if !(_x isEqualTo "") then
		{
			private _configEntry = configFile >> "CfgWeapons" >> _x;
			private _weaponName = getText (_configEntry >> "displayName");
			private _muzzleArray = getArray (_configEntry >> "muzzles") select {_x != "SAFE"};
			if (count _muzzleArray > 1) then
			{
				{
					if (getText (_configEntry >> _x >> "displayName") isEqualTo "") then
					{
						_weaponsToFire pushBack _weaponName;
					}
					else
					{
						_weaponsToFire pushBack (format ["%1 (%2)", _weaponName, getText (_configEntry >> _x >> "displayName")]);
					};
				} forEach _muzzleArray;
			}
			else
			{
				_weaponsToFire pushBack _weaponName;
			};
		};
	} forEach [primaryWeapon _unit]; //TODO: Bug with pistol
}
else
{
	{
		if !(_x isEqualTo "") then
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
	} forEach (_unit weaponsTurret [0]); // TODO: This could break for some vehicles that don't have weapons for the gunner (Hummingbird).
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
		[localize "STR_AMAE_FIRE_MODE", [localize "STR_AMAE_TALKING_GUNS", localize "STR_AMAE_AUTOMATIC", localize "STR_AMAE_BURST", localize "STR_AMAE_SINGLE_SHOT"]],
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
private _selectedTarget = [position _logic, _allTargetPositions, _targetChooseAlgorithm] call Achilles_fnc_positionSelector;

if (local _unit) then
{
	[_unit,_selectedTarget,_weaponToFire,_stanceIndex,_doLineUp,_fireModeIndex,_duration] call Achilles_fnc_SuppressiveFire;
} else
{
	[_unit,_selectedTarget,_weaponToFire,_stanceIndex,_doLineUp,_fireModeIndex,_duration] remoteExec ["Achilles_fnc_SuppressiveFire", _unit];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
