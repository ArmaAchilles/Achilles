_objects = _this select 0;
_markers = _this select 3;

_center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
} else
{
	screenToWorld getMousePosition;
};

_object_clipboard = [];
_saved_vehicles = [];
{
	_object = vehicle _x;
	switch true do
	{
		case (_object isKindOf "Man"):
		{
			_object_clipboard pushBack [typeOf _object, groupID group _object, side _object, getUnitLoadout _object, (position _object) vectorDiff _center_pos, direction _object, []];
		};
		case (_object isKindOf "LandVehicle" or (_object isKindOf "Air") or (_object isKindOf "Ship")):
		{
			if (_object in _saved_vehicles) exitWith {};
			_saved_vehicles pushBack _object;
			_crew_info_array = [];
			{
				_crew_info_array pushBack [typeOf _x, groupID group _x, side _x, getUnitLoadout _x, assignedVehicleRole _x];
			} forEach (crew _object);
			_object_clipboard pushBack [typeOf _object, groupID group _object, side _object, [], (position _object) vectorDiff _center_pos, direction _object, _crew_info_array];
		};
		default
		{
			_object_clipboard pushBack [typeOf _object, group _object, "", [], (position _object) vectorDiff _center_pos, direction _object, []];
		};
	};
} forEach _objects;

Achilles_var_ObjectClipboard = _object_clipboard;

/*
_entities = _this select 0;
_markers = _this select 3;

// get mouse cursor as center position for the copied entities
_center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
} else
{
	screenToWorld getMousePosition;
};

{
	// save entity attributes
	_entitiy = vehicle _x;
	_entity_attributes = _entitiy call Achilles_fnc_getEntityAttributes;
	_entity_attributes set [1,(_entity_attributes select 1) vectorDiff _center_pos];
	_entities_clipboard pushBack (_entitiy call Achilles_fnc_getEntityAttributes);
	_group = group _entitiy;
	
	// save group attributes
	if (not (isNull _group) and not (_group in _saved_groups)) then
	{
		_group_clipboard pushBack (_group call Achilles_fnc_getGroupAttributes);
		_saved_groups pushBack _group;
	};
} forEach _entities;

_marker_clipboard = [];

{
	_marker_clipboard pushBack ["_USER_DEFINED_" + _x, (markerPos _x) vectorDiff _center_pos, markerDir _x, markerType _x, markerText _x, markerColor _x];
} forEach _markers;

Achilles_var_ObjectClipboard = [_entities_clipboard,_group_clipboard,_marker_clipboard];
*/
