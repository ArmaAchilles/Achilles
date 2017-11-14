params[["_objects", [], [[]]], ["_groupThem", true, [false]]];

{
	private _center_object = _x;
	private _attached_objects = _center_object getVariable ["ACS_attached_objects", objNull];
	if (!isNull _attached_objects) then
	{
		if (_groupThem) then
		{
			private _center_dir = direction _center_object;
			private _center_pos = getPosWorld _center_object;
			private _center_spawn_dir = _center_object getVariable ["ACS_center_dir", 0];
			[_center_object, _center_spawn_dir] remoteExec ['setDir',0,true];
			private _theta = _center_spawn_dir - _center_dir;
			{
				private _pos = getPosWorld _x;
				private _rel_vector = _pos vectorDiff _center_pos;
				private _rel_vector_corr = [(_rel_vector select 0) * cos _theta + (_rel_vector select 1) * sin _theta,-(_rel_vector select 0) * sin _theta + (_rel_vector select 1) * cos _theta,(_rel_vector select 2)];
				_x setPosWorld (_rel_vector_corr vectorAdd _center_pos);

				private _dir = direction _x;
				private _rel_dir = _dir - _center_dir;
				_x attachTo [_center_object];
				[_x, _rel_dir] remoteExec ['setDir',0,true];
			} forEach _attached_objects;
			[_center_object, _center_dir] remoteExec ['setDir',0,true];
			[_attached_objects, false] call Ares_fnc_AddUnitsToCurator;
		} else
		{
			{
				detach _x;
			} forEach _attached_objects;
			[_attached_objects, true] call Ares_fnc_AddUnitsToCurator;
		};
	};
} forEach _objects;
