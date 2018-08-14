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

#include "\achilles\modules_f_ares\module_header.h"

disableSerialization;

private _spawnPosition = position _logic;

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
	private _curatorInterface = findDisplay IDD_RSCDISPLAYCURATOR;
	
	private _sides = SIDE_NAMES;
	private _factions = [];
	private _categories = [];
	private _vehicles = [];
	private _cargoSides = SIDE_NAMES;
	private _cargoFactions = [];
	private _cargoCategories = [];
	private _cargoVehicles = [];
	
	for "_sideId" from 0 to (count SIDES - 1) do
	{
		// find vehicles
		private _treeCtrl = _curatorInterface displayCtrl (CURATOR_UNITS_IDCs select _sideId);
		_factions pushBack [];
		_categories pushBack [];
		_vehicles pushBack [];
		_cargoFactions pushBack [];
		_cargoCategories pushBack [];
		_cargoVehicles pushBack [];
		private _factionId = -1;
		private _cargoFactionId = -1;
		for "_factionTvId" from 0 to ((_treeCtrl tvCount []) - 1) do
		{
			private _factionIncludedInTransport = false;
			private _factionIncludedInCargo = false;
			private _faction = _treeCtrl tvText [_factionTvId];
			private _categoryId = -1;
			private _cargoCategoryId = -1;
			for "_categoryTvId" from 0 to ((_treeCtrl tvCount [_factionTvId]) - 1) do
			{
				private _categoryIncludedInTransport = false;
				private _categoryIncludedInCargo = false;
				private _category = _treeCtrl tvText [_factionTvId,_categoryTvId];
				for "_vehicleTvId" from 0 to ((_treeCtrl tvCount [_factionTvId,_categoryTvId]) - 1) do
				{
					private _vehicle = _treeCtrl tvData [_factionTvId,_categoryTvId,_vehicleTvId];
					if (not (_vehicle isKindOf "UAV_06_base_F") and {getNumber (configFile >> "CfgVehicles" >> _vehicle >> "slingLoadMaxCargoMass") > 0 or {isClass (configFile >> "CfgVehicles" >> _vehicle >> "VehicleTransport" >> "Carrier")}}) then
					{
						if (not _factionIncludedInTransport) then
						{
							_factionIncludedInTransport = true;
							(_factions select _sideId) pushBack _faction;
							_factionId = _factionId + 1;
							(_categories select _sideId) pushBack [];
							(_vehicles select _sideId) pushBack [];
						};
						if (not _categoryIncludedInTransport) then
						{
							_categoryIncludedInTransport = true;
							(_categories select _sideId select _factionId) pushBack _category;
							_categoryId = _categoryId + 1;
							(_vehicles select _sideId select _factionId) pushBack [];
						};
						(_vehicles select _sideId select _factionId select _categoryId) pushBack _vehicle;
					};
					if (count getArray (configFile >> "CfgVehicles" >> _vehicle >> "slingLoadCargoMemoryPoints") > 0 or {isClass (configFile >> "CfgVehicles" >> _vehicle >> "VehicleTransport" >> "Cargo")}) then
					{
						if (not _factionIncludedInCargo) then
						{
							_factionIncludedInCargo = true;
							(_cargoFactions select _sideId) pushBack _faction;
							_cargoFactionId = _cargoFactionId + 1;
							(_cargoCategories select _sideId) pushBack [];
							(_cargoVehicles select _sideId) pushBack [];
						};
						if (not _categoryIncludedInCargo) then
						{
							_categoryIncludedInCargo = true;
							(_cargoCategories select _sideId select _cargoFactionId) pushBack _category;
							_cargoCategoryId = _cargoCategoryId + 1;
							(_cargoVehicles select _sideId select _cargoFactionId) pushBack [];
						};
						(_cargoVehicles select _sideId select _cargoFactionId select _cargoCategoryId) pushBack _vehicle;
					};
				};
			};
		};
	};
	
	// remove side if it does not contain any factions
	for "_sideId" from (count SIDES - 1) to 0 step -1 do
	{
		if ((_factions select _sideId) isEqualTo [] || {(_cargoFactions select _sideId) isEqualTo []}) then
		{
			_sides deleteAt _sideId;
			_factions deleteAt _sideId;
			_categories deleteAt _sideId;
			_vehicles deleteAt _sideId;
			_cargoSides deleteAt _sideId;
			_cargoFactions deleteAt _sideId;
			_cargoCategories deleteAt _sideId;
			_cargoVehicles deleteAt _sideId;
		};
	};
	
	// get ammo boxes
	private _supplySubCategories = [];
	private _supplies = [];
	private _treeCtrl = _curatorInterface displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
	private _supplySubCategoryId = 0;
	private _nSupplySubCategories = 0;
	for "_supplyCategoryTvId" from 0 to ((_treeCtrl tvCount []) - 1) do
	{
		for "_supplySubCategoryTvId" from 0 to ((_treeCtrl tvCount [_supplyCategoryTvId]) - 1) do
		{
			private _subCategoryIncluded = false;
			for "_supplyTvId" from 0 to ((_treeCtrl tvCount [_supplyCategoryTvId,_supplySubCategoryTvId]) - 1) do
			{
				private _supply = _treeCtrl tvData [_supplyCategoryTvId,_supplySubCategoryTvId,_supplyTvId];
				if (not (_supply isKindOf "AllVehicles" or {_supply isKindOf "Cargo10_base_F"}) and {count getArray (configFile >> "CfgVehicles" >> _supply >> "slingLoadCargoMemoryPoints") > 0}) then
				{
					if (not _subCategoryIncluded) then
					{
						_subCategoryIncluded = true;
						private _supplySubCategory = _treeCtrl tvText [_supplyCategoryTvId,_supplySubCategoryTvId];
						_supplySubCategoryId = _supplySubCategories find _supplySubCategory;
						if (_supplySubCategoryId == -1) then 
						{
							_supplySubCategories pushBack _supplySubCategory;
							_supplySubCategoryId = _nSupplySubCategories;
							_nSupplySubCategories = _nSupplySubCategories + 1;
							_supplies pushBack [];
						};
					};
					(_supplies select _supplySubCategoryId) pushBack _supply;
				};
			};
		};
	};
	for "_supplySubCategoryId" from 0 to (_nSupplySubCategories - 1) do
	{
		_supplies set [_supplySubCategoryId, [_supplies select _supplySubCategoryId, [], {getText (configFile >> "CfgVehicles" >> _x >> "displayName")}] call BIS_fnc_sortBy]; 
	};
	
	// cache
	uiNamespace setVariable ["Achilles_var_supplyDrop_sides", _sides];
	uiNamespace setVariable ["Achilles_var_supplyDrop_factions", _factions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_categories", _categories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_vehicles", _vehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoSides", _cargoSides];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoFactions", _cargoFactions];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoCategories", _cargoCategories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_cargoVehicles", _cargoVehicles];
	uiNamespace setVariable ["Achilles_var_supplyDrop_supplySubCategories", _supplySubCategories];
	uiNamespace setVariable ["Achilles_var_supplyDrop_supplies", _supplies];
};

