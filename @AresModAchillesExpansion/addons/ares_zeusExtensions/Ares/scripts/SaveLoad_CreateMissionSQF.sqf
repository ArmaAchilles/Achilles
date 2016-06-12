[
	"Save/Load",
	"Generate Mission SQF",
	{
		_radius = 100;
		_position = _this select 0;

		_dialogResult =
			[
				"Generate Mission SQF",
				[
					["Radius", ["50m", "100m", "500m", "1km", "2km", "5km", "Entire Map"], 6],
					["Include AI?", ["Yes", "No"]],
					["Include Empty Vehicles?", ["Yes", "No"]],
					["Include Objects?", ["Yes", "No"]],
					["Include Markers?", ["Yes", "No"], 1]
				]
			] call Ares_fnc_ShowChooseDialog;
		if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };
		
		["User chose radius with index '%1'", _dialogResult] call Ares_fnc_LogMessage;
		_radius = 100;
		switch (_dialogResult select 0) do
		{
			case 0: { _radius = 50; };
			case 1: { _radius = 100; };
			case 2: { _radius = 500; };
			case 3: { _radius = 1000; };
			case 4: { _radius = 2000; };
			case 5: { _radius = 5000; };
			case 6: { _radius = -1; };
			default { _radius = 100; };
		};
		_includeUnits = if (_dialogResult select 1 == 0) then { true; } else { false; };
		_includeEmptyVehicles = if (_dialogResult select 2 == 0) then { true; } else { false; };
		_includeEmptyObjects = if (_dialogResult select 3 == 0) then { true; } else { false; };
		_includeMarkers = if (_dialogResult select 4 == 0) then { true; } else { false; };

		_objectsToFilter = curatorEditableObjects (allCurators select 0);
		_emptyObjects = [];
		_emptyVehicles = [];
		_groups = [];
		{
			_ignoreFlag = false;
			if ((typeOf _x) in Ares_EditableObjectBlacklist || _x == player || isPlayer _x) then
			{
				_ignoreFlag = true;
			};

			if (!_ignoreFlag && ((_x distance _position <= _radius) || _radius == -1)) then
			{
				["Processing object: %1 - %2", _x, typeof(_x)] call Ares_fnc_LogMessage;
				_ignoreFlag = true;
				_isUnit = (_x isKindOf "CAManBase")
					|| (_x isKindOf "car")
					|| (_x isKindOf "tank")
					|| (_x isKindOf "air")
					|| (_x isKindOf "StaticWeapon")
					|| (_x isKindOf "ship");
				if (_isUnit) then
				{
					if (_x isKindOf "CAManBase") then
					{
						["Is a man."] call Ares_fnc_LogMessage;
						if ((group _x) in _groups) then
						{
							["In an old group."] call Ares_fnc_LogMessage;
						}
						else
						{
							["In a new group."] call Ares_fnc_LogMessage;
							_groups pushBack (group _x);
						};
						
					}
					else
					{
						if (count crew _x > 0) then
						{
							["Is a vehicle with units."] call Ares_fnc_LogMessage;
							if ((group _x) in _groups) then
							{
								["In an old group."] call Ares_fnc_LogMessage;
							}
							else
							{
								["In a new group."] call Ares_fnc_LogMessage;
								_groups pushBack (group _x);
							};
						}
						else
						{
							["Is an empty vehicle."] call Ares_fnc_LogMessage;
							_emptyVehicles pushBack _x;
						};
					};
				}
				else
				{
					if (_x isKindOf "Logic") then
					{
						["Is a logic. Ignoring."] call Ares_fnc_LogMessage;
					}
					else
					{
						["Is an empty vehicle."] call Ares_fnc_LogMessage;
						_emptyObjects pushBack _x;
					};
				};
			}
			else
			{
				["Ignoring object: %1 - %2", _x, typeof(_x)] call Ares_fnc_LogMessage;
			};
		} forEach _objectsToFilter;
		
		_output = [];
		if (!_includeUnits) then { _groups = []; };
		if (!_includeEmptyVehicles) then { _emptyVehicles = []; };
		if (!_includeEmptyObjects) then { _emptyObjects = []; };

		_totalUnitsProcessed = 0;
		{
			_output pushBack format [
				"_newObject = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; _newObject setPosASL %3; _newObject setVectorDirAndUp [%4, %5];",
				(typeOf _x),
				(position _x),
				(getPosASL _x),
				(vectorDir _x),
				(vectorUp _x)];
		} forEach _emptyObjects + _emptyVehicles;
		
		{
			_sideString = "";
			switch (side _x) do
			{
				case east: { _sideString = "east"; };
				case west: { _sideString = "west"; };
				case resistance: { _sideString = "resistance"; };
				case civilian: { _sideString = "civilian"; };
				default { _sideString = "?"; };
			};
			_output pushBack format [
				"_newGroup = createGroup %1; ",
				_sideString];
			_groupVehicles = [];
			// Process all the infantry in the group
			{
				if (vehicle _x == _x) then
				{
					_output pushBack format [
						"_newUnit = _newGroup createUnit ['%1', %2, [], 0, 'CAN_COLLIDE']; _newUnit setSkill %3; _newUnit setRank '%4'; _newUnit setFormDir %5; _newUnit setDir %5; _newUnit setPosASL %6;",
						(typeOf _x),
						(position _x),
						(skill _x),
						(rank _x),
						(getDir _x),
						(getPosASL _x)];
				}
				else
				{
					if (not ((vehicle _x) in _groupVehicles)) then
					{
						_groupVehicles pushBack (vehicle _x);
					};
				};
				_totalUnitsProcessed = _totalUnitsProcessed + 1;
			} forEach (units _x);
			
			// Create the vehicles that are part of the group.
			{
				_output pushBack format [
					"_newUnit = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; createVehicleCrew _newUnit; (crew _newUnit) join _newGroup; _newUnit setDir %3; _newUnit setFormDir %3; _newUnit setPosASL %4;",
					(typeOf _x),
					(position _x),
					(getDir _x),
					(getPosASL _x)];
			} forEach _groupVehicles;
			
			// Set group behaviours
			_output pushBack format [
				"_newGroup setFormation '%1'; _newGroup setCombatMode '%2'; _newGroup setBehaviour '%3'; _newGroup setSpeedMode '%4';",
				(formation _x),
				(combatMode _x),
				(behaviour (leader _x)),
				(speedMode _x)];
				
			{
				if (_forEachIndex > 0) then
				{
					_output pushBack format [
						"_newWaypoint = _newGroup addWaypoint [%1, %2]; _newWaypoint setWaypointType '%3';%4 %5 %6",
						(waypointPosition _x),
						0,
						(waypointType _x),
						if ((waypointSpeed _x) != 'UNCHANGED') then { "_newWaypoint setWaypointSpeed '" + (waypointSpeed _x) + "'; " } else { "" },
						if ((waypointFormation _x) != 'NO CHANGE') then { "_newWaypoint setWaypointFormation '" + (waypointFormation _x) + "'; " } else { "" },
						if ((waypointCombatMode _x) != 'NO CHANGE') then { "_newWaypoint setWaypointCombatMode '" + (waypointCombatMode _x) + "'; " } else { "" }
						];
				};
			} forEach (waypoints _x)
		} forEach _groups;
		
		if (_includeMarkers) then
		{
			{
				_markerName = "Ares_Imported_Marker_" + str(_forEachIndex);
				_output pushBack format [
					"_newMarker = createMarker ['%1', %2]; _newMarker setMarkerShape '%3'; _newMarker setMarkerType '%4'; _newMarker setMarkerDir %5; _newMarker setMarkerColor '%6'; _newMarker setMarkerAlpha %7; %8 %9",
					_markerName,
					(getMarkerPos _x),
					(markerShape _x),
					(markerType _x),
					(markerDir _x),
					(getMarkerColor _x),
					(markerAlpha _x),
					if ((markerShape _x) == "RECTANGLE" ||(markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerSize " + str(markerSize _x) + ";"; } else { ""; },
					if ((markerShape _x) == "RECTANGLE" || (markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerBrush " + str(markerBrush _x) + ";"; } else { ""; }
					];
			} forEach allMapMarkers;
		};
		
		_text = "";
		{
			_text = _text + _x;
			[_x] call Ares_fnc_LogMessage;
		} forEach _output;
		missionNamespace setVariable ['Ares_CopyPaste_Dialog_Text', _text];
		_dialog = createDialog "Ares_CopyPaste_Dialog";
		["Generated SQF from mission objects (%1 object, %2 groups, %3 units)", count _emptyObjects, count _groups, _totalUnitsProcessed] call Ares_fnc_ShowZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;