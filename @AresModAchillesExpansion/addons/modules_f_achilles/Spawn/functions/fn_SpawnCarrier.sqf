#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	localize "STR_AMAE_USS_FREEDOM",
	[
		[localize "STR_AMAE_DIRECTION", ["N","NE","E","SE","S","SW","W","NW"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {}; 
private _dir = 180 + (_dialogResult select 0) * 45;

[[getPosATL _logic, _dir],
{
	params ["_posATL", "_dir"];
	 private _carrier = createVehicle ["Land_Carrier_01_base_F",[-300,-300,0],[],0,"CAN_COLLIDE"];
	 _carrier setPosATL _posATL;
	 _carrier setVectorDirAndUp [[sin _dir, cos _dir, 0], [0,0,1]];
	[_carrier] remoteExecCall ["BIS_fnc_Carrier01Init", 0, _carrier];
	{_x addCuratorEditableObjects [[_carrier], false]} forEach allCurators;
	// delete old carrier parts
	{deleteVehicle _x} forEach (nearestObjects [[-300,-300,0], ["Land_Carrier_01_hull_GEO_Base_F","Land_Carrier_01_hull_base_F","DynamicAirport_01_F"], 300, true]);
}, 2] call Achilles_fnc_spawn;

#include "\achilles\modules_f_ares\module_footer.hpp"
