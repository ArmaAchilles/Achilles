////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/3/17
//	VERSION: 6.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc.sqf"

#define ALL_CM_WEAP_CLASSES ["CMFlareLauncher", "CMFlareLauncher_Singles", "CMFlareLauncher_Triples", "rhs_weap_CMFlareLauncher", "rhsusf_weap_CMFlareLauncher", "rhsusf_weap_LWIRCM", "rhsusf_weap_ANAAQ24", "rhsusf_weap_ANALQ144", "rhsusf_weap_ANALQ157", "rhsusf_weap_ANALQ212"]
#define ALL_LD_WEAP_CLASSES ["Laserdesignator", "Laserdesignator_mounted", "Laserdesignator_pilotCamera", "Laserdesignator_vehicle"]

private _aircraft = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if !(_aircraft isKindOf "Air") exitWith
{
	[localize "STR_AMAE_NOT_AN_ARCRAFT_ERROR"] call Achilles_fnc_showZeusErrorMessage;
};
private _vectDir = vectorDir _aircraft;
if ((_vectDir#0 toFixed 1) in ["0.0","-0.0"] and ((_vectDir#1 toFixed 1) in ["0.0","-0.0"])) exitWith 
{
	[localize "STR_AMAE_GIMBAL_LOCK_ERROR"] call Achilles_fnc_showZeusErrorMessage;
};
if (isTouchingGround _aircraft) exitWith
{
	[localize "STR_AMAE_ARCRAFT_IS_TOUCHING_GROUND_ERROR"] call Achilles_fnc_showZeusErrorMessage;
};
if (isPlayer driver _aircraft) exitWith
{
	[localize "STR_AMAE_SELECT_NON_PLAYER_UNITS"] call Achilles_fnc_ShowZeusErrorMessage;
};
if (_aircraft getVariable ["Achilles_var_performsAdvancedCAS", false]) exitWith
{
	[localize "STR_AMAE_UNIT_IS_CURRENTLY_BUSY_ERROR"] call Achilles_fnc_ShowZeusErrorMessage;
};
_aircraft setVariable ["Achilles_var_performsAdvancedCAS", true, true];

// Get available weapons, muzzles, magazines
private _availableMagazines = [];
{
	if (_x#2 > 0) then
	{
		_availableMagazines pushBackUnique (_x#0);
	};
} forEach (magazinesAllTurrets _aircraft);
if (_availableMagazines isEqualTo []) exitWith 
{
	[localize "STR_AMAE_NO_VALID_WEAPON_AVAILABLE"] call Achilles_fnc_ShowZeusErrorMessage;
	_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
};
private _weaponsToFire = [];
private _weaponMuzzleMagazineIdxList = [];
{
	private _weapIdx = _forEachIndex;
	_x params [["_weaponAndTurret","",["",[]]], ["_muzzlesAndMagazines",[""],[[]]]];
	_weaponAndTurret params [["_weapon","",[""]]];
	if (ALL_CM_WEAP_CLASSES findIf {_weapon == _x} < 0 && ALL_LD_WEAP_CLASSES findIf {_weapon == _x} < 0) then
	{
		private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
		{
			private _muzzleIdx = _forEachIndex;
			_x params ["", ["_magazines",[""],[[]]]];
			{
				private _magazine = _x;
				if (_magazine in _availableMagazines) then
				{
					private _magIdx = _forEachIndex;
					private _magName = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
					if !(_magName isEqualTo "") then
					{
						_weaponsToFire pushBack format ["%1 (%2)", _weaponName, _magName];
					}
					else
					{
						_weaponsToFire pushBack format ["%1", _weaponName];
					};
					_weaponMuzzleMagazineIdxList pushBack [_weapIdx, _muzzleIdx, _magIdx];
				};
			} forEach _magazines;
		} forEach _muzzlesAndMagazines;
	};
} forEach ([_aircraft] call Achilles_fnc_getWeaponsMuzzlesMagazines);

if (_weaponsToFire isEqualTo []) exitWith 
{
	[localize "STR_AMAE_NO_VALID_WEAPON_AVAILABLE"] call Achilles_fnc_ShowZeusErrorMessage;
	_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
};

// find targets
private _allTargetsUnsorted = allMissionObjects "Achilles_Create_Universal_Target_Module";
if (_allTargetsUnsorted isEqualTo []) exitWith
{
	[localize "STR_AMAE_NO_TARGET_MARKER"] call Achilles_fnc_ShowZeusErrorMessage;
	_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
};
private _allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
{
	_targetChoices pushBack (name _x);
} forEach _allTargets;
if (count _targetChoices == 3) exitWith
{
	[localize "STR_AMAE_NO_TARGET_AVAIABLE"] call Achilles_fnc_ShowZeusErrorMessage;
	_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
};

// select parameters
private _dialogResult =
[
	localize "STR_AMAE_ADVANCED_CAS",
	[
		[format[localize "STR_AMAE_TARGET", " "], _targetChoices],
		[localize "STR_AMAE_WEAPON_TO_FIRE", _weaponsToFire],
		[localize "STR_NUMBER_OF_STRIKES", "", "1"],
		[[localize "STR_AMAE_OFFSET", localize"STR_AMAE_METER"] joinString " ", "", "0"]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith
{
	_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
};
_dialogResult params ["_targetChooseAlgorithm", "_weaponsToFireIdx", "_numberOfStrikes", "_customOffset"];
_numberOfStrikes = round (parseNumber _numberOfStrikes);
_customOffset = parseNumber _customOffset;

// select target
private _selectedTarget = objNull;
switch (_targetChooseAlgorithm) do
{
	case 0:
	{
		_selectedTarget = _allTargets call BIS_fnc_selectRandom;
	};
	case 1:
	{
		_selectedTarget = [position _logic, _allTargets] call Ares_fnc_GetNearest;
	};
	case 2:
	{
		_selectedTarget = [position _logic, _allTargets] call Ares_fnc_GetFarthest;
	};
	default
	{
		_selectedTarget = _allTargets select (_targetChooseAlgorithm - 3);
	};
};
// make sure everything is local
if (!local group effectiveCommander _aircraft || !local _aircraft) then
{
	[[_aircraft], [group effectiveCommander _aircraft], clientOwner] call Achilles_fnc_transferOwnership;
};

for "_" from 1 to _numberOfStrikes do
{
	private _success = false;
	switch (true) do
	{
		case (_aircraft isKindOf "B_T_VTOL_01_armed_F"):
		{
			_success = [_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset] call Achilles_fnc_advancedBlackfishCAS;
		};
		case (_aircraft isKindOf "Plane"):
		{
			_success = [_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset] call Achilles_fnc_advancedPlaneCAS;
			sleep 5;
		};
		case (_aircraft isKindOf "Helicopter"):
		{
			_success = [_aircraft, _selectedTarget, _weaponMuzzleMagazineIdxList select _weaponsToFireIdx, _customOffset] call Achilles_fnc_advancedHeliCAS;
			sleep 15;
		};
	};
	if (!_success) exitWith {};
};
_aircraft setVariable ["Achilles_var_performsAdvancedCAS", nil, true];
#include "\achilles\modules_f_ares\module_footer.inc.sqf"
