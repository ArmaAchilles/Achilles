
private _objects = _this select 0;
//private _markers = _this select 3;

private _center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
} else
{
	screenToWorld getMousePosition;
};

private _object_clipboard = [];
private _saved_vehicles = [];
{
	private _object = vehicle _x;
	switch true do
	{
		case (_object isKindOf "Man"):
		{
			_object_clipboard pushBack 
			[
				typeOf _object,
				groupID (group _object),
				side _object,
				[
					getUnitLoadout _object,
					goggles _object
				],
				(position _object) vectorDiff _center_pos,
				direction _object,
				face _object,
				speaker _object,
				pitch _object,
				name _object,
				nameSound _object,
				rank _object,
				skill _object
			];
		};
		case (_object isKindOf "LandVehicle" or (_object isKindOf "Air") or (_object isKindOf "Ship")):
		{
			if (_object in _saved_vehicles) exitWith {};
			_saved_vehicles pushBack _object;

			private _crew_info_array = [];
			{
				_crew_info_array pushBack 
				[
					typeOf _x,
					groupID (group _x),
					side _x,
					[
						getUnitLoadout _x,
						goggles _x
					],
					assignedVehicleRole _x,
					face _x,
					speaker _x,
					pitch _x,
					name _x,
					nameSound _x,
					rank _x,
					skill _x
				];
			} forEach (crew _object);

			_object_clipboard pushBack 
			[
				typeOf _object,
				groupID (group _object),
				side _object,
				getPylonMagazines _object,
				(position _object) vectorDiff _center_pos,
				direction _object,
				_crew_info_array,
				fuel _object
			];
		};
	};
} forEach _objects;

Achilles_var_ObjectClipboard = _object_clipboard;

/*
_marker_clipboard = [];
{
	_marker_clipboard pushBack [markerType _x, markerText _x, markerColor _x, (markerPos _x) vectorDiff _center_pos, markerDir _x];
} forEach _markers;

Achilles_var_ObjectClipboard = [_object_clipboard,_marker_clipboard];
*/