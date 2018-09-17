////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/3/17
//	VERSION: 6.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.h"

private _aircraft = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if !(_aircraft isKindOf "Air") exitWith {};

// find weapons
private _weaponsAndMuzzlesAndMagazines = [_aircraft] call Achilles_fnc_getWeaponsMuzzlesMagazines;
private _weaponsToFire = _weaponsAndMuzzlesAndMagazines apply 
{
	private _magazineDisplayName = getText (configFile >> "cfgMagazines" >> _x#1#0#1#0 >> "displayName");
	if (_magazineDisplayName isEqualTo "") then
	{
		getText (configFile >> "cfgWeapons" >> _x#0#0 >> "displayName")
	}
	else
	{
		_magazineDisplayName
	};
};

// find targets
private _allTargetsUnsorted = allMissionObjects "Achilles_Create_Universal_Target_Module";
if (_allTargetsUnsorted isEqualTo []) exitWith {[localize "STR_AMAE_NO_TARGET_MARKER"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
private _allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
private _targetChoices = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];
{
	_targetChoices pushBack (name _x);
} forEach _allTargets;
if (count _targetChoices == 3) exitWith {[localize "STR_AMAE_NO_TARGET_AVAIABLE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

// select parameters
private _dialogResult =
[
	localize "STR_AMAE_SUPPRESIVE_FIRE",
	[
		[format[localize "STR_AMAE_TARGET", " "], _targetChoices],
		[localize "STR_AMAE_WEAPON_TO_FIRE", _weaponsToFire],
		[[localize "STR_AMAE_OFFSET", localize"STR_AMAE_METER"] joinString " ", "", "0"]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_targetChooseAlgorithm", "_weaponsToFireIdx", "_customOffset"];
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

if (_aircraft isKindOf "Plane") then
{
	// for jets
	[_aircraft, _selectedTarget, _weaponsAndMuzzlesAndMagazines select _weaponsToFireIdx, _customOffset] call Achilles_fnc_advancedPlaneCAS;
}
else
{
	// for heli
};


#include "\achilles\modules_f_ares\module_footer.h"
