
if (isNil "Achilles_var_MarkerCounter") then
{
	Achilles_var_MarkerCounter = 0;
};

private _center_pos = if (visibleMap) then
{
	(((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition) + [0];
} else
{
	screenToWorld getMousePosition;
};

private _object_info_list = Achilles_var_ObjectClipboard;

private _createdGroups = [];
private _createdGroupsId = [];
private _object_list = [];

{
	_x params 
	[
		["_type", objNull, [objNull]],
		["_groupID", "", [""]],
		["_side", blufor, [blufor]],
		["_loadout", [], [[]]],
		["_pos", [0,0,0], [[]]],
		["_dir", 0, [0]],
		["_crew_info_list", [], [[]]]
	];
	_pos = _pos vectorAdd _center_pos;
	
	switch (true) do
	{
		case (_type isKindOf "Man"):
		{
			private _loadout = _loadout select 0;
			private _goggles = _loadout select 1;
			private _groupIndex = _createdGroupsId find _groupID;
			private _group = if (_groupIndex == -1) then
			{
				private _newGroup = createGroup _side;
				_createdGroups pushBack _newGroup;
				_createdGroupsId pushBack _groupID;
				_newGroup;
			} else
			{
				_createdGroups select _groupIndex;
			};
			private _unit = _group createUnit [_type, _pos, [], 0, "FORM"];
			_unit setDir _dir;
			_unit setUnitLoadout _loadout;
			// delay is needed, since built-in randomization of face and goggles is also delayed
			[_unit,_goggles] spawn {sleep 1; (_this select 0) addGoggles (_this select 1)};
			if (_pos select 2 > 10) then
			{
				private _chute = "Steerable_Parachute_F" createVehicle [0,0,0];
				_unit moveInDriver _chute;
			};
			_object_list pushBack _unit;
		};
		case (_type isKindOf "LandVehicle" or (_type isKindOf "Air") or (_type isKindOf "Ship")):
		{
			private _special = if (_pos select 2 > 10) then {"FLY"} else {"FORM"};
			private _vehicle = createVehicle [_type, _pos, [], 0, _special];
			if (_pos select 2 > 10 && !(_type isKindOf "Air")) then
			{
				private _chute = "B_Parachute_02_F" createVehicle _pos;
				_chute setPos _pos;
				_vehicle attachTo [_chute];
			};
			{_vehicle setPylonLoadout [_forEachIndex + 1,_x]} forEach _loadout;
			_object_list pushBack _vehicle;
			if (_vehicle in allUnitsUAV) then
			{
				createVehicleCrew _vehicle;
				private _groupIndex = _createdGroupsId find _groupID;
				if (_groupIndex != -1) then
				{
					(crew _vehicle) join (_createdGroups select _groupIndex);
				};
			} else
			{
				{
					params["_type", "_groupID", "_side", "_loadout", "_role"];
					private _loadout = _loadout select 0;
					private _goggles = _loadout select 1;
					private _groupIndex = _createdGroupsId find _groupID;
					private _group = if (_groupIndex == -1) then
					{
						private _newGroup = createGroup _side;
						_createdGroups pushBack _newGroup;
						_createdGroupsId pushBack _groupID;
						_newGroup;
					} else
					{
						_createdGroups select _groupIndex;
					};
					private _unit = _group createUnit [_type, [0,0,0], [], 0, "FORM"];
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
