////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Anton Struyk, Kex
// DATE: 			7/16/17
// VERSION: 		AMAE003
// DESCRIPTION:		Adds (or removes) a set of objects to all of the curator modules that are active.
//					Has to be executed on a Zeus player's machine, not on the server.
//
// ARGUMENTS:		0: ARRAY - The set of objects to add or remove from curator control.
//					1: BOOLEAN - True to add the objects to curator control, false to remove them from curator control. Default is True.
//					2: Boolean - True to also consider simple objects. Default is True.
//
// RETURNS:			nothing
//
// Example:			[_object_list, true] call Ares_fnc_AddUnitsToCurator;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_unitsToModify", [], [[]]], ["_addToCurator", true, [true]], ["_includeSimpleObjects", false, [false]]];

private _simpleObjects = _unitsToModify select {isSimpleObject _x};
_unitsToModify = _unitsToModify - _simpleObjects;

if (_addToCurator) then
{
	[getAssignedCuratorLogic player, [_unitsToModify, true]] remoteExecCall ["addCuratorEditableObjects", 2];
} else
{
	[getAssignedCuratorLogic player, [_unitsToModify, true]] remoteExecCall ["removeCuratorEditableObjects", 2];
};

// handle simple objects
if (_includeSimpleObjects and {count _simpleObjects > 0}) then
{
	private ["_object", "_logic","_logic_list","_logic_group","_pos", "_displayName","_str_content"];

	if (_addToCurator) then
	{
		_simpleObjects = _simpleObjects select {isNull (_x getVariable ["master", objNull])};
		if (_simpleObjects isEqualTo []) exitWith {};

		_logic_list = [];
		_logic_group = createGroup sideLogic;
		_logic_group deleteGroupWhenEmpty true;

		{
			_object = _x;
			_pos = position _object;
			_pos = [getPosATL _object, getPosASL _object] select (surfaceIsWater _pos);

			_logic = _logic_group createUnit ["module_f", _pos, [], 0, "CAN_COLLIDE"];
			_logic setVectorDirAndUp [vectorDir _object, vectorUp _object];
			waitUntil {direction _logic - direction _object < 0.01 or {isNull _logic}};
			_object attachTo [_logic];

			_logic_list pushBack _logic;
		} forEach _simpleObjects;

		// critical delay for proper name setting of game logics
		waitUntil {{name _x != "" and {!isNull _x}} count _logic_list == 0};
		private _allocation_error_cases = 0;
		for "_i" from 0 to (count _simpleObjects - 1) do
		{
			_object = _simpleObjects select _i;
			_logic = _logic_list select _i;

			if (!isNull _logic) then
			{
				_str_content = (str _object) splitString " ";
				_displayName = _str_content select (count _str_content - 1);
				[_logic, _displayName] remoteExecCall ["setName", 0, _logic];
			} else
			{
				_allocation_error_cases = _allocation_error_cases + 1;
			};
		};
		if (_allocation_error_cases > 0) then {hint format ["Allocation error: Could not create reference logic for simple object! (occured in %1/%2 cases)", _allocation_error_cases, count _logic_list]};

		if (_addToCurator) then
		{
			[getAssignedCuratorLogic player, [_logic_list, true]] remoteExecCall ["addCuratorEditableObjects", 2];
		} else
		{
			[getAssignedCuratorLogic player, [_logic_list, true]] remoteExecCall ["removeCuratorEditableObjects", 2];
		};
	} else
	{
		{
			_object = _x;
			_logic = attachedTo _object;
			if (!isNull _logic) then
			{
				detach _object;
				deleteVehicle _logic;
			};
		} forEach _simpleObjects;
	};
};

true
