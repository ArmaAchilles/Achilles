/*
 * Author: BaerMitUmlaut
 * Waypoint function for the fast rope waypoint.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint position <ARRAY>
 *
 * Return Value:
 * true
 *
 * Example:
 * [_group, [6560, 12390, 0]] call ace_fastroping_fnc_deployAIWayoint
 *
 * Public: No
 */

params [["_group", grpNull, [grpNull]], ["_position", [0, 0, 0], [[]], 3]];
private ["_vehicle", "_commander", "_speedMode"];

_vehicle = vehicle leader _group;
_commander = effectiveCommander _vehicle;
_speedMode = speedMode _group;
hint 'gg';
// - Approach -----------------------------------------------------------------
if (_vehicle distance2D _position > 50) then {
    _group setSpeedMode "LIMITED";
    _vehicle flyInHeight 9;
	hint 'hh';
    _commander doMove _position;
    waitUntil {_vehicle distance2D _position < 50};
    waitUntil {vectorMagnitude (velocity _vehicle) < 3};
    //doStop _commander;
};

// - Deployment ---------------------------------------------------------------
[_vehicle] call ace_fastroping_fnc_deployAI;
waitUntil {!((_vehicle getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo [])};
waitUntil {(_vehicle getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo []};
_group setSpeedMode _speedMode;
_vehicle flyInHeight 20;

true
