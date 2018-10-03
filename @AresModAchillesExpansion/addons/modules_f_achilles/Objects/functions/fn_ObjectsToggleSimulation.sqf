////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/3/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsToggleSimulation.sqf
//  DESCRIPTION: Function for the module "enable/disable simulation"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

private _dialogResult =
[
	localize "STR_AMAE_TOGGLE_SIMULATION",
	[
		[
			localize "STR_AMAE_ENABLE_SIMULATION", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _allowed = (_dialogResult select 0) == 0;

if (isNull (_objects select 0)) then { _objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits };
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};
{
	[_x,_allowed] spawn
	{
		private _object = _this select 0;
		_allowed = _this select 1;
		_object enableSimulationGlobal _allowed;
		[_object,_allowed] remoteExec ["enableSimulationGlobal",2];
		_object setVariable ["enabledSimulation",_allowed,true];
	};
} forEach _objects;

#include "\achilles\modules_f_ares\module_footer.inc"
