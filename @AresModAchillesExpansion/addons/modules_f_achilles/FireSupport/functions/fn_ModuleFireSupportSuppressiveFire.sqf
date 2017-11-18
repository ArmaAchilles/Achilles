////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 30/4/17
//	VERSION: 7.0
//  DESCRIPTION: Function for suppressive fire module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

// find unit to perform suppressiove fire
private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _unit) exitWith {[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

//Broadcast suppression functions
if (isNil "Achilles_var_suppressiveFire_init_done") then
{
	publicVariable "Achilles_fnc_checkLineOfFire2D";
	publicVariable "Achilles_fnc_SuppressiveFire";
	Achilles_var_suppressiveFire_init_done = true;
};

// get list of possible targest
private _allTargetsUnsorted = allMissionObjects "Achilles_Create_Suppression_Target_Module";
if (_allTargetsUnsorted isEqualTo []) exitWith {[localize "STR_NO_TARGET_MARKER"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
private _allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
private _targetChoices = [localize "STR_RANDOM", localize "STR_NEAREST", localize "STR_FARTHEST"];
_targetChoices = _allTargets apply {name _x};
if (count _targetChoices == 3) exitWith {[localize "STR_NO_TARGET_AVAIABLE"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

// select parameters
private _dialogResult =
[
	localize "STR_SUPPRESIVE_FIRE",
	[
		[format [localize "STR_SUPPRESS_X", " "], _targetChoices],
		[localize "STR_STANCE", [localize "STR_PRONE",localize "STR_CROUCH",localize "STR_STAND"]],
		[localize "STR_LINE_UP", [localize "STR_FALSE",localize "STR_TRUE"]],
		[localize "STR_FIRE_MODE", [localize "STR_AUTOMATIC", localize "STR_BURST", localize "STR_SINGLE_SHOT"]],
		[localize "STR_DURATION", "", "10"]
	]
] call Ares_fnc_ShowChooseDialog;
if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_targetChooseAlgorithm",
	"_stanceIndex",
	"_doLineUp",
	"_fireModeIndex",
	"_duration"
];
_doLineUp = _doLineUp == 1;
_duration = parseNumber _duration;

// Choose a target to fire at
private _selectedTarget = switch (_targetChooseAlgorithm) do
{
	case 0: // Random
	{
		_allTargets call BIS_fnc_selectRandom;
	};
	case 1: // Nearest
	{
		[position _logic, _allTargets] call Ares_fnc_GetNearest;
	};
	case 2: // Furthest
	{
		[position _logic, _allTargets] call Ares_fnc_GetFarthest;
	};
	default // Specific target
	{
		_allTargets select (_targetChooseAlgorithm - 3);
	};
};

if (local _unit) then
{
	[_unit,getPosWorld _selectedTarget,_stanceIndex,_doLineUp,_fireModeIndex,_duration] call Achilles_fnc_SuppressiveFire;
} else
{
	[_unit,getPosWorld _selectedTarget,_stanceIndex,_doLineUp,_fireModeIndex,_duration] remoteExec ["Achilles_fnc_SuppressiveFire", _unit];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
