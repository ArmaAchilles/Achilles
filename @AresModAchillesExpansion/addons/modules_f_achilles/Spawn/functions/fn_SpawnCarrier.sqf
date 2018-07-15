#include "\achilles\modules_f_ares\module_header.hpp"

#define HALF_BOUNDING_BOX_LENGTH	193.855
#define HALF_BOUNDING_BOX_WIDTH		50.4131
#define LINE_RGBA					[1,1,0,1]

// draw the location for the preplace mode
[
	"Achilles_id_drawBoatLocation",
	"onEachFrame",
	{
		params ["_logic"];
		private _pos = ASLToAGL getPosASL _logic vectorAdd [0,0,5];
		private _vecDir = vectorDir _logic;
		_vecDir set [2, 0];
		_vecDir = vectorNormalized _vecDir;
		_vecPerp = [-(_vecDir select 1), _vecDir select 0, 0];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply HALF_BOUNDING_BOX_WIDTH), _pos vectorAdd (_vecDir vectorMultiply HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply -HALF_BOUNDING_BOX_WIDTH), LINE_RGBA];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply -HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply HALF_BOUNDING_BOX_WIDTH), _pos vectorAdd (_vecDir vectorMultiply -HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply -HALF_BOUNDING_BOX_WIDTH), LINE_RGBA];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply HALF_BOUNDING_BOX_WIDTH), _pos vectorAdd (_vecDir vectorMultiply -HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply HALF_BOUNDING_BOX_WIDTH), LINE_RGBA];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply -HALF_BOUNDING_BOX_WIDTH), _pos vectorAdd (_vecDir vectorMultiply -HALF_BOUNDING_BOX_LENGTH) vectorAdd (_vecPerp vectorMultiply -HALF_BOUNDING_BOX_WIDTH), LINE_RGBA];
		drawLine3D [_pos, _pos vectorAdd (_vecDir vectorMultiply -30), LINE_RGBA];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply -30), _pos vectorAdd (_vecDir vectorMultiply -20) vectorAdd (_vecPerp vectorMultiply 10), LINE_RGBA];
		drawLine3D [_pos vectorAdd (_vecDir vectorMultiply -30), _pos vectorAdd (_vecDir vectorMultiply -20) vectorAdd (_vecPerp vectorMultiply -10), LINE_RGBA];
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

#include "\achilles\modules_f_ares\module_footer.hpp"
