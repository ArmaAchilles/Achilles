#include "\achilles\modules_f_ares\module_header.hpp"

#define FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX 4

//FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX = 4;
disableSerialization;

_spawnPosition = position _logic;

// Get the UI control

_side_names = ["OPFOR","BLUEFOR","INDEPENDENT"];
_sides = [east,west,independent];

_allLzsUnsorted = allMissionObjects "Ares_Module_Reinforcements_Create_Lz";
if (count _allLzsUnsorted == 0) exitWith {[localize "STR_NO_LZ"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
_allLzs = [_allLzsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
_lzOptions = [localize "STR_RANDOM", localize "STR_NEAREST", localize "STR_FARTHEST", localize "STR_LEAST_USED"];
{
	_lzOptions pushBack (name _x);
} forEach _allLzs;

_allRpsUnsorted = allMissionObjects "Ares_Module_Reinforcements_Create_Rp";
if (count _allRpsUnsorted == 0) exitWith {[localize "STR_NO_RP"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
_allRps = [_allRpsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
_rpOptions = [localize "STR_RANDOM", localize "STR_NEAREST", localize "STR_FARTHEST", localize "STR_LEAST_USED"];
{
	_rpOptions pushBack (name _x);
} forEach _allRps;

// Show the user the dialog
_dialogResult = 
[
	localize "STR_SPAWN_UNITS",
	[
		[localize "STR_SIDE", _side_names,0],
		[localize "STR_FACTION", [localize "STR_LOADING_"]],
		[localize "STR_VEHICLE_CATEGORY", [localize "STR_LOADING_"]],
		[localize "STR_VEHICLE",["loading ..."]],
		[localize "STR_VEHICLE_BEHAVIOUR", [localize "STR_RTB_DESPAWN", localize "STR_STAY_AT_LZ"]],
		[localize "STR_LZ_DZ", _lzOptions],
		[localize "STR_INFANTRY_GROUP", [localize "STR_LOADING_"]],
		[localize "STR_UNIT_RP", _rpOptions],
		[localize "STR_UNIT_BEHAVIOUR", [localize "STR_DEFAULT", localize "STR_RELAXED", localize "STR_CAUTIOUS", localize "STR_COMBAT"]]
	], 
	"Achilles_fnc_RscDisplayAttributes_Create_Reinforcement"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

//Get dialog results
_side = _sides select (_dialogResult select 0);
_infantryGroup = Ares_var_reinforcement_infantry_group;
_vehicleType = Ares_var_reinforcement_vehicle_class;
_dialogVehicleBehaviour = _dialogResult select 4;
_dialogLzAlgorithm = _dialogResult select 5;
_dialogRpAlgorithm = _dialogResult select 7;
_dialogUnitBehaviour = _dialogResult select 8;
_lzSize = 20;	// TODO make this a dialog parameter?
_rpSize = 20;	// TODO make this a dialog parameters?

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


// create the transport vehicle
_vehicleInfo = [_spawnPosition, 0, _vehicleType, _side] call BIS_fnc_spawnVehicle;
_vehicle = _vehicleInfo select 0;
_vehicleGroup = _vehicleInfo select 2;
//_vehicleDummyWp = _vehicleGroup addWaypoint [position _vehicle, 0];
_vehicleUnloadWp = _vehicleGroup addWaypoint [position _lz, _lzSize];
_vehicleUnloadWp setWaypointType "TR UNLOAD";

// Make the driver full skill. This makes him less likely to do dumb things
// when they take contact.
(driver (vehicle (leader _vehicleGroup))) setSkill 1;

if (_vehicleType isKindOf "Air") then 
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

_CrewTara = [_vehicleType,false] call BIS_fnc_crewCount;
_CrewBrutto =  [_vehicleType,true] call BIS_fnc_crewCount;
_CrewNetto = _CrewBrutto - _CrewTara;

// create infantry group and resize it to the given cargo space if needed
_infantryGroup = [_spawnPosition, _side, _infantryGroup] call BIS_fnc_spawnGroup;
// delete remaining units if vehicle is overcrouded
_infantry_list = units _infantryGroup;
if (count _infantry_list > _CrewNetto) then
{
	_infantry_list resize _CrewNetto;
	_infantry_to_delete = (units _infantryGroup) - _infantry_list;
	{deleteVehicle _x} forEach _infantry_to_delete;
};

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
} foreach _infantry_list;

// Add infantry to curator
[(units _infantryGroup)] call Ares_fnc_AddUnitsToCurator;

if (count _allRps > 0) then
{
	[objNull, "Transport dispatched to LZ. Squad will head to RP."] call bis_fnc_showCuratorFeedbackMessage;
}
else
{
	[objNull, "Transport dispatched to LZ. Squad will stay at LZ."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"