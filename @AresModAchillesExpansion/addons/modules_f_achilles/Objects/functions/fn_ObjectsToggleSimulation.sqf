////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/3/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsToggleSimulation.sqf
//  DESCRIPTION: Function for the module "enable/disable simulation"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

private _dialogResult = 
[
	localize "STR_TOGGLE_SIMULATION",
	[
		[
			localize "STR_ENABLE_SIMULATION", [localize "STR_TRUE", localize "STR_FALSE"]
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
private _allowed = if ((_dialogResult select 0) == 0) then {true} else {false};

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
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


#include "\achilles\modules_f_ares\module_footer.hpp"
