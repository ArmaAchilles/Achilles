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

#define SIDES 									[east, west, independent, civilian]
#define SIDE_NAMES								[localize "STR_AMAE_OPFOR", localize "STR_AMAE_BLUFOR", localize "STR_AMAE_INDEPENDENT", localize "STR_AMAE_CIVILIANS"]

#define CURATOR_UNITS_IDCs 						[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV]

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
					if (not (_vehicle isKindOf "UAV_06_base_F") and {getNumber (configFile >> "CfgVehicles" >> _vehicle >> "slingLoadMaxCargoMass") > 0 or {isClass (configFile >> "CfgVehicles" >> _vehicle >> "VehicleTransport" >> "Carrier")}}) then
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
	private _supplySubCategories = [];
	private _supplies = [];
	private _tree_ctrl = _curator_interface displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
	private _supplySubCategory_id = 0;
	private _n_supplySubCategories = 0;
	for "_supplyCategory_tvid" from 0 to ((_tree_ctrl tvCount []) - 1) do
	{
		for "_supplySubCategory_tvid" from 0 to ((_tree_ctrl tvCount [_supplyCategory_tvid]) - 1) do
		{
			private _subCategoryIncluded = false;
			for "_supply_tvid" from 0 to ((_tree_ctrl tvCount [_supplyCategory_tvid,_supplySubCategory_tvid]) - 1) do
			{
				private _supply = _tree_ctrl tvData [_supplyCategory_tvid,_supplySubCategory_tvid,_supply_tvid];
				if (not (_supply isKindOf "AllVehicles" or {_supply isKindOf "Cargo10_base_F"}) and {count getArray (configFile >> "CfgVehicles" >> _supply >> "slingLoadCargoMemoryPoints") > 0}) then
				{
					if (not _subCategoryIncluded) then
					{
						_subCategoryIncluded = true;
						private _supplySubCategory = _tree_ctrl tvText [_supplyCategory_tvid,_supplySubCategory_tvid];
						_supplySubCategory_id = _supplySubCategories find _supplySubCategory;
						if (_supplySubCategory_id == -1) then 
						{
							_supplySubCategories pushBack _supplySubCategory;
							_supplySubCategory_id = _n_supplySubCategories;
							_n_supplySubCategories = _n_supplySubCategories + 1;
							_supplies pushBack [];
						};
					};
					(_supplies select _supplySubCategory_id) pushBack _supply;
				};
			};
		};
	};
	for "_supplySubCategory_id" from 0 to (_n_supplySubCategories - 1) do
	{
		_supplies set [_supplySubCategory_id, [_supplies select _supplySubCategory_id, [], {getText (configFile >> "CfgVehicles" >> _x >> "displayName")}] call BIS_fnc_sortBy]; 
	};
	
	// cache
	uiNamespace setVariable ["Achilles_var_supplyDrop_factions", _factions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_categories", _categories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_vehicles", _vehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoFactions", _cargoFactions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoCategories", _cargoCategories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoVehicles", _cargoVehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_supplySubCategories", _supplySubCategories];
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
		["COMBOBOX", localize "STR_AMAE_CARGO_LW", [localize "STR_AMAE_DEFAULT", localize "STR_AMAE_EDIT_CARGO", localize "STR_AMAE_ADD_FULL", localize "STR_AMAE_EMPTY"]],
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
	"_cargoInventory",
	"_cargoSide_id",
	"_cargoFaction_id",
	"_cargoCategory_id",
	"_cargoVehicle_id"
];

// Choose the LZ based on what the user indicated

private _lzLogic = [_spawn_position, _allLzLogics, _lzdz_algorithm] call Achilles_fnc_logicSelector;
private _lzPos = position _lzLogic;

private _aircraftClassname = (uiNamespace getVariable "Achilles_var_supplyDrop_vehicles") select _side_id select _faction_id select _category_id select _vehicle_id;
if (_aircraftClassname isEqualTo "") exitWith {[localize "STR_AMAE_AIRCRAFT_SPAWN_ERROR"] call Achilles_fnc_showZeusErrorMessage};

_aircraftSide = _side_id call BIS_fnc_sideType;

private _spawnedAircraftArray = [_spawn_position, _spawn_position getDir _lzPos, _aircraftClassname, _aircraftSide] call BIS_fnc_spawnVehicle;

_spawnedAircraftArray params ["_aircraft", "_aircraftCrew", "_aircraftGroup"];

[[_aircraft]] call Ares_fnc_AddUnitsToCurator;

private _aircraftDriver = driver _aircraft;

_aircraftDriver setSkill 1;
_aircraftGroup allowFleeing 0;

// spawn the cargo
private _cargoClassname = if (_cargoType == 0) then
{
	(uiNamespace getVariable "Achilles_var_supplyDrop_supplies") select _cargoCategory_id select _cargoVehicle_id;
} else
{
	(uiNamespace getVariable "Achilles_var_supplyDrop_cargoVehicles") select _cargoSide_id select _cargoFaction_id select _cargoCategory_id select _cargoVehicle_id;
};
private _cargo = _cargoClassname createVehicle _spawn_position;
[[_cargo]] call Ares_fnc_AddUnitsToCurator;

// attach the cargo to the transport vehicle
switch (true) do
{
	case ((_aircraft canVehicleCargo _cargo) select 0):
	{
		_aircraft setVehicleCargo _cargo;
	};
	case (_aircraft canSlingLoad _cargo):
	{
		_aircraft setSlingLoad _cargo
	};
	default
	{
		[localize "STR_AMAE_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage;
		{deleteVehicle _x} forEach _aircraftCrew;
		deleteVehicle _aircraft;
		deleteVehicle _cargo;
	};
};

// If the selected cargo is the ammo box.
if (_cargoType == 0) then
{
	switch (_cargoInventory) do
	{
		case 1:
		{
			missionNamespace setVariable ["BIS_fnc_initCuratorAttributes_target", _cargo];
			createDialog "RscDisplayAttributesInventory";
			waitUntil {isNull ((uiNamespace getVariable "RscDisplayAttributesInventory") displayCtrl IDC_RSCATTRIBUTEINVENTORY_RSCATTRIBUTEINVENTORY)};
		};
		case 2:
		{
			if (["arsenal"] call Achilles_fnc_isACELoaded) then
			{
				[_cargo, true] call ace_arsenal_fnc_initBox;
			}
			else
			{
				["AmmoboxInit", [_cargo, true]] spawn BIS_fnc_Arsenal;
			};
		};
		case 3:
		{
			clearItemCargoGlobal _cargo;
			clearWeaponCargoGlobal _cargo;
			clearBackpackCargoGlobal _cargo;
			clearMagazineCargoGlobal _cargo;
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
