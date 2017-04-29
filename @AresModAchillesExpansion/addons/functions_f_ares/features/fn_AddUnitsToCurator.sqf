/*
	Adds (or removes) a set of objects to all of the curator modules that are active.
	
	Parameters:
		0 - Array - The set of objects to add or remove from curator control.
		1 - Boolean - True to add the objects to curator control, false to remove them from curator control. Default is True.
*/

private _unitsToModify = [_this, 0, [], [[]]] call BIS_fnc_param;
private _addToCurator = [_this, 1, true, [true]] call BIS_fnc_param;

if (isNil "Ares_addUnitsToCuratorFunction") then
{
	Ares_addUnitsToCuratorFunction =
	{
		if (_this select 1) then
		{
			{ _x addCuratorEditableObjects [(_this select 0), true]; } foreach allCurators;
		}
		else
		{
			{ _x removeCuratorEditableObjects [(_this select 0), true]; } foreach allCurators;
		};
	};
	publicVariable "Ares_addUnitsToCuratorFunction";
};

private _simpleObjects = _unitsToModify select {isSimpleObject _x};
_unitsToModify = _unitsToModify - _simpleObjects;

[[_unitsToModify, _addToCurator], "Ares_addUnitsToCuratorFunction", false] call BIS_fnc_MP;

// handle simple objects
if (count _simpleObjects > 0) then
{
	private ["_object", "_logic", "_orient","_jip_id","_logic_list","_logic_group","_pos", "_displayName","_str_content"];
	
	if (_addToCurator) then
	{
		_logic_list = [];
		_logic_group = createGroup sideLogic;
		
		for "_i" from 1 to (count _simpleObjects) do
		{
			_logic = _logic_group createUnit ["Module_f", [0,0,0], [], 0, "NONE"];
			_logic_list pushBack _logic;
		};
		
		// delayed post modifications are curucial!
		uiSleep 5;
		{
			_object = _x;
			_box = boundingBoxReal _object;
			_pos = getPosASL _object;
			_orient = [vectorDir _object, vectorUp _object];
			
			_logic = _logic_list select _forEachIndex;
			_logic setPosASL _pos;
			_jip_id = [_logic, _orient] remoteExecCall ["setVectorDirAndUp", 0, _logic];
			// need initialization on first edit by Zeus
			_logic setVariable ["needInit", _jip_id];
			_object attachTo [_logic];
			_str_content = (str _object) splitString " ";
			_displayName = _str_content select (count _str_content - 1);
			[_logic, _displayName] remoteExecCall ["setName", 0, _logic];
			_logic addEventHandler ["Deleted", {_object = (attachedObjects (_this select 0)) select 0; deleteVehicle _object}];
		} forEach _simpleObjects;
		
		[_logic_list, true] call Ares_fnc_AddUnitsToCurator;
	} else
	{
		{
			_logic = attachedTo _x;
			if (not isNull _logic) then
			{
				detach _x;
				deleteVehicle _logic;
			};
		} forEach _simpleObjects;
	};
};

true