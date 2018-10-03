////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex, CreepPork_Lv
//	DATE: 22/12/17
//	VERSION: 8.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

// find unit to perform suppressiove fire
private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _unit) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};
if (_unit isKindOf "Thing") exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

//Broadcast suppression functions
/*
if (isNil "Achilles_var_suppressiveFire_init_done") then
{
	publicVariable "Achilles_fnc_checkLineOfFire2D";
	publicVariable "Achilles_fnc_getWeaponsMuzzlesMagazines";
	publicVariable "Achilles_fnc_forceWeaponFire";
	publicVariable "Achilles_fnc_suppressiveFire";
	Achilles_var_suppressiveFire_init_done = true;
};
//Broadcast set ammo function
if (isNil "Achilles_var_setammo_init_done") then {
	publicVariableServer "Achilles_fnc_setUnitAmmoDef";
	publicVariableServer "Achilles_fnc_setVehicleAmmoDef";
	Achilles_var_setammo_init_done = true;
};
*/

// get list of possible targets
private _allTargetsData = ["Achilles_Create_Universal_Target_Module"] call Achilles_fnc_getLogics;
_allTargetsData params ["_allTargetNames","_allTargetLogics"];
if (_allTargetNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_TARGET_MARKER"] call Achilles_fnc_ShowZeusErrorMessage};
private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
_targetChoices append _allTargetNames;

// list available fire modes
private _fireModes = [localize "STR_AMAE_AUTOMATIC", localize "STR_AMAE_BURST", localize "STR_AMAE_SINGLE_SHOT"];

if (_unit isKindOf "Man") then
{
	// talking guns is only available for more than a single unit
	if (count (units _unit) > 1) then {_fireModes pushBack (localize "STR_AMAE_TALKING_GUNS")};
}
else
{
	// If all of the group units are in the same vehicle then don't add the Talking Guns mode.
	if (count ((units _unit) - (crew _unit)) > 0) then {_fireModes pushBack (localize "STR_AMAE_TALKING_GUNS")};
};

// get available weapons, muzzles, magazines
private _weaponsAndMuzzlesAndMagazines = [_unit] call Achilles_fnc_getWeaponsMuzzlesMagazines;
if (_weaponsAndMuzzlesAndMagazines isEqualTo []) exitWith 
{
	[localize "STR_AMAE_NO_VALID_WEAPON_AVAILABLE"] call Achilles_fnc_ShowZeusErrorMessage;
};
private _weaponsToFire = [];
private _weaponMuzzleMagazineIdxList = [];
{
	private _weapIdx = _forEachIndex;
	_x params [["_weaponAndTurret","",["",[]]], ["_muzzlesAndMagazines",[""],[[]]]];
	_weaponAndTurret params [["_weapon","",[""]]];
	private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
	{
		private _muzzleIdx = _forEachIndex;
		_x params [["_muzzle","",[""]], ["_magazines",[""],[[]]]];
		{
			private _magazine = _x;
			private _magIdx = _forEachIndex;
			private _magName = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
			_weaponsToFire pushBack format ["%1 (%2)", _weaponName, _magName];
			_weaponMuzzleMagazineIdxList pushBack [_weapIdx, _muzzleIdx, _magIdx];
		} forEach _magazines;
	} forEach _muzzlesAndMagazines;
} forEach _weaponsAndMuzzlesAndMagazines;

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
	"_weaponsToFireIdx",
	"_fireModeIndex",
	"_duration"
];
_doLineUp = _doLineUp == 0;
(_weaponMuzzleMagazineIdxList select _weaponsToFireIdx) params ["_weapIdx", "_muzzleIdx", "_magIdx"];
_duration = parseNumber _duration;

// Choose a target to fire at
private _selectedTargetLogic = [position _logic, _allTargetLogics, _targetChooseAlgorithm] call Achilles_fnc_logicSelector;

// Spawn our dummy logic (if executing client does not have Achilles)
private _dummyTargetLogic = [_selectedTargetLogic] call Achilles_fnc_createDummyLogic;

// make sure the group is local
private _group = group _unit;
if (not local _group) then
{
	[[], [_group], clientOwner] call Achilles_fnc_transferOwnership;
};
if (isNull _group or {{alive _x} count units _group == 0}) exitWith {};
// Executing with call because we are in a suspension-enabled enviornment (see module_header.inc).
[_unit,_dummyTargetLogic, _weapIdx, _muzzleIdx, _magIdx, _fireModeIndex, _stanceIndex, _doLineUp, _duration] call Achilles_fnc_suppressiveFire;

#include "\achilles\modules_f_ares\module_footer.inc"