private _sides = uiNamespace getVariable ["Achilles_var_supplyDrop_sides", []];
private _cargoSides = uiNamespace getVariable ["Achilles_var_supplyDrop_sides", []];
if (_sides isEqualTo [] || {_cargoSides isEqualTo []}) exitWith {[localize "STR_AMAE_NO_VEHICLES_AVAILABLE__CHECK_FACTION_FILTER"] call Achilles_fnc_ShowZeusErrorMessage};

// Show the user the dialog
private _dialogResult =
[
	localize "STR_AMAE_SUPPLY_DROP",
	[
		["COMBOBOX", localize "STR_AMAE_SIDE", _sides, 0, false, [["LBSelChanged","SIDE"]]],
		["COMBOBOX", localize "STR_AMAE_FACTION", [], 0, false, [["LBSelChanged","FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_CATEGORY", [], 0, false, [["LBSelChanged","CATEGORY"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE", []],
		["COMBOBOX", localize "STR_AMAE_VEHICLE_BEHAVIOUR", [localize "STR_AMAE_RTB_DESPAWN", localize "STR_AMAE_STAY_AT_LZ"]],
		["COMBOBOX", localize "STR_AMAE_LZ_DZ", _lzOptions],
		["COMBOBOX", localize "STR_AMAE_AMMUNITION_CRATE_OR_VEHICLE", [localize "STR_AMAE_AMMUNITION_CRATE", localize "STR_AMAE_VEHICLE"], 0, false, [["LBSelChanged","CARGO_TYPE"]]],
		["COMBOBOX", localize "STR_AMAE_CARGO_LW", [localize "STR_AMAE_DEFAULT", localize "STR_AMAE_EDIT_CARGO", localize "STR_AMAE_ADD_FULL", localize "STR_AMAE_EMPTY"]],
		["COMBOBOX", localize "STR_AMAE_SIDE", _cargoSides, 0, false, [["LBSelChanged","CARGO_SIDE"]]],
		["COMBOBOX", localize "STR_AMAE_FACTION", [], 0, false, [["LBSelChanged","CARGO_FACTION"]]],
		["COMBOBOX", localize "STR_AMAE_CATEGORY", [], 0, false, [["LBSelChanged","CARGO_CATEGORY"]]],
		["COMBOBOX", localize "STR_AMAE_VEHICLE", []]
	],
	"Achilles_fnc_RscDisplayAttributes_SupplyDrop"
] call Achilles_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_sideId",
	"_factionId",
	"_categoryId",
	"_vehicleId",
	"_aircraftBehaviour",
	"_lzdzAlgorithm",
	"_cargoType",
	"_cargoInventory",
	"_cargoSideId",
	"_cargoFactionId",
	"_cargoCategoryId",
	"_cargoVehicleId"
];

// Choose the LZ based on what the user indicated

private _lzLogic = [_spawnPosition, _allLzLogics, _lzdzAlgorithm] call Achilles_fnc_logicSelector;
private _lzPos = position _lzLogic;

private _aircraftClassname = (uiNamespace getVariable "Achilles_var_supplyDrop_vehicles") select _sideId select _factionId select _categoryId select _vehicleId;
if (_aircraftClassname isEqualTo "") exitWith {[localize "STR_AMAE_AIRCRAFT_SPAWN_ERROR"] call Achilles_fnc_showZeusErrorMessage};

_aircraftSide = _sideId call BIS_fnc_sideType;

private _spawnedAircraftArray = [_spawnPosition, _spawnPosition getDir _lzPos, _aircraftClassname, _aircraftSide] call BIS_fnc_spawnVehicle;

_spawnedAircraftArray params ["_aircraft", "_aircraftCrew", "_aircraftGroup"];

[[_aircraft]] call Ares_fnc_AddUnitsToCurator;

private _aircraftDriver = driver _aircraft;

_aircraftDriver setSkill 1;
_aircraftGroup allowFleeing 0;

// spawn the cargo
private _cargoClassname = if (_cargoType == 0) then
{
	(uiNamespace getVariable "Achilles_var_supplyDrop_supplies") select _cargoCategoryId select _cargoVehicleId;
} else
{
	(uiNamespace getVariable "Achilles_var_supplyDrop_cargoVehicles") select _cargoSideId select _cargoFactionId select _cargoCategoryId select _cargoVehicleId;
};
private _cargo = _cargoClassname createVehicle _spawnPosition;
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

#include "\achilles\modules_f_ares\module_footer.h"
