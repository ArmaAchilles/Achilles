
if (isNil "Achilles_var_MarkerCounter") then
{
	Achilles_var_MarkerCounter = 0;
};

private ["_object","_vehicle"];

_center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
} else
{
	screenToWorld getMousePosition;
};

_object_info_list = Achilles_var_ObjectClipboard;

_createdGroups = [];
_createdGroupsId = [];
_object_list = [];

{
	_type = _x select 0;
	_side = _x select 2;
	_pos = (_x select 4) vectorAdd _center_pos;
	_dir = _x select 5;
	
	switch (true) do
	{
		case (_type isKindOf "Man"):
		{
			_groupID = _x select 1;
			_loadout = _x select 3 select 0;
			_goggles = _x select 3 select 1;
			_groupIndex = _createdGroupsId find _groupID;
			_group = if (_groupIndex == -1) then 
			{
				_newGroup = createGroup _side;
				_createdGroups pushBack _newGroup;
				_createdGroupsId pushBack _groupID;
				_newGroup;
			} else
			{
				_createdGroups select _groupIndex;
			};
			_unit = _group createUnit [_type, _pos, [], 0, "FORM"];
			_unit setDir _dir;
			_unit setUnitLoadout _loadout;
			// delay is needed, since built-in randomization of face and goggles is also delayed
			[_unit,_goggles] spawn {sleep 1; (_this select 0) addGoggles (_this select 1)};
			if (_pos select 2 > 10) then
			{
				_chute = "Steerable_Parachute_F" createVehicle [0,0,0];
				_unit moveInDriver _chute;
			};
			_object_list pushBack _unit;
		};
		case (_type isKindOf "LandVehicle" or (_type isKindOf "Air") or (_type isKindOf "Ship")):
		{
			_groupID = _x select 1;
			_loadout = _x select 3;
			_crew_info_list =  _x select 6;
			_special = if (_pos select 2 > 10) then {"FLY"} else {"FORM"};
			_vehicle = createVehicle [_type, _pos, [], 0, _special];
			if (_pos select 2 > 10 and not (_type isKindOf "Air")) then
			{
				_chute = "B_Parachute_02_F" createVehicle _pos;
				_chute setPos _pos;
				_vehicle attachTo [_chute];
			};
			_object_list pushBack _vehicle;
			if (_vehicle in allUnitsUAV) then
			{
				createVehicleCrew _vehicle;
				_groupIndex = _createdGroupsId find _groupID;
				if (_groupIndex != -1) then
				{
					(crew _vehicle) join (_createdGroups select _groupIndex);
				};
			} else
			{
				{
					_type = _x select 0;
					_groupID = _x select 1;
					_side = _x select 2;
					_loadout = _x select 3 select 0;
					_goggles = _x select 3 select 1;
					_role = _x select 4;
					_groupIndex = _createdGroupsId find _groupID;
					_group = if (_groupIndex == -1) then 
					{
						_newGroup = createGroup _side;
						_createdGroups pushBack _newGroup;
						_createdGroupsId pushBack _groupID;
						_newGroup;
					} else
					{
						_createdGroups select _groupIndex;
					};
					_unit = _group createUnit [_type, [0,0,0], [], 0, "FORM"];
					_unit setUnitLoadout _loadout;
					[_unit,_goggles] spawn {sleep 1; (_this select 0) addGoggles (_this select 1)};
					switch (count _role) do
					{
						case 0: {};
						case 1: {call compile format ["_unit moveIn%1 _vehicle;",_role select 0];};
						case 2: 
						{
							if (_role select 0 == "Cargo") then
							{
								_unit moveInCargo _vehicle;
							} else 
							{
								call compile format ["_unit moveIn%1 [_vehicle,%2];",_role select 0,_role select 1];
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
