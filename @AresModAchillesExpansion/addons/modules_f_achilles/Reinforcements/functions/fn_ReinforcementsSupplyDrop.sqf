/*
	Author: CreepPork_LV, Kex

	Description:
		Displays option to create a aircraft that takes supplies (vehicles or cargo boxes) to its destination.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define SIDES 									[east, west, independent]
#define SIDE_NAMES								[localize "STR_AMAE_OPFOR", localize "STR_AMAE_BLUFOR", localize "STR_AMAE_INDEPENDENT"]
#define FIRST_SPECIFIC_LZ_OR_RP_OPTION_INDEX	4

#define CURATOR_UNITS_IDCs 						[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]
#define CURATOR_GROUPS_IDCs 					[IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER]

#include "\achilles\modules_f_ares\module_header.hpp"

disableSerialization;

private _spawn_position = position _logic;

// options for selecting positions
private _extraOptions = [localize "STR_AMAE_RANDOM", localize "STR_AMAE_NEAREST", localize "STR_AMAE_FARTHEST"];

// get LZs
private _allLzsData = ["Ares_Module_Reinforcements_Create_Lz"] call Achilles_fnc_getPosLogicsData;
_allLzsData params ["_allLzNames","_allLzPositions"];
if (_allLzNames isEqualTo []) exitWith {[localize "STR_AMAE_NO_LZ"] call Achilles_fnc_ShowZeusErrorMessage};
private _lzOptions = _extraOptions + _allLzNames;

// cache: find all possible vehicles and groups for reinforcements 
if (uiNamespace getVariable ["Achilles_var_supplyDrop_factions", []] isEqualTo []) then
{
	private _curator_interface = findDisplay IDD_RSCDISPLAYCURATOR;
	
	private _factions = [];
	private _categories = [];
	private _vehicles = [];
	private _cargoFactions = [];
	private _cargoCategories = [];
	private _cargoVehicles = [];
	
	for "_side_id" from 0 to (count SIDES - 1) do
	{
		// find vehicles
		private _tree_ctrl = _curator_interface displayCtrl (CURATOR_UNITS_IDCs select _side_id);
		_factions pushBack [];
		_categories pushBack [];
		_vehicles pushBack [];
		_cargoFactions pushBack [];
		_cargoCategories pushBack [];
		_cargoVehicles pushBack [];
		private _faction_id = -1;
		private _cargoFaction_id = -1;
		for "_faction_tvid" from 0 to ((_tree_ctrl tvCount []) - 1) do
		{
			private _factionIncludedInTransport = false;
			private _factionIncludedInCargo = false;
			private _faction = _tree_ctrl tvText [_faction_tvid];
			private _category_id = -1;
			private _cargoCategory_id = -1;
			for "_category_tvid" from 0 to ((_tree_ctrl tvCount [_faction_tvid]) - 1) do
			{
				private _categoryIncludedInTransport = false;
				private _categoryIncludedInCargo = false;
				private _category = _tree_ctrl tvText [_faction_tvid,_category_tvid];
				for "_vehicle_tvid" from 0 to ((_tree_ctrl tvCount [_faction_tvid,_category_tvid]) - 1) do
				{
					private _vehicle = _tree_ctrl tvData [_faction_tvid,_category_tvid,_vehicle_tvid];
					if (getNumber (configFile >> "CfgVehicles" >> _vehicle >> "slingLoadMaxCargoMass") > 0 or {isClass (configFile >> "CfgVehicles" >> _vehicle >> "VehicleTransport" >> "Carrier")}) then
					{
						if (not _factionIncludedInTransport) then
						{
							_factionIncludedInTransport = true;
							(_factions select _side_id) pushBack _faction;
							_faction_id = _faction_id + 1;
							(_categories select _side_id) pushBack [];
							(_vehicles select _side_id) pushBack [];
						};
						if (not _categoryIncludedInTransport) then
						{
							_categoryIncludedInTransport = true;
							(_categories select _side_id select _faction_id) pushBack _category;
							_category_id = _category_id + 1;
							(_vehicles select _side_id select _faction_id) pushBack [];
						};
						(_vehicles select _side_id select _faction_id select _category_id) pushBack _vehicle;
					};
					if (count getArray (configFile >> "CfgVehicles" >> _vehicle >> "slingLoadCargoMemoryPoints") > 0 or {isClass (configFile >> "CfgVehicles" >> _vehicle >> "VehicleTransport" >> "Cargo")}) then
					{
						if (not _factionIncludedInCargo) then
						{
							_factionIncludedInCargo = true;
							(_cargoFactions select _side_id) pushBack _faction;
							_cargoFaction_id = _cargoFaction_id + 1;
							(_cargoCategories select _side_id) pushBack [];
							(_cargoVehicles select _side_id) pushBack [];
						};
						if (not _categoryIncludedInCargo) then
						{
							_categoryIncludedInCargo = true;
							(_cargoCategories select _side_id select _cargoFaction_id) pushBack _category;
							_cargoCategory_id = _cargoCategory_id + 1;
							(_cargoVehicles select _side_id select _cargoFaction_id) pushBack [];
						};
						(_cargoVehicles select _side_id select _cargoFaction_id select _cargoCategory_id) pushBack _vehicle;
					};
				};
			};
		};
	};
	
	// get ammo boxes
	private _targetCategory = getText (configfile >> "CfgEditorCategories" >> "EdCat_Supplies" >> "displayName");
	private _supplySubCategory = [];
	private _supplies = [];
	private _tree_ctrl = _curator_interface displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
	for "_supplyCategory_id" from 0 to ((_tree_ctrl tvCount []) - 1) do
	{
		if (_targetCategory == _tree_ctrl tvText [_supplyCategory_id]) exitWith
		{
			for "_supplySubCategory_id" from 0 to ((_tree_ctrl tvCount [_supplyCategory_id]) - 1) do
			{
				_supplySubCategory pushBack (_tree_ctrl tvText [_supplyCategory_id,_supplySubCategory_id]);
				_supplies pushBack [];
				for "_supply_id" from 0 to ((_tree_ctrl tvCount [_supplyCategory_id,_supplySubCategory_id]) - 1) do
				{
					private _supply = _tree_ctrl tvData [_supplyCategory_id,_supplySubCategory_id,_supply_id];
					if (count getArray (configFile >> "CfgVehicles" >> _supply >> "slingLoadCargoMemoryPoints") > 0) then
					{
						(_supplies select _supplySubCategory_id) pushBack _supply;
					};
				};
			};
		};
	};
	
	// cache
	uiNamespace setVariable ["Achilles_var_supplyDrop_factions", _factions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_categories", _categories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_vehicles", _vehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoFactions", _cargoFactions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoCategories", _cargoCategories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoVehicles", _cargoVehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_supplySubCategories", _supplySubCategory];
	uiNamespace setVariable ["Achilles_var_supplyDrop_supplies", _supplies];
};

// Show the user the dialog
private _dialogResult =
[
	localize "STR_AMAE_SUPPLY_DROP",
	[
		["COMBOBOX", localize "STR_AMAE_SIDE", SIDE_NAMES, 0, false, [["LBSelChanged","SIDE"]]],
		["COMBOBOX", localize "STR_AMAE_FACTION", [], 0, false, [["LBSelChanged","FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_CATEGORY", [], 0, false, [["LBSelChanged","CATEGORY"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE", []],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_BEHAVIOUR", [localize "STR_AMAE_RTB_DESPAWN", localize "STR_AMAE_STAY_AT_LZ"]],
		["COMBOBOX", localize "STR_AMAE_LZ_DZ", _lzOptions],
		["COMBOBOX", localize "STR_AMAE_AMMUNITION_CRATE_OR_VEHICLE", [localize "STR_AMAE_AMMUNITION_CRATE", localize "STR_AMAE_VEHICLE"], 0, false, [["LBSelChanged","CARGO_TYPE"]]],
		["COMBOBOX", localize "STR_AMAE_CARGO_LW", [localize "STR_AMAE_DEFAULT", localize "STR_AMAE_EDIT_CARGO", localize "STR_AMAE_VIRTUAL_ARSENAL", localize "STR_AMAE_EMPTY"]],
		["COMBOBOX", localize "STR_AMAE_SIDE", SIDE_NAMES, 0, false, [["LBSelChanged","CARGO_SIDE"]]],
		["COMBOBOX", localize "STR_AMAE_FACTION", [], 0, false, [["LBSelChanged","CARGO_FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_CATEGORY", [], 0, false, [["LBSelChanged","CARGO_CATEGORY"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE", []]
	],
	"Achilles_fnc_RscDisplayAttributes_SupplyDrop"
] call Achilles_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_side_id",
	"_faction_id",
	"_category_id",
	"_vehicle_id",
	"_aircraftBehaviour",
	"_lzdz_algorithm",
	"_cargoType",
	"_cargoBoxInventory",
	"_cargoSide_id",
	"_cargoFaction_id",
	"_cargoCategory_id",
	"_cargoVehicle_id"
];

// Choose the LZ based on what the user indicated

private _lzPos = [_spawn_position, _allLzPositions, _lzdz_algorithm] call Achilles_fnc_positionSelector;

private _aircraftClassname = (uiNamespace getVariable "Achilles_var_supplyDrop_vehicles") select _side_id select _faction_id select _category_id select _vehicle_id;
if (_aircraftClassname isEqualTo "") exitWith {[localize "STR_AMAE_AIRCRAFT_SPAWN_ERROR"] call Achilles_fnc_showZeusErrorMessage};

_aircraftSide = _side_id call BIS_fnc_sideType;

private _spawnedAircraftArray = [_spawn_position, _spawn_position getDir _lzPos, _aircraftClassname, _aircraftSide] call BIS_fnc_spawnVehicle;

_spawnedAircraftArray params ["_aircraft", "_aircraftCrew", "_aircraftGroup"];

[[_aircraft]] call Ares_fnc_AddUnitsToCurator;

{
	[[_x]] call Ares_fnc_AddUnitsToCurator;
} forEach _aircraftCrew;

private _aircraftDriver = driver _aircraft;

_aircraftDriver setSkill 1;
_aircraftGroup allowFleeing 0;

// If the selected cargo is the ammo box.
if (_cargoType == 0) then
{
	private _cargoBoxClassname = (uiNamespace getVariable "Achilles_var_supplyDrop_supplies") select _cargoCategory_id select _cargoVehicle_id;

	private _cargoBox = _cargoBoxClassname createVehicle _spawn_position;

	[[_cargoBox]] call Ares_fnc_AddUnitsToCurator;

	private _hasAttached = _aircraft setSlingLoad _cargoBox;
	if (!_hasAttached) exitWith 
	{
		[localize "STR_AMAE_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage;
		{deleteVehicle _x} forEach _aircraftCrew;
		deleteVehicle _aircraft;
		deleteVehicle _cargoBox;
	};

	switch (_cargoBoxInventory) do
	{
		case 1:
		{
			missionNamespace setVariable ["BIS_fnc_initCuratorAttributes_target", _cargoBox];
			createDialog "RscDisplayAttributesInventory";
			waitUntil {isNull ((uiNamespace getVariable "RscDisplayAttributesInventory") displayCtrl IDC_RSCATTRIBUTEINVENTORY_RSCATTRIBUTEINVENTORY)};
		};
		case 2:
		{
			if (["arsenal"] call Achilles_fnc_isACELoaded) then
			{
				[_cargoBox, true] call ace_arsenal_fnc_initBox;
			}
			else
			{
				["AmmoboxInit", [_cargoBox, true]] spawn BIS_fnc_Arsenal;
			};
		};
		case 3:
		{
			clearItemCargoGlobal _cargoBox;
			clearWeaponCargoGlobal _cargoBox;
			clearBackpackCargoGlobal _cargoBox;
			clearMagazineCargoGlobal _cargoBox;
		};
	};
}
// If select cargo type is a Vehicle.
else
{
	private _cargoClassname = (uiNamespace getVariable "Achilles_var_supplyDrop_cargoVehicles") select _cargoSide_id select _cargoFaction_id select _cargoCategory_id select _cargoVehicle_id;
	
	private _cargo = _cargoClassname createVehicle _spawn_position;

	[[_cargo]] call Ares_fnc_AddUnitsToCurator;

	if (vehicleCargoEnabled _aircraft) then
	{
		private _hasLoaded = _aircraft setVehicleCargo _cargo;
		if (!_hasLoaded) exitWith
		{
			[localize "STR_AMAE_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage;
			{deleteVehicle _x} forEach _aircraftCrew;
			deleteVehicle _aircraft;
			deleteVehicle _cargo;
		};
	}
	else
	{
		private _hasAttached = _aircraft setSlingLoad _cargo;
		if (!_hasAttached) exitWith
		{
			[localize "STR_AMAE_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage;
			{deleteVehicle _x} forEach _aircraftCrew;
			deleteVehicle _aircraft;
			deleteVehicle _cargo;
		};
	};
};

private _LZWaypoint = _aircraftGroup addWaypoint [_lzPos, 20];
_aircraftGroup setSpeedMode "FULL";

if !((getVehicleCargo _aircraft) isEqualTo []) then
{
	_LZWaypoint setWaypointStatements ["true", "objNull setVehicleCargo ((getVehicleCargo (vehicle this)) select 0);"];
}
else
{
	_LZWaypoint setWaypointType "UNHOOK";
};

// If the aircraft is set to return back
if (_aircraftBehaviour == 0) then
{
	private _returnWaypoint = _aircraftGroup addWaypoint [(getPos _aircraft), 0];
	_returnWaypoint setWaypointTimeout [2, 2, 2];
	_returnWaypoint setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
