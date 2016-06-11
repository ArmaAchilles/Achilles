#include "\ares_zeusExtensions\Ares\module_header.hpp"
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX 4

disableSerialization;

_spawnPosition = position _logic;

// Get the UI control

_side_names = ["BLUEFOR","OPFOR","INDEPENDENT"];
_sides = [west,east,independent];

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
		[localize "STR_FRACTION", ["placeholder"]],
		[localize "STR_VEHICLE_CATEGORY", ["placeholder"]],
		[localize "STR_VEHICLE",["placeholder"]],
		[localize "STR_VEHICLE_BEHAVIOUR", [localize "STR_RTB_DESPAWN", localize "STR_STAY_AT_LZ"]],
		[localize "STR_LZ_DZ", _lzOptions],
		[localize "STR_NUMBER_OF_TEAMS", "",2],
		[localize "STR_UNIT_RP", _rpOptions],
		[localize "STR_UNIT_BEHAVIOUR", [localize "STR_DEFAULT", localize "STR_RELAXED", localize "STR_CAUTIOUS", localize "STR_COMBAT"]]
	], 
	true
] call Ares_fnc_ShowChooseDialog;

//Get dialog results
_side = _sides select (_dialogResult select 0);
_faction = Ares_var_reinforcement_faction;
_vehicleType = Ares_var_reinforcement_vehicle_class;
_dialogVehicleBehaviour = _dialogResult select 4;
_dialogLzAlgorithm = _dialogResult select 5;
_dialogMaxNumTeams = parseNumber (_dialogResult select 6);
_dialogRpAlgorithm = _dialogResult select 7;
_dialogUnitBehaviour = _dialogResult select 8;

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
_vehicleGroup = ([_spawnPosition, 0, _vehicleType, _side] call BIS_fnc_spawnVehicle) select 2;
_vehicleDummyWp = _vehicleGroup addWaypoint [position _vehicle, 0];
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
if (_dialogVehicleBehaviour == 1) then
{
	// Nothing to do. Vehicle will sit tight.
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"