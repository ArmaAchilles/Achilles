#include "\achilles\modules_f_ares\module_header.inc.sqf"

#define BOUNDING_BOX_LENGTH			387.71
#define BOUNDING_BOX_WIDTH			100.8262

// draw the location for the preplace mode
[
	"Achilles_id_drawBoatLocation",
	"onEachFrame",
	{
		params ["_logic"];
		// model position shifted by +5 m in Z direction in order to prevent intersections with the water surface
		private _pos = ASLToAGL getPosASL _logic vectorAdd [0,0,5];
		// get basis vectors for the model XY plane
		private _vecDir = vectorDir _logic;
		_vecDir set [2, 0];
		_vecDir = vectorNormalized _vecDir;
		// draw projection of the bounding box on the model XY plane
		[_pos, _vecDir, [0,0,1], BOUNDING_BOX_LENGTH, BOUNDING_BOX_WIDTH] call Achilles_fnc_drawRectangle3D;
		// draw an arrow for the heading on the model XY plane
		[_pos, _vecDir vectorMultiply -1, [0,0,1]] call Achilles_fnc_drawArrow3D;
	},
	[_logic]
] call BIS_fnc_addStackedEventHandler;

// start preplace mode
[_logic] call Achilles_fnc_PreplaceMode;

// delete the drawings
["Achilles_id_drawBoatLocation", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

if (isNull _logic) exitWith {}; 

// spawn the acual boat
[[getPosATL _logic, getDir _logic],
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

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
