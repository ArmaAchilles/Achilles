////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/11/17
//	VERSION: 1.0
//  DESCRIPTION: Function for toggle Lamps
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private ["_buildings","_extend_count","_damage_fnc","_mean_damage"];

_center_pos = position _logic;

_dialogResult = 
[
	localize "STR_TOGGLE_LAMPS",
	[
		[localize "STR_MODE",[localize "STR_AUTOMATIC",localize "STR_SWITCH_OFF"],1],
		[(localize "STR_RANGE") + " [m]","","100"]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_lightOn = [true,false] select (_dialogResult select 0);
_radius = parseNumber (_dialogResult select 1);

_JIP_id = [[_center_pos,_radius,_lightOn],
{
	params ["_center_pos","_radius","_lightOn"];
	{  
	  [_x,_lightOn] call BIS_fnc_switchLamp;  
	} forEach (nearestObjects [_center_pos,["Building"],_radius]);
}] remoteExec ["spawn",0,_logic];

_logic setName format ["Toggle Lamp: JIP queue %1", _JIP_id];
_deleteModuleOnExit = false;

#include "\achilles\modules_f_ares\module_footer.hpp"
