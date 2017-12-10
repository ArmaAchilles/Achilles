/*
	Author: CreepPork_LV

	Description:
		Uses a created helicopter that sling loads a Supply Crate which then is taken to the destination.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define SIDES [localize "STR_AMAE_BLUFOR", localize "STR_AMAE_OPFOR", localize "STR_AMAE_INDEPENDENT"]
#define AMMO_CRATES ["CargoNet_01_barrels_F", "CargoNet_01_box_F", "I_CargoNet_01_ammo_F", "O_CargoNet_01_ammo_F", "C_IDAP_CargoNet_01_supplies_F", "B_CargoNet_01_ammo_F"]

private _LZs = (call Achilles_fnc_getAllLZsAndRPs) select 0;
if (_LZs isEqualTo []) exitWith {[localize "STR_AMAE_NO_LZ"] call Achilles_fnc_showZeusErrorMessage};

private _pos = getPos _logic;

private _ammoCratesDisplayName = AMMO_CRATES apply {getText (configFile >> "CfgVehicles" >> _x >> "displayName")};

private _dialogResult =
[
	localize "STR_AMAE_SUPPLY_DROP",
	[
		[localize "STR_AMAE_SIDE", SIDES],
		[localize "STR_AMAE_FACTION", [localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_VEHICLE_CATEGORY", [localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_VEHICLE",[localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_VEHICLE_BEHAVIOUR", [localize "STR_AMAE_RTB_DESPAWN", localize "STR_AMAE_STAY_AT_LZ"]],
		[localize "STR_AMAE_LZ_DZ", (_LZs select 1)],
		[localize "STR_AMAE_AMMUNITION_CRATE_OR_VEHICLE", [localize "STR_AMAE_AMMUNITION_CRATE", localize "STR_AMAE_VEHICLE"]],
		[localize "STR_AMAE_AMMUNITION_CRATE", _ammoCratesDisplayName],
		[localize "STR_AMAE_CARGO_LW", [localize "STR_AMAE_DEFAULT", localize "STR_AMAE_EDIT_CARGO", localize "STR_AMAE_VIRTUAL_ARSENAL", localize "STR_AMAE_EMPTY"]],
		[localize "STR_AMAE_SIDE", SIDES],
		[localize "STR_AMAE_FACTION", [localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_VEHICLE_CATEGORY", [localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_VEHICLE",[localize "STR_AMAE_LOADING_"]]
	],
	"Achilles_fnc_RscDisplayAttributes_SupplyDrop"
] call Ares_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_",
	"_",
	"_",
	"_",
	"_aircraftBehaviour",
	"_LZ",
	"_cargoType",
	"_cargoBoxCrate",
	"_cargoBoxInventory",
	"_",
	"_",
	"_",
	"_cargoVehicle"
];

private _aircraftClassname = player getVariable ["Achilles_var_supplyDrop_module_vehicleClass", ""];
if (_aircraftClassname isEqualTo "") exitWith {[localize "STR_AMAE_AIRCRAFT_SPAWN_ERROR"] call Achilles_fnc_showZeusErrorMessage};

private _aircraftSide = player getVariable ["Achilles_var_supplyDrop_module_side", 0];

_aircraftSide = _aircraftSide call BIS_fnc_sideType;

private _spawnedAircraftArray = [_pos, (_pos getDir ((_LZs select 0) select _LZ)), _aircraftClassname, _aircraftSide] call BIS_fnc_spawnVehicle;

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
	private _cargoBoxClassname = AMMO_CRATES select _cargoBoxCrate;

	private _cargoBox = _cargoBoxClassname createVehicle _pos;

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
			["AmmoboxInit", [_cargoBox, true]] spawn BIS_fnc_Arsenal;
		};
		case 3:
		{
			clearItemCargoGlobal _cargoBox;
			clearWeaponCargoGlobal _cargoBox;
			clearBackpackCargoGlobal _cargoBox;
			clearMagazineCargoGlobal _cargoBox;
		};
	};
};

if (_cargoType == 1) then
{
	private _cargoClassname = player getVariable ["Achilles_var_supplyDrop_module_cargoVehicle", ""];
	if (_cargoClassname isEqualTo "") exitWith {[localize "STR_AMAE_CARGO_VEHICLE_SPAWN_ERROR!"] call Achilles_fnc_showZeusErrorMessage};

	private _cargo = _cargoClassname createVehicle _pos;

	[[_cargo]] call Ares_fnc_AddUnitsToCurator;

	if (_aircraft isKindOf "Helicopter") then
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

	if (_aircraft isKindOf "Plane") then
	{
		private _hasLoaded = _aircraft setVehicleCargo _cargo;
		if (!_hasLoaded) exitWith
		{
			[localize "STR_AMAE_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage;
			{deleteVehicle _x} forEach _aircraftCrew;
			deleteVehicle _aircraft;
			deleteVehicle _cargo;
		};
	};
};

private _LZWaypoint = _aircraftGroup addWaypoint [(getPos ((_LZs select 0) select _LZ)), 20];
_aircraftGroup setSpeedMode "FULL";

if (!((getVehicleCargo _aircraft) isEqualTo [])) then
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
