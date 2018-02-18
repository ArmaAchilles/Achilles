params [["_group", grpNull, [grpNull]], ["_wpPos", [], [[]], 3], ["_target", objNull, [objNull]]];

private _wp = [_group,currentwaypoint _group];
_wp setWaypointDescription localize "STR_AMAE_WP_REPAIR";
_group move position leader _group;

// get the engineer
private _engineer = objNull;
{
	if (alive _x and {_x getUnitTrait "engineer"}) exitWith
	{
		_engineer = _x;
	};
} forEach units _group;
if (isNull _engineer) exitWith {true};

// find nearest vehicle
private _nearestVehicles = (nearestObjects [_wpPos, ["LandVehicle","Air"], 50]) select {alive _x and {isTouchingGround _x}};
_nearestVehicles params [["_vehicle", objNull,[objNull]]];
if (isNull _vehicle) exitWith {true};

_vehicle forceSpeed 0;
_engineer commandMove position _vehicle;
waitUntil
{
	sleep 1;
	// "Do not touch!" - Kex
	(not alive _engineer) or {(not alive _vehicle) or {unitReady _engineer}};
};
if ((alive _engineer) and {alive _vehicle} and {_engineer distance _vehicle <= 10}) then
{
	_engineer doWatch _vehicle;
	sleep 1;
	_engineer action ["repairVehicle", _vehicle];
	sleep 10;
	_vehicle forceSpeed -1;
} else
{
	if (alive _engineer) then {_engineer doMove position leader _group};
	if (alive _vehicle) then {_vehicle forceSpeed -1};
};
true
