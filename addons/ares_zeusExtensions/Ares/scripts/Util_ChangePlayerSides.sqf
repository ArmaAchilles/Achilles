[
	"Util",
	"Change Player Sides",
	{
		_unitUnderCursor = _this select 1;
		
		_units = [];
		_side = east;
		if (isNull _unitUnderCursor) then
		{
			_dialogResult = [
				"Choose side For all players",
				[
					["Side", ["East (Opfor)", "West (Blufor)", "Independent (Greenfor)", "Civilian"]]
				]
			] call Ares_fnc_ShowChooseDialog;
			
			if (count _dialogResult > 0) then
			{
				switch (_dialogResult select 0) do
				{
					case 1: { _side = west; };
					case 2: { _side = independent; };
					case 3: { _side = civilian; };
				};
				
				{
					if (isPlayer _x) then
					{
						_units pushBack _x;
					};
				} forEach allUnits;
			};
		}
		else
		{
			_dialogResult = [
				"Choose Side",
				[
					["Side", ["East (Opfor)", "West (Blufor)", "Independent (Greenfor)", "Civilian"]],
					["Change side for", ["Entire group", "Selected player only"]]
				]
			] call Ares_fnc_ShowChooseDialog;
			
			if (count _dialogResult > 0) then
			{
				switch (_dialogResult select 0) do
				{
					case 1: { _side = west; };
					case 2: { _side = independent; };
					case 3: { _side = civilian; };
				};
				
				switch (_dialogResult select 1) do
				{
					case 0:
					{
						_units = units (group _unitUnderCursor);
					};
					case 1:
					{
						_units pushBack _unitUnderCursor;
					};
				};
			};
		};
		
		if (count _units > 0) then
		{
			// Save the names of each group that the original units belonged to.
			_groupNames = []; // List of the groups that must be created on the new side
			_unitGroupIndexes = []; // Index in _groupNames for the group each _units entry should go to
			{
				_currentUnitGroupName = groupId (group _x);
				if (_currentUnitGroupName in _groupNames) then
				{
					_indexOfGroupName = 0;
					{
						if (_x == _currentUnitGroupName) exitWith { _unitGroupIndexes pushBack _forEachIndex; };
					} forEach _groupNames;
				}
				else
				{
					_unitGroupIndexes pushBack (count _groupNames);
					_groupNames pushBack _currentUnitGroupName;
				};
			} forEach _units;
			
			// Create the new set of groups on the new side with matching names
			_newGroups = [];
			{
				_newGroup = createGroup _side;
				_newGroup setGroupId [(_groupNames select _forEachIndex)];
				_newGroups pushBack _newGroup;
			} forEach _groupNames;

			// Assign each unit into their original group
			{
				_newGroupIndex = (_unitGroupIndexes select _forEachIndex);
				_newGroup = _newGroups select _newGroupIndex;
				[_x] join _newGroup;
			} forEach _units;
			["Changed side for %1 players.", count _units] call Ares_fnc_ShowZeusMessage;
		};
	}
] call Ares_fnc_RegisterCustomModule;
