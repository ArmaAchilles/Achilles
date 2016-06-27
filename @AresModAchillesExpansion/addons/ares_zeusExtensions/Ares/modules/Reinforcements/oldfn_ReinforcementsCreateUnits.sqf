#define DISPLAY_NAME_INDEX 0
#define SIDE_INDEX 1
#define ADDON_CLASS_INDEX 2
#define VEHICLE_POOL_START_INDEX 3
#define SCOUT_UNIT_POOL_INDEX 3
#define UNARMED_HELO_UNIT_POOL_INDEX 7
#define ARMED_HELO_UNIT_POOL_INDEX 8
#define UNARMED_BOAT_UNIT_POOL_INDEX 9
#define ARMED_BOAT_UNIT_POOL_INDEX 10
#define INFANTRY_UNIT_POOL_INDEX 11

#define FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX 4

#include "\ares_zeusExtensions\Ares\module_header.hpp"

if (isNil "Ares_Reinforcement_Unit_Pools"
	|| typeName Ares_Reinforcement_Unit_Pools != typeName []
	|| count Ares_Reinforcement_Unit_Pools == 0) then
{
	[objNull, "Unable to load unit pools. Is your 'Ares_Reinforcement_Unit_Pools.sqf' file corrupt?"] call bis_fnc_showCuratorFeedbackMessage;
	breakTo MAIN_SCOPE_NAME;
};


private ["_allUnitPools"];
if (isNil "Ares_Reinforcement_Mission_Unit_Pools") then
{
	_allUnitPools = Ares_Reinforcement_Unit_Pools;
}
else
{
	_allUnitPools = Ares_Reinforcement_Unit_Pools + Ares_Reinforcement_Mission_Unit_Pools;
};

