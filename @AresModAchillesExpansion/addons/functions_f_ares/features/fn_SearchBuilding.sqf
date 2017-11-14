/*
Purpose: have an AI squad search a building.

Parameters:
	0 - Group or Object - The group (or a member of the group) that will be searching the building.
	1 - (Optional) Number - The radius around the group leader to use when generating the set of possible buildings to search. Default 50.
	2 - (Optional) String - The strategy to use when choosing which of the candidate houses to search. One of "NEAREST" or "RANDOM". Default "RANDOM".
	3 - (Optional) Position Array - The center point to use as the search. Default is group leader position.
	4 - (Optional) Boolean - True to include the group leader in the search, False to have him wait outside. Default is 'False'.
	5 - (Optional) Boolean - True to have units stay in their building positions, false to return outside after completing the search. Default false.
	6 - (Optional) Boolean - True to delete all current waypoints.
	7 - (Optional) Boolean - True to show debug spheres during search, false otherwise. Default false.

JTD Building Search Script
	by Trexian
Credits:
	OFPEC
	Rommel for CBA function searchNearby
	Tophe for random house patrol

Testers/Feedback:
	MadRussian
	GvsE
	Kremator
	Manzilla

	Imported from http://forums.bistudio.com/showthread.php?112775-JTD-Building-Search-script
	Modified by Anton Struyk and Kex
*/

private ["_grpFM", "_FunctionsManager", "_bldgLoc", "_searchersT", "_searcherCount", "_s", "_checkTime", "_currWP", "_t", "_nameMarker", "_marker", "_bldgBB", "_wpRad", "_wp", "_totTime", "_activeBP", "_loop", "_cycle", "_unitSelect", "_units"];
private _group = [_this, 0] call BIS_fnc_param;

// Must be run where group leader is local.
if (!local _group) exitWith {};

// Extract necessary values from parameters
if (_group isEqualType grpNull) then {_group = group (_this select 0)};
private _leader = leader _group;
private _ldrPos = getPos _leader;
private _previousBehaviour = behaviour _leader;
private _srchRad = [_this, 1, 50, [1]] call BIS_fnc_param;
private _whichOne = [_this, 2, "RANDOM", ["RANDOM"]] call BIS_fnc_param;
private _initialPos = [_this, 3, _ldrPos, [[]], 3] call BIS_fnc_param;
private _includeLeaderInSearch = [_this, 4, false, [false]] call BIS_fnc_param;
private _occupy = [_this, 5, false, [false]] call BIS_fnc_param;
_delete_waypoint = [_this, 6, false, [false]] call BIS_fnc_param;
_debug = [_this, 7, false, [false]] call BIS_fnc_param;

// This file needs to be Self-Contained and use only standard BIS functions
// since it will be run on the server and Ares functions may not be available.
_arrayShuffle = {
	private _array = _this select 0;
	private _count = count _array;
	private _arrayN = [];
	private _arrayT = [];
	private _c = 0;
	private _r = 0;

	while {_c < _count} do
	{
		while {_r in _arrayT} do
		{_r = floor (random _count);
		};
		_arrayT = _arrayT + [_r];
		_arrayN set [_c, _array select _r];
		_c = _c + 1;
	};

	_arrayN
};

// Check parameters
if (_srchRad < 1) then {_srchRad = 1};
if ((_whichOne != "NEAREST") && (_whichOne != "RANDOM")) then {_whichOne = "RANDOM"};

// remove group's waypoints
if (_delete_waypoint) then
{
	private _wpArray = waypoints _group;
	_wpCnt = count _wpArray;
	if (_wpCnt > 1) then
	{
		for "_d" from 0 to _wpCnt do
		{
			deleteWaypoint [_group, _d];
		};
	};
};

// Go through all the nearby buildings and make sure they at least have one searchable space. If they
// do then add them to our list of candidates.
private _bldgArray = [];
private _tempArray = nearestObjects [_initialPos, ["building"], _srchRad, true];  // count number of buildings in array
for "_b" from 0 to (count _tempArray - 1) do
{
	private _bldg = _tempArray select _b;
	private _bldgPos = _bldg buildingPos 0;
	if (((_bldgPos select 0) != 0) && ((_bldgPos select 1) != 0)) then
	{
		_bldgArray = _bldgArray + [_bldg];
	};
};

// Check that we could actually find a building to search.
if (_bldgArray isEqualTo []) exitWith {	false };

// Choose the building to be searched - either the nearest or a random one.
private _bldgSelect = if (_whichOne == "NEAREST") then
{
	// nearestObjects is sorted from nearest -> farthest objects. Since we didn't change the order when
	// we filtered candidate houses we can just choose the first element here.
	_bldgArray select 0;
}
else
{
    _bldgArray call BIS_fnc_selectRandom;
};

_bldgLoc = getPos _bldgSelect;

// Make the group ready for shootin'
_group setbehaviour "AWARE";

