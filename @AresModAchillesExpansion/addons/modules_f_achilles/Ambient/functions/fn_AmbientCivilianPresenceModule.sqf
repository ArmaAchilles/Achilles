// #include "defines.inc"
/*--------------------------------------------------------------------------------------------------

	Example:
	["getObjects",[_module,"ModuleCivilianPresenceSafeSpot_F"]] call bis_fnc_moduleCivilianPresence;

--------------------------------------------------------------------------------------------------*/
//["[ ] %1",_this] call bis_fnc_logFormat;

if (!isServer) exitWith {};

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];
private _module = _input param [0,objNull,[objNull]];

switch _mode do
{
	// Default object init
	case "init":
	{
		if (is3DEN) exitWith {};

		//get unit and safespot modules in area
		private _modulesUnit = ["getObjects",[_module,"ModuleCivilianPresenceUnit_F"]] call bis_fnc_moduleCivilianPresence;
		private _modulesSafeSpots = ["getObjects",[_module,"ModuleCivilianPresenceSafeSpot_F"]] call bis_fnc_moduleCivilianPresence;

		//check setup validity
		if (count _modulesUnit == 0 || count _modulesSafeSpots == 0) exitWith
		{
			["[x] Civilian Presence %1 terminated. There neeeds to be at least 1 spawnpoint and 1 position module.",_module] call bis_fnc_error;
		};

		private _activated = _input param [1,true,[true]];

		//["[x] Activated: %1",_activated] call bis_fnc_logFormat;

		//flag module activity
		_module setVariable ["#active",_activated];

		//check if continuous spawning thread is running and start it, if not
		private _unitHandlingRunning = _module getVariable ["#unitHandlingRunning",false];
		if (_activated && !_unitHandlingRunning) then
		{
			_module setVariable ["#unitHandlingRunning",true];

			["handleUnits",[_module]] spawn bis_fnc_moduleCivilianPresence;
		};

		//block sub-sequent executions
		if (_module getVariable ["#initialized",false]) exitWith {};
		_module setVariable ["#initialized",true];

		//register module specific functions
		_path = "\A3\Modules_F_Tacops\Ambient\CivilianPresence\Functions\";
		[
			_path,
			"bis_fnc_cp_",
			[
				"debug",
				"getQueueDelay",
				"main",
				"addThreat",
				"getSafespot"
			]
		]
		call bis_fnc_loadFunctions;

		_module setVariable ["#modulesUnit",_modulesUnit];
		_module setVariable ["#modulesSafeSpots",_modulesSafeSpots];

		{
			private _safespot = _x;
			private _safespotPos = getPos _safespot; _safespotPos set [2,0];

			if (_safespot getVariable ["#useBuilding",false]) then
			{
				_building = nearestBuilding _safespotPos;

				if (_building distance2D _safespotPos > 50) then {_building = objNull};

				if (!isNull _building && {count (_building buildingPos -1) > 0}) then
				{
					_safespot setVariable ["#positions",(_building buildingPos -1) call BIS_fnc_arrayShuffle];
				}
				else
				{
					_safespot setVariable ["#positions",[_safespotPos]];
				};
			}
			else
			{
				_safespot setVariable ["#positions",[_safespotPos]];
			};
		}
		forEach _modulesSafeSpots;

		//prepare unit types
		private _worldName = worldName;
		if !(_worldName in ["Stratis","Altis","Malden","Tanoa"]) then {_worldName = "Other"};
		private _unitTypes = getArray (configfile >> "CfgVehicles" >> "ModuleCivilianPresence_F" >> "UnitTypes" >> _worldName);
		_module setVariable ["#unitTypes",_unitTypes];

		private _units = [];
		{
			private _unit = ["createUnit",[_module,getPos _x]] call bis_fnc_moduleCivilianPresence;

			if (!isNull _unit) then {_units pushBack _unit};
		}
		forEach _modulesUnit;
		_module setVariable ["#units",_units];

		//debugs
		if (_module getVariable ["#debug",false]) then
		{
			private _paramsDraw3D = missionNamespace getVariable ["bis_fnc_moduleCivilianPresence_paramsDraw3D",[]];
			private _handle = addMissionEventHandler ["Draw3D",{["debug"] call bis_fnc_cp_debug;}];
			_paramsDraw3D set [_handle,_module];
			bis_fnc_moduleCivilianPresence_paramsDraw3D = _paramsDraw3D;
		};
	};

	case "handleUnits":
	{
		//monitor number of agents and spawn / delete some as needed
		_module spawn
		{
			private _module = _this;

			//make sure initialization is finished
			waitUntil
			{
				!isNil{_module getVariable "#units"}
			};

			private _units = _module getVariable ["#units",[]];
			private _maxUnits = _module getVariable ["#unitCount",0];
			private _active = false;

			while
			{
				_active = _module getVariable ["#active",false];
				_units = _units select {!isNull _x && {alive _x}};

				(_active && _maxUnits > 0) || (!_active && count _units > 0)
			}
			do
			{
				if (_active) then
				{
					if (count _units < _maxUnits) then
					{
						private _unit = ["createUnit",[_module]] call bis_fnc_moduleCivilianPresence;
						if (!isNull _unit) then {_units pushBack _unit};
					};
				}
				else
				{
					private _unit = selectRandom _units;
					private _deleted = ["deleteUnit",[_module,_unit]] call bis_fnc_moduleCivilianPresence;

					if (_deleted) then
					{
						_units = _units - [_unit];
					};
				};

				//compact & store units array
				_units = _units select {!isNull _x && {alive _x}};
				_module setVariable ["#units",_units];

				sleep 10;
			};

			//mark the unit handling as terminated
			_module setVariable ["#unitHandlingRunning",false];
		};
	};

	case "deleteUnit":
	{
		private _unit = _input param [1,objNull,[objNull]]; if (isNull _unit) exitWith {false};
		private _seenBy = allPlayers select {_x distance _unit < 50 || {(_x distance _unit < 150 && {([_x,"VIEW",_unit] checkVisibility [eyePos _x, eyePos _unit]) > 0.5})}};

		//["[ ] Trying to delete unit %1 that is seen by %2",_unit,_seenBy] call bis_fnc_logFormat;

		private _canDelete = count _seenBy == 0;

		if (_canDelete) then
		{
			_unit call (_module getVariable ["#onDeleted",{}]);
			deleteVehicle _unit;
		};

		_canDelete
	};

	case "createUnit":
	{
		private _pos = _input param [1,[],[[]]];

		//randomize position
		if (count _pos == 0) then
		{
			_pos = getPos selectRandom (_module getVariable ["#modulesUnit",[]]);
		};

		private _posASL = (AGLToASL _pos) vectorAdd [0,0,1.5];


		//check if any player can see the point of creation
		private _seenBy = allPlayers select {_x distance _pos < 50 || {(_x distance _pos < 150 && {([_x,"VIEW"] checkVisibility [eyePos _x, _posASL]) > 0.5})}};

		//["[ ] Trying to create unit on position %1 that is seen by %2",_pos,_seenBy] call bis_fnc_logFormat;

		//terminate if any player can see the position
		if (count _seenBy > 0) exitWith {objNull};

		private _class = format["CivilianPresence_%1",selectRandom (_module getVariable ["#unitTypes",[]])];

		private _unit = if (_module getVariable ["#useAgents",true]) then
		{
			createAgent [_class, _pos, [], 0, "NONE"];
		}
		else
		{
			(createGroup civilian) createUnit [_class, _pos, [], 0, "NONE"];
		};

		//make backlink to the core module
		_unit setVariable ["#core",_module];

		_unit setBehaviour "CARELESS";
		_unit spawn (_module getVariable ["#onCreated",{}]);
		_unit execFSM "A3\Modules_F_Tacops\Ambient\CivilianPresence\FSM\behavior.fsm";

		_unit
	};

	case "getObjects":
	{
		private _objectType = _input param [1,"",[""]];	if (_objectType == "") exitWith {[]};

		private _objects = _module getVariable _objectType;

		if (isNil{_objects}) then
		{
			private _area = _module getVariable ["#area",[]];

			if (count _area == 0) then
			{
				_area = [getPos _module];
				_area append (_module getVariable ["objectarea",[]]);

				_module setVariable ["#area",_area];
			};

			_objects = (entities [[_objectType], []]) inAreaArray _area;
		};

		_module setVariable [_objectType,_objects];

		_objects
	};
};
