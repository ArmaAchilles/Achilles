////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Anton Struyk, Kex, CreepPork_LV
// DATE: 			22/12/17
// VERSION: 		AMAE010
// DESCRIPTION:		Adds (or removes) a set of objects to all of the curator modules that are active.
//					Has to be executed on a Zeus player's machine, not on the server.
//
// ARGUMENTS:		0: ARRAY - The set of objects to add or remove from curator control.
//					1: BOOLEAN - True to add the objects to curator control, false to remove them from curator control. Default is True.
//					2: Boolean - True to also consider simple objects (experimental!). Default is False.
//
// RETURNS:			SCALAR - Units added or removed.
//
// Example:			[_object_list, true] call Ares_fnc_AddUnitsToCurator;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_unitsToModify", [], [[]]], ["_addToCurator", true, [true]], ["_includeSimpleObjects", false, [false]]];

private _simpleObjects = _unitsToModify select {isSimpleObject _x};
_unitsToModify = _unitsToModify - _simpleObjects;

private _editableObjects = curatorEditableObjects (getAssignedCuratorLogic player);

private _objectsToBeModified = [];
{
	if (_addToCurator) then
	{
		if (!(_x in _editableObjects) && !isNull _x && !(isAgent teamMember _x)) then
		{
			_objectsToBeModified pushBackUnique _x;
		};
	}
	else
	{
		if (_x in _editableObjects && !isNull _x && !(_x isEqualTo Achilles_var_latestModuleLogic)) then
		{
			_objectsToBeModified pushBackUnique _x;
		};
	};
} forEach _unitsToModify;

if (_addToCurator) then
{
	[getAssignedCuratorLogic player, [_objectsToBeModified, true]] remoteExecCall ["addCuratorEditableObjects", 2];
}
else
{
	[getAssignedCuratorLogic player, [_objectsToBeModified, true]] remoteExecCall ["removeCuratorEditableObjects", 2];
};

private _logicList = [];

// handle simple objects
if (_includeSimpleObjects and {count _simpleObjects > 0}) then
{
	if (_addToCurator) then
	{
		_simpleObjects = _simpleObjects select {isNull (_x getVariable ["master", objNull])};
		if (_simpleObjects isEqualTo []) exitWith {};

		private _logic_group = createGroup sideLogic;
		_logic_group deleteGroupWhenEmpty true;

		{
			private _object = _x;
			private _posATL = getPosATL _object;

			private _logic = _logic_group createUnit ["module_f", _posATL, [], 0, "CAN_COLLIDE"];
			_logic setPosATL _posATL;
			_logic setVectorDirAndUp [vectorDir _object, vectorUp _object];
			
			// set master/slave for the handleCuratorObjectEdited event handler
			_object setVariable ["master", _logic];
			_logic setVariable ["slave", _object];
			
			// move ownership to Zeus
			[_object, clientOwner] remoteExecCall ["setOwner", 2];

			_logicList pushBack _logic;
		} forEach _simpleObjects;

		// critical delay for proper name setting of game logics
		waitUntil {{name _x != "" and {!isNull _x}} count _logicList == 0};
		private _allocation_error_cases = 0;
		for "_i" from 0 to (count _simpleObjects - 1) do
		{
			private _object = _simpleObjects select _i;
			private _logic = _logicList select _i;

			if (!isNull _logic) then
			{
				private _str_content = (str _object) splitString " ";
				private _displayName = _str_content select (count _str_content - 1);
				[_logic, _displayName] remoteExecCall ["setName", 0, _logic];
			}
			else
			{
				_allocation_error_cases = _allocation_error_cases + 1;
			};
		};
		if (_allocation_error_cases > 0) then {hint format ["Allocation error: Could not create reference logic for simple object! (occured in %1/%2 cases)", _allocation_error_cases, count _logicList]};

		[getAssignedCuratorLogic player, [_logicList, true]] remoteExecCall ["addCuratorEditableObjects", 2];
	}
	else
	{
		{
			private _object = _x;
			private _logic = _object getVariable ["master", objNull];
			if (!isNull _logic) then
			{
				// move ownership to Server
				[_object, 2] remoteExecCall ["setOwner", 2];
			
				// delete variables and logic
				_object setVariable ["master", nil];
				_logic setVariable ["slave", nil];
				deleteVehicle _logic;
				
				_logicList pushBack _object;
			};
		} forEach _simpleObjects;
	};
};

(count _objectsToBeModified) + (count _logicList);