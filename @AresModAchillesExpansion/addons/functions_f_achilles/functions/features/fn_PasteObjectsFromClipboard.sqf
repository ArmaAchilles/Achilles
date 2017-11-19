if (isNil "Achilles_var_MarkerCounter") then
{
	Achilles_var_MarkerCounter = 0;
};

private _center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
}
else
{
	screenToWorld getMousePosition;
};

private _object_info_list = Achilles_var_ObjectClipboard;

private _createdGroups = [];
private _createdGroupsId = [];
private _object_list = [];

{
	_x params ["_type"];
	
	switch (true) do
	{
		case (_type isKindOf "Man"):
		{
			_x params ["_", "_groupID", "_side", "_fullLoadout", "_pos", "_dir", "_face", "_speaker", "_pitch", "_name", "_nameSound", "_rank", "_skill"];
			_fullLoadout params ["_loadout", "_goggles"];
			_pos = _pos vectorAdd _center_pos;

			private _groupIndex = _createdGroupsId find _groupID;
			private _group = if (_groupIndex == -1) then
			{
				private _newGroup = createGroup _side;
				_createdGroups pushBack _newGroup;
				_createdGroupsId pushBack _groupID;
				_newGroup;
			}
			else
			{
				_createdGroups select _groupIndex;
			};
			private _unit = _group createUnit [_type, _pos, [], 0, "FORM"];
			_unit setDir _dir;
			_unit setUnitLoadout _loadout;

			// delay is needed, since built-in randomization of face and goggles is also delayed
			[_unit,_goggles, _face, _speaker, _pitch, _name, _nameSound, _rank, _skill] spawn 
			{
				params ["_unit", "_goggles", "_face", "_speaker", "_pitch", "_name", "_nameSound", "_rank", "_skill"];
				sleep 1;

				removeGoggles _unit;
				_unit addGoggles _goggles;
				_unit setUnitRank _rank;
				[_unit, _face] remoteExecCall ["setFace", 0, _unit];
				[_unit, _speaker] remoteExecCall ["setSpeaker", 0, _unit];
				[_unit, _pitch] remoteExecCall ["setPitch", 0, _unit];
				[_unit, _name] remoteExecCall ["setName", 0, _unit];
				[_unit, _nameSound] remoteExecCall ["setNameSound", 0, _unit];
				[_unit, _skill] remoteExecCall ["setSkill", 0, _unit];
			};

			if (_pos select 2 > 10) then
			{
				private _chute = "Steerable_Parachute_F" createVehicle [0,0,0];
				_unit moveInDriver _chute;
			};
			_object_list pushBack _unit;
		};
		case (_type isKindOf "LandVehicle" or (_type isKindOf "Air") or (_type isKindOf "Ship")):
		{
			_x params ["_", "_groupID", "_side", "_pylonMagazines", "_pos", "_dir", "_crew_info_list", "_fuel"];

			_pos = _pos vectorAdd _center_pos;

			private _special = ["FORM", "FLY"] select ((_pos select 2) > 2);
			private _vehicle = createVehicle [_type, _pos, [], 0, _special];
			if (_pos select 2 > 10 && !(_type isKindOf "Air")) then
			{
				private _chute = "B_Parachute_02_F" createVehicle _pos;
				_chute setPos _pos;
				_vehicle attachTo [_chute];
			};

			_vehicle setFuel _fuel;

			// Add the weapons to the gunner if possible
			if (isClass (configFile >> "cfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent")) then 
			{
				private _addWeaponsTo = [[], [0]] select (count fullCrew [_vehicle, "gunner", true] == 1);
				{_vehicle setPylonLoadOut [_forEachIndex + 1, _x, false, _addWeaponsTo]} forEach _pylonMagazines;
			};

			_object_list pushBack _vehicle;
			
			if (_vehicle in allUnitsUAV) then
			{
				createVehicleCrew _vehicle;
				private _groupIndex = _createdGroupsId find _groupID;
				if (_groupIndex != -1) then
				{
					(crew _vehicle) join (_createdGroups select _groupIndex);
				};
			}
			else
			{
				{
					_x params ["_type", "_groupID", "_side", "_fullLoadout", "_role", "_face", "_speaker", "_pitch", "_name", "_nameSound", "_rank", "_skill"];
					_fullLoadout params ["_loadout", "_goggles"];

					private _groupIndex = _createdGroupsId find _groupID;
					private _group = if (_groupIndex == -1) then
					{
						private _newGroup = createGroup _side;
						_createdGroups pushBack _newGroup;
						_createdGroupsId pushBack _groupID;
						_newGroup;
					}
					else
					{
						_createdGroups select _groupIndex;
					};

					private _unit = _group createUnit [_type, [0,0,0], [], 0, "FORM"];
					_unit setUnitLoadout _loadout;

					// delay is needed, since built-in randomization of face and goggles is also delayed
					[_unit,_goggles, _face, _speaker, _pitch, _name, _nameSound, _rank, _skill] spawn 
					{
						params ["_unit", "_goggles", "_face", "_speaker", "_pitch", "_name", "_nameSound", "_rank", "_skill"];

						sleep 1;
						removeGoggles _unit;
						_unit addGoggles _goggles;
						_unit setUnitRank _rank;
						[_unit, _face] remoteExecCall ["setFace", 0, _unit];
						[_unit, _speaker] remoteExecCall ["setSpeaker", 0, _unit];
						[_unit, _pitch] remoteExecCall ["setPitch", 0, _unit];
						[_unit, _name] remoteExecCall ["setName", 0, _unit];
						[_unit, _nameSound] remoteExecCall ["setNameSound", 0, _unit];
						[_unit, _skill] remoteExecCall ["setSkill", 0, _unit];
					};

					switch (count _role) do
					{
						case 0: {};
						case 1: {call compile format ["_unit moveIn%1 _vehicle",_role select 0]};
						case 2: 
						{
							if (_role select 0 == "Cargo") then
							{
								_unit moveInCargo _vehicle;
							}
							else 
							{
								call compile format ["_unit moveIn%1 [_vehicle,%2]",_role select 0,_role select 1];
							};
						};
					};
				} forEach _crew_info_list;
			};
		};
	};
} forEach _object_info_list;

[_object_list, true] call Ares_fnc_AddUnitsToCurator;
[format [localize "STR_COPIED_UNITS", count _object_list]] call Ares_fnc_ShowZeusMessage;