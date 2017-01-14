
_objects = param [0,[],[[]]];
_groupThem = param [1,true,[false]];
{
	_center_object = _x;
	_attached_objects = _center_object getVariable ["ACS_attached_objects",nil];
	if (not isNil "_attached_objects") then
	{
		if (_groupThem) then
		{
			_center_dir = direction _center_object;
			_center_pos = getPosWorld _center_object;
			_center_spawn_dir = _center_object getVariable ["ACS_center_dir", 0];
			[_center_object, _center_spawn_dir] remoteExec ['setDir',0,true];
			_theta = _center_spawn_dir - _center_dir;
			{
				_pos = getPosWorld _x;
				_rel_vector = _pos vectorDiff _center_pos;
				_rel_vector_corr = [(_rel_vector select 0) * cos _theta + (_rel_vector select 1) * sin _theta,-(_rel_vector select 0) * sin _theta + (_rel_vector select 1) * cos _theta,(_rel_vector select 2)];
				_x setPosWorld (_rel_vector_corr vectorAdd _center_pos);	
				
				_dir = direction _x;
				_rel_dir = _dir - _center_dir;
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