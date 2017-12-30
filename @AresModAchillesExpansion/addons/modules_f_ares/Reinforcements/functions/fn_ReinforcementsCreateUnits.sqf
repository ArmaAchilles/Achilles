#include "\achilles\modules_f_ares\module_header.hpp"

#define SIDES 									[east, west, independent]
#define SIDE_NAMES								[localize "STR_AMAE_BLUFOR", localize "STR_AMAE_OPFOR", localize "STR_AMAE_INDEPENDENT"]
#define FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX 	4

disableSerialization;

private _spawn_position = position _logic;

// options for selecting positions
private _extraOptions = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];

// get LZs
private _allLzsData = ["Ares_Module_Reinforcements_Create_Lz"] call Achilles_fnc_getPosLogicsData;
_allLzsData params ["_allLzNames","_allLzPositions"];
if (_allLzNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_LZ"] call Achilles_fnc_ShowZeusErrorMessage};
private _lzOptions = _extraOptions + _allLzNames;

// get RPs
private _allRpsData = ["Ares_Module_Reinforcements_Create_Rp"] call Achilles_fnc_getPosLogicsData;
_allRpsData params ["_allRpNames","_allRpPositions"];
if (_allRpNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_RP"] call Achilles_fnc_ShowZeusErrorMessage};
private _rpOptions = _extraOptions + _allRpNames;

// cache: find all possible vehicles and groups for reinforcements 
if (uiNamespace getVariable ["Achilles_var_nestedList_vehicleFactions", []] isEqualTo []) then
{
	// allocate data arrays
	private _factions = [];
	private _vehicle_categories = [];
	private _vehicles = [];
	private _groups = [];
	for "_" from 1 to (count SIDES) do
	{
		_factions pushBack [];
		_vehicle_categories pushBack [];
		_vehicles pushBack [];
		_groups pushBack [];
	};

	// get all factions
	{
		private _side_id = [_x, "side", 4] call BIS_fnc_returnConfigEntry;
		if (_side_id <= 2 and _side_id >= 0) then
		{
			(_factions select _side_id) pushBack configName _x;
			(_vehicle_categories select _side_id) pushBack [];
			(_vehicles select _side_id) pushBack [];
			(_groups select _side_id) pushBack [];
		};
	} forEach ((configFile >> "CfgFactionClasses") call Achilles_fnc_returnChildren);
	// sort by display names
	for "_side_id" from 0 to (count SIDES - 1) do
	{
		_factions set [_side_id, [(_factions select _side_id), [], {getText (configfile >> "CfgFactionClasses" >> _x >> "displayName")}] call BIS_fnc_sortBy];
	};

	// get all vehicles
	{
		private _type = configName _x;
		private _side_id = [_x, "side", 4] call BIS_fnc_returnConfigEntry;
		if ([_x, "scope", 0] call BIS_fnc_returnConfigEntry == 2 and _side_id <= 2) then
		{
			if (_type isKindOf "Tank" or _type isKindOf "Car" or _type isKindOf "Helicopter" or _type isKindOf "Plane"or _type isKindOf "Ship") then
			{
				if (([_type, true] call BIS_fnc_crewCount) - ([_type, false] call BIS_fnc_crewCount) > 0) then
				{
					private _faction = getText (_x >> "faction");
					private _faction_id = (_factions select _side_id) find _faction;
					if (_faction_id >= 0) then
					{
						private _vehicle_category = [_x, "editorSubcategory", "EdSubcat_Default"] call BIS_fnc_returnConfigEntry;
						private _vehicle_category_id = (_vehicle_categories select _side_id select _faction_id) find _vehicle_category;
						if (_vehicle_category_id >= 0) then
						{
							(_vehicles select _side_id select _faction_id select _vehicle_category_id) pushBack _x;
						} else
						{
							(_vehicle_categories select _side_id select _faction_id) pushBack _vehicle_category;
							(_vehicles select _side_id select _faction_id) pushBack [_x];
						};
					};
				};
			};
		};
	} forEach ((configFile >> "CfgVehicles") call Achilles_fnc_returnChildren);

	// get all groups
	{
		private _side_id = [_x, "side", 4] call BIS_fnc_returnConfigEntry;
		if (_side_id <= 2) then
		{
			private _cfg = _x;
			{
				{
					{
						if ({not (getText (_x >> "vehicle") isKindOf "Man")} count (_x call Achilles_fnc_returnChildren) == 0) then
						{
							private _faction = getText (_x >> "faction");
							private _faction_id = (_factions select _side_id) find _faction;
							if (_faction_id >= 0) then
							{
								(_groups select _side_id select _faction_id) pushBack _x;
							};
						};
					} forEach (_x call Achilles_fnc_returnChildren); // for each group
				} forEach (_x call Achilles_fnc_returnChildren); // for each group category
			} forEach (_x call Achilles_fnc_returnChildren); // for each faction
		};
	} forEach ((configFile >> "CfgGroups") call Achilles_fnc_returnChildren);
	// sort by display names
	for "_side_id" from 0 to (count SIDES - 1) do
	{
		for "_faction_id" from 0 to (count (_factions select _side_id) - 1) do
		{
			(_groups select _side_id) set [_faction_id, [(_groups select _side_id select _faction_id), [], {getText (_x >> "displayName")}] call BIS_fnc_sortBy];
			for "_vehicle_category_id" from 0 to (count (_vehicle_categories select _side_id select _faction_id) - 1) do
			{
				(_vehicles select _side_id select _faction_id) set[_vehicle_category_id, [(_vehicles select _side_id select _faction_id select _vehicle_category_id), [], {getText (_x >> "displayName")}] call BIS_fnc_sortBy];
			};
		};
	};

	// remove empty factions
	private _vehicle_factions = +_factions;
	private _group_factions = +_factions;
	for "_side_id" from 0 to (count SIDES - 1) do
	{
		for "_faction_id" from (count (_factions select _side_id) - 1) to 0 step -1 do
		{
			if (count (_vehicles select _side_id select _faction_id) == 0) then
			{
				(_vehicle_factions select _side_id) deleteAt _faction_id;
				(_vehicle_categories select _side_id) deleteAt _faction_id;
				(_vehicles select _side_id) deleteAt _faction_id;
			};
			if (count (_groups select _side_id select _faction_id) == 0) then
			{
				(_group_factions select _side_id) deleteAt _faction_id;
				(_groups select _side_id) deleteAt _faction_id;
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
	"Achilles_fnc_RscDisplayAttributes_Create_Reinforcement"
] call Achilles_fnc_ShowChooseDialog;

// Get dialog results
if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_side_id","_veh_fac_id","_veh_cat_id","_veh_id","_veh_beh","_lzdz_algorithm","_lzdz_type","_grp_fac_id","_grp_id","_rp_algorithm","_grp_beh"];
private _side = SIDES select _side_id;
private _vehicle_type = configName ((uiNamespace getVariable "Achilles_var_nestedList_vehicles") select _side_id select _veh_fac_id select _veh_cat_id select _veh_id);
private _grp_cfg = (uiNamespace getVariable "Achilles_var_nestedList_groups") select _side_id select _grp_fac_id select _grp_id;
private _lzSize = 20;	// TODO make this a dialog parameter?
private _rpSize = 20;	// TODO make this a dialog parameters?

// Choose the LZ based on what the user indicated
private _lzPos = [_spawn_position, _allLzPositions, _lzdz_algorithm] call Achilles_fnc_selectPosition;

// create the transport vehicle
private _vehicleInfo = [_spawn_position, _spawn_position getDir _lzPos, _vehicle_type, _side] call BIS_fnc_spawnVehicle;
private _vehicle = _vehicleInfo select 0;
private _vehicleGroup = _vehicleInfo select 2;
//_vehicleDummyWp = _vehicleGroup addWaypoint [position _vehicle, 0];
private _vehicleUnloadWp = _vehicleGroup addWaypoint [_lzPos, _lzSize];
if (_vehicle isKindOf "Air" and (_dialogResult select 6 > 0)) then
{
	_vehicleUnloadWp setWaypointType "SCRIPTED";
	private _script = ["\achilles\functions_f_achilles\scripts\fn_wpParadrop.sqf", "\achilles\functions_f_achilles\scripts\fn_wpFastrope.sqf"] select (_dialogResult select 6 == 1);
	_vehicleUnloadWp setWaypointScript _script;
} else
{
	_vehicleUnloadWp setWaypointType "TR UNLOAD";
};

// Make the driver full skill. This makes him less likely to do dumb things
// when they take contact.
(driver (vehicle (leader _vehicleGroup))) setSkill 1;

if (_vehicle_type isKindOf "Air") then
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
if (_veh_beh == 0) then
{
	// RTB and despawn.
	private _vehicleReturnWp = _vehicleGroup addWaypoint [_spawn_position, 0];
	_vehicleReturnWp setWaypointTimeout [2,2,2]; // Let the unit stop before being despawned.
	_vehicleReturnWp setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];
};

// Add vehicle to curator
[(units _vehicleGroup) + [(vehicle (leader _vehicleGroup))]] call Ares_fnc_AddUnitsToCurator;

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

switch (_grp_beh) do
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
private _rpPos = [_lzPos, _allRpPositions, _rp_algorithm] call Achilles_fnc_selectPosition;
_infantry_group addWaypoint [_rpPos, _rpSize];

// Load the units into the vehicle.
{
	_x moveInCargo (vehicle (leader _vehicleGroup));
} forEach _infantry_list;

// Add infantry to curator
[(units _infantry_group)] call Ares_fnc_AddUnitsToCurator;

if (_vehicle getVariable ["Achilles_var_noFastrope", false]) exitWith
{
	["ACE3 or AR is not loaded!"] call Achilles_fnc_showZeusErrorMessage;
	{deleteVehicle _x} forEach _infantry_list;
};

// print a confirmation
if (count _allRps > 0) then
{
	[objNull, localize "STR_AMAE_REINFORCEMENT_DISPATCHED"] call Ares_fnc_showZeusMessage;
}
else
{
	[objNull, "Transport dispatched to LZ. Squad will stay at LZ."] call bis_fnc_showCuratorFeedbackMessage;
};


#include "\achilles\modules_f_ares\module_footer.hpp"