_allLzsUnsorted = allMissionObjects "Ares_Module_Reinforcements_Create_Lz";
if (count _allLzsUnsorted == 0) then
{
	[objNull, "You must have at least one LZ for the transport to head to."] call bis_fnc_showCuratorFeedbackMessage;
	breakTo MAIN_SCOPE_NAME;
};
_allLzs = [_allLzsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;

_allRpsUnsorted = allMissionObjects "Ares_Module_Reinforcements_Create_Rp";
_allRps = [_allRpsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;

// Generate list of pool names to let user choose from
_poolNames = [];
_validPools = [];
{
	if ((_x select ADDON_CLASS_INDEX) == "" || isClass(configFile >> "CfgPatches" >> (_x select ADDON_CLASS_INDEX))) then
	{
		_poolNames pushBack (_x select DISPLAY_NAME_INDEX);
		_validPools pushBack _x;
	};
} forEach _allUnitPools;

_lzOptions = ["Random", "Nearest", "Farthest", "Least Used"];
{
	_lzOptions pushBack (name _x);
} forEach _allLzs;
_rpOptions = ["Random", "Nearest", "Farthest", "Least Used"];
{
	_rpOptions pushBack (name _x);
} forEach _allRps;

// Show the user the dialog
_dialogResult = ["Create Reinforcements",
	[
		["Side", _poolNames, 0],
		["Vehicle Type", ["Unarmed Light Vehicles + Scouts", "Armed Light Vehicles", "Dedicated Troop Trucks", "APC's & Heavy Troop Transports", "Unarmed Aircraft", "Light Armed Aircraft", "Unarmed Boats", "Armed Boats"]],
		["Vehicle Behaviour After Dropoff", ["RTB and Despawn", "Stay at LZ"]],
		["Vehicle Landing Zone", _lzOptions],
		["Unit Rally Point", _rpOptions],
		["Unit Behaviour", ["Default", "Relaxed", "Cautious", "Combat"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) then
{
	// The user chose 'Cancel'. We should abort.
	breakTo MAIN_SCOPE_NAME;
};

// Get the data from the dialog to use when choosing what units to spawn
_dialogPool =             _dialogResult select 0;
_dialogVehicleClass =     _dialogResult select 1;
_dialogVehicleBehaviour = _dialogResult select 2;
_dialogLzAlgorithm =      _dialogResult select 3;
_dialogRpAlgorithm =      _dialogResult select 4;
_dialogUnitBehaviour =    _dialogResult select 5;
_lzSize = 20;	// TODO make this a dialog parameter?
_rpSize = 20;	// TODO make this a dialog parameters?
_spawnPosition = position _logic;
if (not isNil "Ares_CuratorObjectPlaces_LastPlacedObjectPosition") then
{
	_spawnPosition = Ares_CuratorObjectPlaces_LastPlacedObjectPosition;
};

// Lz's for helicopters get more randomness because they tend to crash into eachother.
if (_dialogVehicleClass == UNARMED_HELO_UNIT_POOL_INDEX || _dialogVehicleClass == ARMED_HELO_UNIT_POOL_INDEX) then
{
	_lzSize = 150;
};

[format ["Dialog results: Pool=%1, VehicleType=%2, Behaviour=%3, LzAlgorithm=%4, RpAlgorithm=%5", _dialogPool, _dialogVehicleClass, _dialogVehicleBehaviour, _dialogLzAlgorithm, _dialogRpAlgorithm]] call Ares_fnc_LogMessage;

// Choose the LZ based on what the user indicated
_lz = objNull;
switch (_dialogLzAlgorithm) do
{
	case 0: // Random
	{
		_lz = _allLzs call BIS_fnc_selectRandom;
	};
	case 1: // Nearest
	{
		_lz = [_spawnPosition, _allLzs] call Ares_fnc_GetNearest;
	};
	case 2: // Furthest
	{
		_lz = [_spawnPosition, _allLzs] call Ares_fnc_GetFarthest;
	};
	case 3: // Least used
	{
		_lz = _allLzs call BIS_fnc_selectRandom; // Choose randomly to start.
		{
			if (_x getVariable ["Ares_Lz_Count", 0] < _lz getVariable ["Ares_Lz_Count", 0]) then
			{
				_lz = _x;
			};
		} forEach _allLzs;
	};
	default // Specific LZ.
	{
		_lz = _allLzs select (_dialogLzAlgorithm - FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX);
	};
};

// Now that we've chosen an LZ, increment the count for it.
_lz setVariable ["Ares_Lz_Count", (_lz getVariable ["Ares_Lz_Count", 0]) + 1];

// Get the unit pool and the side it's associated with
_pool = _validPools select _dialogPool;
_side = _pool select SIDE_INDEX;

if (count (_pool select INFANTRY_UNIT_POOL_INDEX) == 0) then
{
	[objNull, "No infantry squads defined for side."] call bis_fnc_showCuratorFeedbackMessage;
	breakTo MAIN_SCOPE_NAME;
};

// Spawn a vehicle, send it to the LZ and have it unload the troops before returning home and
// deleting itself.
_vehiclePoolIndex = (_dialogVehicleClass + VEHICLE_POOL_START_INDEX);

if (count (_pool select _vehiclePoolIndex) == 0) then
{
	[objNull, "Vehicle pool had no vehicles defined for this faction."] call bis_fnc_showCuratorFeedbackMessage;
	breakTo MAIN_SCOPE_NAME;
};

_vehicleType = (_pool select _vehiclePoolIndex) call BIS_fnc_selectRandom;
_vehicleGroup = ([_spawnPosition, 0, _vehicleType, _side] call BIS_fnc_spawnVehicle) select 2;

_vehicleDummyWp = _vehicleGroup addWaypoint [position _vehicle, 0];
_vehicleUnloadWp = _vehicleGroup addWaypoint [position _lz, _lzSize];
_vehicleUnloadWp setWaypointType "TR UNLOAD";

// Make the driver full skill. This makes him less likely to do dumb things
// when they take contact.
(driver (vehicle (leader _vehicleGroup))) setSkill 1;

if (_vehiclePoolIndex == UNARMED_HELO_UNIT_POOL_INDEX || _vehiclePoolIndex == ARMED_HELO_UNIT_POOL_INDEX) then 
{
	// Special settings for helicopters. Otherwise they tend to run away instead of land
	// if the LZ is hot.
	{
		_x allowFleeing 0; // Especially for helos... They're very cowardly.
	} forEach (crew (vehicle (leader _vehicleGroup)));
	_vehicleUnloadWp setWaypointTimeout [0,0,0];
}
else
{
	_vehicleUnloadWp setWaypointTimeout [5,10,20]; // Give the units some time to get away from truck
};

// Generate the waypoints for after the transport drops off the troops.
if (_dialogVehicleBehaviour == 0) then
{
	// RTB and despawn.
	_vehicleReturnWp = _vehicleGroup addWaypoint [_spawnPosition, 0];
	_vehicleReturnWp setWaypointTimeout [2,2,2]; // Let the unit stop before being despawned.
	_vehicleReturnWp setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];
};
if (_dialogVehicleBehaviour == 1) then
{
	// Nothing to do. Vehicle will sit tight.
};

// Add vehicle to curator
 [(units _vehicleGroup) + [(vehicle (leader _vehicleGroup))]] call Ares_fnc_AddUnitsToCurator;

// Spawn the units and load them into the vehicle
_vehicle = vehicle (leader _vehicleGroup);
_maxCargoSpacesToLeaveEmpty = 3;
if ((_vehicle emptyPositions "Cargo") <= 3) then
{
	// Vehicles with low cargo space shouldn't leave empty seats, otherwise they often won't have any units at all.
	_maxCargoSpacesToLeaveEmpty = 0;
};
while { (_vehicle emptyPositions "Cargo") > _maxCargoSpacesToLeaveEmpty } do
{
	private ["_squadMembers"];
	_squadMembers = (_pool select INFANTRY_UNIT_POOL_INDEX) call BIS_fnc_selectRandom;
	_freeSpace = (vehicle (leader _vehicleGroup)) emptyPositions "Cargo";
	if (_freeSpace < count _squadMembers) then
	{
		// Trim the squad size so they will fit.
		_squadMembers resize _freeSpace;
	};
	
	// Spawn the squad members.
	_infantryGroup = [_spawnPosition, _side, _squadMembers] call BIS_fnc_spawnGroup;
	
	// Set the default behaviour of the squad
	switch (_dialogUnitBehaviour) do
	{
		case 1: // Relaxed
		{
			_infantryGroup setBehaviour "SAFE";
			_infantryGroup setSpeedMode "LIMITED";
		};
		case 2: // Cautious
		{
			_infantryGroup setBehaviour "AWARE";
			_infantryGroup setSpeedMode "LIMITED";
		};
		case 3: // Combat
		{
			_infantryGroup setBehaviour "COMBAT";
			_infantryGroup setSpeedMode "NORMAL";
		};
	};

	// Choose a RP for the squad to head to once unloaded and set their waypoint.
	if (count _allRps > 0) then
	{
		// Choose the RP based on the algorithm the user selected
		_rp = objNull;
		switch (_dialogRpAlgorithm) do
		{
			case 0: // Random
			{
				_rp = _allRps call BIS_fnc_selectRandom;
			};
			case 1: // Nearest
			{
				_rp = [position _lz, _allRps] call Ares_fnc_GetNearest;
			};
			case 2: // Furthest
			{
				_rp = [position _lz, _allRps] call Ares_fnc_GetFarthest;
			};
			case 3: // Least Used
			{
				_rp = _allRps call BIS_fnc_selectRandom; // Choose randomly to begin with.
				{
					if (_x getVariable ["Ares_Rp_Count", 0] < _rp getVariable ["Ares_Rp_Count", 0]) then
					{
						_rp = _x;
					}
				} forEach _allRps;
			};
			default
			{
				_rp = _allRps select (_dialogRpAlgorithm - FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX);
			};
		};

		// Now that we've chosen an RP, increment the count for it.
		_rp setVariable ["Ares_Rp_Count", (_rp getVariable ["Ares_Rp_Count", 0]) + 1];
		
		_infantryRpWp = _infantryGroup addWaypoint [position _rp, _rpSize];
	}
	else
	{
		_infantryMoveOnWp = _infantryGroup addWaypoint [position _lz, _rpSize];
	};
	
	// Load the units into the vehicle.
	{
		_x moveInCargo (vehicle (leader _vehicleGroup));
	} foreach(units _infantryGroup);
	
	// Add infantry to curator
	[(units _infantryGroup)] call Ares_fnc_AddUnitsToCurator;
};

if (count _allRps > 0) then
{
	[objNull, "Transport dispatched to LZ. Squad will head to RP."] call bis_fnc_showCuratorFeedbackMessage;
}
else
{
	[objNull, "Transport dispatched to LZ. Squad will stay at LZ."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
