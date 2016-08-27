/*
 * Author: BaerMitUmlaut, modified by Kex
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

// Kex: check if ACE avaiable
if (not (isClass (configfile >> "CfgPatches" >> "ace_main"))) exitWith {true};

// Kex: check if vehicle is capable of FRIES and if true equip it with FIRES
[_vehicle]  call ace_fastroping_fnc_equipFRIES; 
if (not ([_vehicle]  call ace_fastroping_fnc_canPrepareFRIES)) exitWith {true};

// Kex: prevent pilot from being stupid
_group allowFleeing 0;
_pilot = driver _vehicle;
_pilot setSkill 1;

// - Approach -----------------------------------------------------------------
if (_vehicle distance2D _position > 50) then 
{
    _group setSpeedMode "LIMITED";
    _commander doMove _position;
	waitUntil {unitready _vehicle};
	_vehicle flyInHeight 21;
	_vehicle doMove _position;
    waitUntil {((getPos _vehicle) select 2) < 20};
    waitUntil {vectorMagnitude (velocity _vehicle) < 3};
    //doStop _commander;
};

// - Deployment ---------------------------------------------------------------
[_vehicle] call ace_fastroping_fnc_deployAI;
waitUntil {!((_vehicle getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo [])};
waitUntil {(_vehicle getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo []};
_group setSpeedMode _speedMode;
_vehicle flyInHeight 20;
_vehicle doMove _position;

true
