#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#define CURATOR_UNITS_IDCs 						[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]
#define CURATOR_GROUPS_IDCs 					[IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER]

#define SIDES 									[east, west, independent]
#define SIDE_NAMES								[localize "STR_AMAE_OPFOR", localize "STR_AMAE_BLUFOR", localize "STR_AMAE_INDEPENDENT"]

#include "\achilles\modules_f_ares\module_header.hpp"

disableSerialization;

private _spawn_position = position _logic;

// options for selecting positions
private _extraOptions = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];

// get LZs
private _allLzsData = ["Ares_Module_Reinforcements_Create_Lz"] call Achilles_fnc_getLogics;
_allLzsData params ["_allLzNames","_allLzLogics"];
if (_allLzNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_LZ"] call Achilles_fnc_ShowZeusErrorMessage};
private _lzOptions = _extraOptions + _allLzNames;

// get RPs
private _allRpsData = ["Ares_Module_Reinforcements_Create_Rp"] call Achilles_fnc_getLogics;
_allRpsData params ["_allRpNames","_allRpLogics"];
if (_allRpNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_RP"] call Achilles_fnc_ShowZeusErrorMessage};
private _rpOptions = _extraOptions + _allRpNames;

// cache: find all possible vehicles and groups for reinforcements 
if (uiNamespace getVariable ["Achilles_var_nestedList_vehicleFactions", []] isEqualTo []) then
{
	private _curator_interface = findDisplay IDD_RSCDISPLAYCURATOR;
	
	private _vehicle_factions = [];
	private _group_factions = [];
	private _vehicle_categories = [];
	private _vehicles = [];
	private _groups = [];

	for "_side_id" from 0 to (count SIDES - 1) do
	{
		// find vehicles
		private _tree_ctrl = _curator_interface displayCtrl (CURATOR_UNITS_IDCs select _side_id);
		_vehicle_factions pushBack [];
		_vehicle_categories pushBack [];
		_vehicles pushBack [];
		private _faction_id = -1;
		for "_faction_tvid" from 0 to ((_tree_ctrl tvCount []) - 1) do
		{
			private _faction_included = false;
			private _faction = _tree_ctrl tvText [_faction_tvid];
			private _category_id = -1;
			for "_category_tvid" from 0 to ((_tree_ctrl tvCount [_faction_tvid]) - 1) do
			{
				private _category_included = false;
				private _category = _tree_ctrl tvText [_faction_tvid,_category_tvid];
				private _first = true;
				for "_vehicle_tvid" from 0 to ((_tree_ctrl tvCount [_faction_tvid,_category_tvid]) - 1) do
				{
					private _vehicle = _tree_ctrl tvData [_faction_tvid,_category_tvid,_vehicle_tvid];
					if (_first and not (_vehicle isKindOf "Tank" or _vehicle isKindOf "Car" or _vehicle isKindOf "Helicopter" or _vehicle isKindOf "Plane"or _vehicle isKindOf "Ship")) exitWith {};
					if (([_vehicle, true] call BIS_fnc_crewCount) - ([_vehicle, false] call BIS_fnc_crewCount) > 0) then
					{
						if (not _faction_included) then
						{
							_faction_included = true;
							(_vehicle_factions select _side_id) pushBack _faction;
							_faction_id = _faction_id + 1;
							(_vehicle_categories select _side_id) pushBack [];
							(_vehicles select _side_id) pushBack [];
						};
						if (not _category_included) then
						{
							_category_included = true;
							(_vehicle_categories select _side_id select _faction_id) pushBack _category;
							_category_id = _category_id + 1;
							(_vehicles select _side_id select _faction_id) pushBack [];
						};
						(_vehicles select _side_id select _faction_id select _category_id) pushBack _vehicle;
					};
					_first = false;
				};
			};
		};
		
		// find groups
		private _tree_ctrl = _curator_interface displayCtrl (CURATOR_GROUPS_IDCs select _side_id);
		_group_factions pushBack [];
		_groups pushBack [];
		private _side_class = _tree_ctrl tvData [0];
		for "_faction_tvid" from 0 to ((_tree_ctrl tvCount [0]) - 1) do
		{
			private _faction_included = false;
			private _faction_name = _tree_ctrl tvText [0,_faction_tvid];
			private _faction_class = _tree_ctrl tvData [0,_faction_tvid];
			private _groups_in_faction = [];
			for "_category_tvid" from 0 to ((_tree_ctrl tvCount [0,_faction_tvid]) - 1) do
			{
				private _category_class = _tree_ctrl tvData [0,_faction_tvid,_category_tvid];
				private _first = true;
				for "_group_tvid" from 0 to ((_tree_ctrl tvCount [0,_faction_tvid,_category_tvid]) - 1) do
				{
					private _group_name = _tree_ctrl tvText [0,_faction_tvid,_category_tvid,_group_tvid];
					private _group_class = _tree_ctrl tvData [0,_faction_tvid,_category_tvid,_group_tvid];
					private _group_cfg = (configFile >> "CfgGroups" >> _side_class >> _faction_class >> _category_class >> _group_class);
					if (_first and {not (getText (_x >> "vehicle") isKindOf "Man")} count (_group_cfg call Achilles_fnc_returnChildren) > 0) exitWith {};
					if (not _faction_included) then
					{
						_faction_included = true;
						(_group_factions select _side_id) pushBack _faction_name;
					};
					_groups_in_faction pushBack _group_cfg;
					_first = false;
				};
			};
			if (_faction_included) then
			{
				_groups_in_faction = [_groups_in_faction, [], {getText (_x >> "Name")}] call BIS_fnc_sortBy;
				(_groups select _side_id) pushBack _groups_in_faction;
			};
		};
	};
	
	// cache
	uiNamespace setVariable ["Achilles_var_nestedList_vehicleFactions", _vehicle_factions];
	uiNamespace setVariable ["Achilles_var_nestedList_vehicleCategories", _vehicle_categories];
	uiNamespace setVariable ["Achilles_var_nestedList_vehicles", _vehicles];
	uiNamespace setVariable ["Achilles_var_nestedList_groupFactions", _group_factions];
	uiNamespace setVariable ["Achilles_var_nestedList_groups", _groups];
};

// Show the user the dialog
private _dialogResult =
[
	localize "STR_AMAE_SPAWN_UNITS",
	[
		["COMBOBOX", localize "STR_AMAE_SIDE", SIDE_NAMES, 0, false, [["LBSelChanged","SIDE"]]],
		["COMBOBOX", [localize "STR_AMAE_VEHICLE", localize "STR_AMAE_FACTION"] joinString " ", [], 0, false, [["LBSelChanged","VEHICLE_FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_CATEGORY", [], 0, false, [["LBSelChanged","VEHICLE_CATEGORY"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE", [], 0, false, [["LBSelChanged","VEHICLE"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_BEHAVIOUR", [localize "STR_AMAE_RTB_DESPAWN", localize "STR_AMAE_STAY_AT_LZ"]],
		["COMBOBOX", localize "STR_AMAE_LZ_DZ", _lzOptions],
		["COMBOBOX", localize "STR_AMAE_TYPE",[localize "STR_A3_CfgWaypoints_Land",localize "STR_AMAE_FASTROPING",localize "STR_AMAE_PARADROP"]],
		["COMBOBOX", [localize "STR_AMAE_GROUP", localize "STR_AMAE_FACTION"] joinString " ", [], 0, false, [["LBSelChanged","GROUP_FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_INFANTRY_GROUP", [], 0, false, [["LBSelChanged","GROUP"]]],
		["COMBOBOX", localize "STR_AMAE_UNIT_RP", _rpOptions],
		["COMBOBOX", localize "STR_AMAE_UNIT_BEHAVIOUR", [localize "STR_AMAE_DEFAULT", localize "STR_AMAE_RELAXED", localize "STR_AMAE_CAUTIOUS", localize "STR_AMAE_COMBAT"]]
	],
	"Achilles_fnc_RscDisplayAttributes_CreateReinforcement"
] call Achilles_fnc_ShowChooseDialog;

// Get dialog results
if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_side_id","_vehicle_faction_id","_vehicle_category_id","_vehicle_id","_vehicle_behaviour","_lzdz_algorithm","_lzdz_type","_group_faction_id","_group_id","_rp_algorithm","_group_behaviour"];
private _side = SIDES select _side_id;
private _vehicle_type = (uiNamespace getVariable "Achilles_var_nestedList_vehicles") select _side_id select _vehicle_faction_id select _vehicle_category_id select _vehicle_id;
private _grp_cfg = (uiNamespace getVariable "Achilles_var_nestedList_groups") select _side_id select _group_faction_id select _group_id;
private _lzSize = 20;	// TODO make this a dialog parameter?
private _rpSize = 20;	// TODO make this a dialog parameters?

// Choose the LZ based on what the user indicated
private _lzLogic = [_spawn_position, _allLzLogics, _lzdz_algorithm] call Achilles_fnc_logicSelector;
private _lzPos = position _lzLogic;

// Adjust spawn position for HALO
if (_lzdz_type isEqualTo 3) then {_spawn_position set [2, 3000]};

// create the transport vehicle
private _vehicleInfo = [_spawn_position, _spawn_position getDir _lzPos, _vehicle_type, _side] call BIS_fnc_spawnVehicle;
_vehicleInfo params ["_vehicle", "", "_vehicleGroup"];

// Adjust altitude for HALO
if (_lzdz_type isEqualTo 3) then {_vehicle flyInHeight 3000};

// Add vehicle to curator
[[_vehicle]] call Ares_fnc_AddUnitsToCurator;

private _CrewTara = [_vehicle_type,false] call BIS_fnc_crewCount;
private _CrewBrutto =  [_vehicle_type,true] call BIS_fnc_crewCount;
private _CrewNetto = _CrewBrutto - _CrewTara;

// create infantry group and resize it to the given cargo space if needed
private _infantry_group = [_spawn_position, _side, _grp_cfg] call BIS_fnc_spawnGroup;
// delete remaining units if vehicle is overcrouded
private _infantry_list = units _infantry_group;
if (count _infantry_list > _CrewNetto) then
{
	_infantry_list resize _CrewNetto;
	private _infantry_to_delete = (units _infantry_group) - _infantry_list;
	{deleteVehicle _x} forEach _infantry_to_delete;
};

switch (_group_behaviour) do
{
	case 1: // Relaxed
	{
		_infantry_group setBehaviour "SAFE";
		_infantry_group setSpeedMode "LIMITED";
	};
	case 2: // Cautious
	{
		_infantry_group setBehaviour "AWARE";
		_infantry_group setSpeedMode "LIMITED";
	};
	case 3: // Combat
	{
		_infantry_group setBehaviour "COMBAT";
		_infantry_group setSpeedMode "NORMAL";
	};
};

// Choose a RP for the squad to head to once unloaded and set their waypoint.

private _rpLogic = [_lzPos, _allRpLogics, _rp_algorithm] call Achilles_fnc_logicSelector;
private _rpPos = position _rpLogic;
_infantry_group addWaypoint [_rpPos, _rpSize];

// Load the units into the vehicle.
{
	_x moveInCargo _vehicle;
} forEach _infantry_list;

// Add infantry to curator
[(units _infantry_group)] call Ares_fnc_AddUnitsToCurator;

if (_vehicle getVariable ["Achilles_var_noFastrope", false]) exitWith
{
	["ACE3 or AR is not loaded!"] call Achilles_fnc_showZeusErrorMessage;
	{deleteVehicle _x} forEach _infantry_list;
};

// create a waypoint for deploying the units
private _vehicleUnloadWp = _vehicleGroup addWaypoint [_lzPos, _lzSize];
if (_vehicle isKindOf "Air" and (_lzdz_type > 0)) then
{
	_vehicleUnloadWp setWaypointType "SCRIPTED";
	private _script = ["\achilles\functions_f_achilles\scripts\fn_wpParadrop.sqf", "\achilles\functions_f_achilles\scripts\fn_wpFastrope.sqf"] select (_lzdz_type isEqualTo 1);
	_vehicleUnloadWp setWaypointScript _script;
} else
{
	_vehicleUnloadWp setWaypointType "TR UNLOAD";
};

// Make the driver full skill. This makes him less likely to do dumb things
// when they take contact.
(driver _vehicle) setSkill 1;

if (_vehicle_type isKindOf "Air") then
{
	// Special settings for helicopters. Otherwise they tend to run away instead of land
	// if the LZ is hot.
	{
		_x allowFleeing 0; // Especially for helos... They're very cowardly.
	} forEach (crew _vehicle);
	// armed aircrafts are unreliable when they are not CARELESS
	_vehicleGroup setBehaviour "CARELESS";
	_vehicleUnloadWp setWaypointTimeout [0,0,0];
}
else
{
	_vehicleUnloadWp setWaypointTimeout [5,10,20]; // Give the units some time to get away from truck
};

// Generate the waypoints for after the transport drops off the troops.
if (_vehicle_behaviour == 0) then
{
	// RTB and despawn.
	private _vehicleReturnWp = _vehicleGroup addWaypoint [_spawn_position, 0];
	_vehicleReturnWp setWaypointTimeout [2,2,2]; // Let the unit stop before being despawned.
	_vehicleReturnWp setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];
};

// print a confirmation
[localize "STR_AMAE_REINFORCEMENT_DISPATCHED"] call Ares_fnc_showZeusMessage;


#include "\achilles\modules_f_ares\module_footer.hpp"
