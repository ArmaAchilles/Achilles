#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	localize "STR_AMAE_USS_LIBERTY",
	[
		[localize "STR_AMAE_USS_LIBERTY", ["N","NE","E","SE","S","SW","W","NW"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {}; 
private _dir = 180 + (_dialogResult select 0) * 45;

[[getPosATL _logic, _dir],
{
	params ["_posATL", "_dir"];
	 private _destroyer = createVehicle ["Land_Destroyer_01_base_F",[-300,-300,0],[],0,"CAN_COLLIDE"];
	 _destroyer setPosATL _posATL;
	 _destroyer setVectorDirAndUp [[sin _dir, cos _dir, 0], [0,0,1]];
	[_destroyer] remoteExecCall ["BIS_fnc_Destroyer01Init", 0, _destroyer];
	{_x addCuratorEditableObjects [[_destroyer], false]} forEach allCurators;
	// delete old carrier parts
	{deleteVehicle _x} forEach (nearestObjects [[-300,-300,0], ["Land_Destroyer_01_Boat_Rack_01_Base_F","Land_Destroyer_01_hull_base_F","ShipFlag_US_F"], 300, true]);
}, 2] call Achilles_fnc_spawn;

#include "\achilles\modules_f_ares\module_footer.hpp"
