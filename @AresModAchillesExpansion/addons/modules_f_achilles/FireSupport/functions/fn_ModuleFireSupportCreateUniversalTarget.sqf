/*
	Author: CreepPork_LV

	Description:
		A universal target module that can be used for all modules that require a target.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#define LASER_TARGETS	["LaserTargetE", "LaserTargetW"]
#define SIDE_NAMES	[localize "STR_AMAE_OPFOR", localize "STR_AMAE_BLUFOR", localize "STR_AMAE_INDEPENDENT"]

#include "\achilles\modules_f_ares\module_header.inc"

if (isNil "Achilles_TargetCount") then { Achilles_TargetCount = 0 };

private _targetPhoneticName = [Achilles_TargetCount] call Ares_fnc_GetPhoneticName;
private _targetName = format [localize "STR_AMAE_TARGET", _targetPhoneticName];

private _dialogResult =
[
	localize "STR_AMAE_CREATE_TARGET",
	[
		["TEXT", localize "STR_AMAE_NAME", [], _targetName, true],
		["COMBOBOX", localize "STR_AMAE_ATTACH_LASER_TARGET_FOR", [localize "STR_NOBODY"] + SIDE_NAMES]
	]
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_targetName", "_laserTargetIdx"];
_laserTargetIdx = _laserTargetIdx - 1;

_logic setName _targetName;
_logic setVariable ["SortOrder", Achilles_TargetCount];

if (_laserTargetIdx >= 0) then
{
	if (_laserTargetIdx > 1) then
	{
		// handle independent as they don't have their own laser target
		_laserTargetIdx = [1, 0] select ([west, independent] call BIS_fnc_sideIsEnemy);
	};
	_laserTarget = (LASER_TARGETS select _laserTargetIdx) createVehicle [0,0,0];
	_laserTarget attachTo [_logic, [0,0,0]];
	// we need no deleted event handler, since laser targets already get automatically deleted 
	// when the object they are attached to gets deleted.
};

[format [localize "STR_AMAE_CREATED_TARGET", _targetName]] call Ares_fnc_showZeusMessage;

Achilles_TargetCount = Achilles_TargetCount + 1;
publicVariable "Achilles_TargetCount";

_deleteModuleOnExit = false;

#include "\achilles\modules_f_ares\module_footer.inc"