// Generate an array of all the positions in the building to search.
private _positionsInBuilding = [];
_debugMarkers = [];
_positionCount = 0;
while { !((_bldgSelect buildingPos _positionCount) isEqualTo [0,0,0]) } do
{
	_currentPosition = _bldgSelect buildingPos _positionCount;
	// Kex: exclude part which caused error!!!
	/*
	// Check that the point isn't outside.
	if (!lineIntersects [_currentPosition, [_currentPosition select 0, _currentPosition select 1, (_currentPosition select 2) + 25], objNull, objNull]) then
	{
		_positionsInBuilding = _positionsInBuilding + [_currentPosition];
		if (_debug) then
		{
			_debugMarkers = _debugMarkers + ["Sign_Sphere100cm_F" createVehicle [0,0,0]];
			(_debugMarkers select (count _debugMarkers - 1)) setPosAtl _currentPosition;
		};
	};
	_positionCount = _positionCount + 1;
	*/
	_positionsInBuilding = _positionsInBuilding + [_currentPosition];
	_positionCount = _positionCount + 1;
};

// Determine the list of potential searchers. Only allocate the same number of searchers
// as there are positions in the building.
private _searchers = [];
{
	_x setVariable ["Ares_isSearching", false];
	_searchers pushBack [_x];
} forEach ((units _group) select (_includeLeaderInSearch || (_leader != _x))) select (!isNull _x && alive _x);

// Shuffle the order of the searcher array so that we have somewhat varied search behaviour.
// This way the same guys don't search the same places if you do things twice.
//_searchers = [_searchers] call _arrayShuffle;

// loop to string out the units
_isAnySearcherAlive = true;
scopeName "bldgSearchMainScope";
{
	// Get the first searcher that is available for tasking. If none
	// is available for tasking wait until one becomes available.
	_currentSearcherIndex = -1;
	while {_isAnySearcherAlive && _currentSearcherIndex == -1} do
	{
		// Look for a ready searcher
		_isAnySearcherAlive = false;
		{
			if (alive _x) then
			{
				_isAnySearcherAlive = true;
				if (not (_x getVariable ["Ares_isSearching", false])) exitWith { _currentSearcherIndex = _foreachIndex; };
			};
		} foreach _searchers;

		if (_currentSearcherIndex == -1 && _isAnySearcherAlive) then
		{
			// Wait a bit and try again.
			sleep 1;
		};
	};

	if (_currentSearcherIndex != -1) then
	{
		// Send the searcher to the current building position.
		_searcher = _searchers select _currentSearcherIndex;
		_searcher forceSpeed -1;
		doStop _searcher;
		_searcher doMove _x;
		_searcher setVariable ["Ares_isSearching", true];
		_searcher setVariable ["Ares_searchLocation", (ATLtoASL _x)];
		_searcher setVariable ["Ares_searchStartTime", daytime];
		if (_debug) then
		{
			_debugMarker = "Sign_Sphere25cm_F" createVehicle [0,0,0];
			_debugMarker attachTo [_searcher, [0,0,2]];
			_searcher setVariable ["Ares_searchingDebugMarker", _debugMarker];
		};

		_searcher spawn
		{
			_debugMarker = _this getVariable ["Ares_searchingDebugMarker", objNull];
			while {true} do
			{
				if ((getPosASL _this) vectorDistance (_this getVariable ["Ares_searchLocation", [0,0,0]]) < 1
					/*&& !lineIntersects [eyepos _this, (_this getVariable ["Ares_searchLocation", [0,0,0]]), _this, _debugMarker]*/) exitWith {};
				if (moveToCompleted _this) exitWith {};
				if (moveToFailed _this) exitWith {};
				if (dayTime > (_this getVariable ["Ares_searchStartTime", dayTime + 10]) + (0.5/60) ) exitWith {};
				sleep 0.5;
			};
			if (!isNil "_debugMarker") then
			{
				_this setVariable ["Ares_searchingDebugMarker", objNull];
				deleteVehicle _debugMarker;
			};
			_this setVariable ["Ares_isSearching", false];
			//doStop _this;
			_this forceSpeed 0;
		};
	};
} foreach _positionsInBuilding;

// Wait until all units are done searching.
waitUntil {sleep 1; count (_searchers select {_x getVariable ["Ares_isSearching", false]}) == 0};

_group setbehaviour _previousBehaviour;

// The units will end up in a position inside the building.
if (_occupy) then
{
	// Don't need to do anything to move the units around. They're already in position.
	{
		_x forceSpeed 0;
	} forEach _searchers;
}
else
{
	// Make the units return to the group and go back to following the leader.
	{
		_x forceSpeed -1;
		_x doMove _ldrPos;
		[_x, _leader] spawn
			{
				_unit = _this select 0;
				_leader = _this select 1;
				waitUntil { moveToCompleted _unit || moveToFailed _unit };
				_unit doFollow _leader;
			};
	} foreach _searchers;
};

if (_debug) then
{
	{
		deleteVehicle _x;
	} forEach _debugMarkers;
};

true
