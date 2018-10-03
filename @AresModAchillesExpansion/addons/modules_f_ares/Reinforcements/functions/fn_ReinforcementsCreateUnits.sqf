#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#define CURATOR_UNITS_IDCs 						[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]
#define CURATOR_GROUPS_IDCs 					[IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER]

#define SIDES 									[east, west, independent]
#define SIDE_NAMES								[localize "STR_AMAE_OPFOR", localize "STR_AMAE_BLUFOR", localize "STR_AMAE_INDEPENDENT"]

#include "\achilles\modules_f_ares\module_header.inc.sqf"

disableSerialization;

private _spawnPosition = position _logic;

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
	private _curatorInterface = findDisplay IDD_RSCDISPLAYCURATOR;
	
	private _vehicleSides = SIDE_NAMES;
	private _vehicleFactions = [];
	private _groupFactions = [];
	private _vehicleCategories = [];
	private _vehicles = [];
	private _groups = [];

	for "_sideId" from 0 to (count SIDES - 1) do
	{
		// find vehicles
		private _treeCtrl = _curatorInterface displayCtrl (CURATOR_UNITS_IDCs select _sideId);
		_vehicleFactions pushBack [];
		_vehicleCategories pushBack [];
		_vehicles pushBack [];
		private _factionId = -1;
		for "_factionTvId" from 0 to ((_treeCtrl tvCount []) - 1) do
		{
			private _factionIncluded = false;
			private _faction = _treeCtrl tvText [_factionTvId];
			private _categoryId = -1;
			for "_categoryTvId" from 0 to ((_treeCtrl tvCount [_factionTvId]) - 1) do
			{
				private _categoryIncluded = false;
				private _category = _treeCtrl tvText [_factionTvId,_categoryTvId];
				private _first = true;
				for "_vehicleTvId" from 0 to ((_treeCtrl tvCount [_factionTvId,_categoryTvId]) - 1) do
				{
					private _vehicle = _treeCtrl tvData [_factionTvId,_categoryTvId,_vehicleTvId];
					if (_first and not (_vehicle isKindOf "Tank" or _vehicle isKindOf "Car" or _vehicle isKindOf "Helicopter" or _vehicle isKindOf "Plane"or _vehicle isKindOf "Ship")) exitWith {};
					if (([_vehicle, true] call BIS_fnc_crewCount) - ([_vehicle, false] call BIS_fnc_crewCount) > 0) then
					{
						if (not _factionIncluded) then
						{
							_factionIncluded = true;
							(_vehicleFactions select _sideId) pushBack _faction;
							_factionId = _factionId + 1;
							(_vehicleCategories select _sideId) pushBack [];
							(_vehicles select _sideId) pushBack [];
						};
						if (not _categoryIncluded) then
						{
							_categoryIncluded = true;
							(_vehicleCategories select _sideId select _factionId) pushBack _category;
							_categoryId = _categoryId + 1;
							(_vehicles select _sideId select _factionId) pushBack [];
						};
						(_vehicles select _sideId select _factionId select _categoryId) pushBack _vehicle;
					};
					_first = false;
				};
			};
		};
		
		// find groups
		private _treeCtrl = _curatorInterface displayCtrl (CURATOR_GROUPS_IDCs select _sideId);
		_groupFactions pushBack [];
		_groups pushBack [];
		private _sideClass = _treeCtrl tvData [0];
		for "_factionTvId" from 0 to ((_treeCtrl tvCount [0]) - 1) do
		{
			private _factionIncluded = false;
			private _factionName = _treeCtrl tvText [0,_factionTvId];
			private _factionClass = _treeCtrl tvData [0,_factionTvId];
			private _groupsInFaction = [];
			for "_categoryTvId" from 0 to ((_treeCtrl tvCount [0,_factionTvId]) - 1) do
			{
				private _categoryClass = _treeCtrl tvData [0,_factionTvId,_categoryTvId];
				for "_groupTvId" from 0 to ((_treeCtrl tvCount [0,_factionTvId,_categoryTvId]) - 1) do
				{
					private _groupName = _treeCtrl tvText [0,_factionTvId,_categoryTvId,_groupTvId];
					private _groupClass = _treeCtrl tvData [0,_factionTvId,_categoryTvId,_groupTvId];
					private _groupCfg = (configFile >> "CfgGroups" >> _sideClass >> _factionClass >> _categoryClass >> _groupClass);
					if ((_groupCfg call Achilles_fnc_returnChildren) findIf {not (getText (_x >> "vehicle") isKindOf "Man")} isEqualTo -1) then
					{
						if (not _factionIncluded) then
						{
							_factionIncluded = true;
							(_groupFactions select _sideId) pushBack _factionName;
						};
						_groupsInFaction pushBack _groupCfg;
					};
				};
			};
			if (_factionIncluded) then
			{
				_groupsInFaction = [_groupsInFaction, [], {getText (_x >> "Name")}] call BIS_fnc_sortBy;
				(_groups select _sideId) pushBack _groupsInFaction;
			};
		};
	};
	
	// remove side if it does not contain any factions
	for "_sideId" from (count SIDES - 1) to 0 step -1 do
	{
		if ((_vehicleFactions select _sideId) isEqualTo [] || {(_groupFactions select _sideId) isEqualTo []}) then
		{
			_vehicleSides deleteAt _sideId;
			_vehicleFactions deleteAt _sideId;
			_vehicleCategories deleteAt _sideId;
			_vehicles deleteAt _sideId;
			_groupFactions deleteAt _sideId;
			_groups deleteAt _sideId;
		};
	};
	
	// cache
	uiNamespace setVariable ["Achilles_var_nestedList_vehicleSides", _vehicleSides];
	uiNamespace setVariable ["Achilles_var_nestedList_vehicleFactions", _vehicleFactions];
	uiNamespace setVariable ["Achilles_var_nestedList_vehicleCategories", _vehicleCategories];
	uiNamespace setVariable ["Achilles_var_nestedList_vehicles", _vehicles];
	uiNamespace setVariable ["Achilles_var_nestedList_groupFactions", _groupFactions];
	uiNamespace setVariable ["Achilles_var_nestedList_groups", _groups];
};

private _vehicleSides = uiNamespace getVariable ["Achilles_var_nestedList_vehicleSides", []];
if (_vehicleSides isEqualTo []) exitWith {[localize "STR_AMAE_NO_VEHICLES_AVAILABLE__CHECK_FACTION_FILTER"] call Achilles_fnc_ShowZeusErrorMessage};

// Show the user the dialog
private _dialogResult =
[
	localize "STR_AMAE_SPAWN_UNITS",
	[
		["COMBOBOX", localize "STR_AMAE_SIDE", _vehicleSides, 0, false, [["LBSelChanged","SIDE"]]],
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
_dialogResult params ["_sideId","_vehicleFactionId","_vehicleCategoryId","_vehicleId","_vehicleBehaviour","_lzdzAlgorithm","_lzdzType","_groupFactionId","_groupId","_rpAlgorithm","_groupBehaviour"];
private _side = SIDES select _sideId;
private _vehicleType = (uiNamespace getVariable "Achilles_var_nestedList_vehicles") select _sideId select _vehicleFactionId select _vehicleCategoryId select _vehicleId;
private _grpCfg = (uiNamespace getVariable "Achilles_var_nestedList_groups") select _sideId select _groupFactionId select _groupId;
private _lzSize = 20;	// TODO make this a dialog parameter?
private _rpSize = 20;	// TODO make this a dialog parameters?

// Choose the LZ based on what the user indicated
private _lzLogic = [_spawnPosition, _allLzLogics, _lzdzAlgorithm] call Achilles_fnc_logicSelector;
private _lzPos = position _lzLogic;

// create the transport vehicle
private _vehicleInfo = [_spawnPosition, _spawnPosition getDir _lzPos, _vehicleType, _side] call BIS_fnc_spawnVehicle;
_vehicleInfo params ["_vehicle", "", "_vehicleGroup"];

if (_vehicle isKindOf "Plane") then
{
	// Adjust spawn and flight altitude
	private _height = [80, 3000] select (_lzdzType isEqualTo 3);
	_vehicle flyInHeight _height;
	_vehicle setPos (_spawnPosition vectorAdd [0, 0, _height]);
	
	// Fix for CUP planes (somehow they don't have a start velocity despite using BIS_fnc_spawnVehicle)
	private _speed = getNumber (configfile >> "CfgVehicles" >> _vehicleType >> "maxSpeed");
	private _coefName = ["normalSpeedForwardCoef", "limitedSpeedCoef"] select (speedMode _vehicleGroup == "LIMITED");
	_speed = _speed * getNumber (configfile >> "CfgVehicles" >> _vehicleType >> _coefName);
	_vehicle setVelocityModelSpace [0, _speed/3.6, 0];
};

// Add vehicle to curator
[[_vehicle]] call Ares_fnc_AddUnitsToCurator;

private _CrewTara = [_vehicleType,false] call BIS_fnc_crewCount;
private _CrewBrutto =  [_vehicleType,true] call BIS_fnc_crewCount;
private _CrewNetto = _CrewBrutto - _CrewTara;

// create infantry group and resize it to the given cargo space if needed
private _infantryGroup = [_spawnPosition, _side, _grpCfg] call BIS_fnc_spawnGroup;
// delete remaining units if vehicle is overcrouded
private _infantryList = units _infantryGroup;
if (count _infantryList > _CrewNetto) then
{
	_infantryList resize _CrewNetto;
	private _infantryToDelete = (units _infantryGroup) - _infantryList;
	{deleteVehicle _x} forEach _infantryToDelete;
};

switch (_groupBehaviour) do
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

private _rpLogic = [_lzPos, _allRpLogics, _rpAlgorithm] call Achilles_fnc_logicSelector;
private _rpPos = position _rpLogic;
_infantryGroup addWaypoint [_rpPos, _rpSize];

// Load the units into the vehicle.
{
	_x moveInCargo _vehicle;
} forEach _infantryList;

// Add infantry to curator
[(units _infantryGroup)] call Ares_fnc_AddUnitsToCurator;

if (_vehicle getVariable ["Achilles_var_noFastrope", false]) exitWith
{
	["ACE3 or AR is not loaded!"] call Achilles_fnc_showZeusErrorMessage;
	{deleteVehicle _x} forEach _infantryList;
};

// create a waypoint for deploying the units
private _vehicleUnloadWp = _vehicleGroup addWaypoint [_lzPos, _lzSize];
if (_vehicle isKindOf "Air" and (_lzdzType > 0)) then
{
	_vehicleUnloadWp setWaypointType "SCRIPTED";
	private _script =
	[
		"\achilles\functions_f_achilles\scripts\fn_wpParadrop.sqf",
		"\achilles\functions_f_achilles\scripts\fn_wpFastrope.sqf"
	] select (_lzdzType isEqualTo 1);
	_vehicleUnloadWp setWaypointScript _script;
} else
{
	_vehicleUnloadWp setWaypointType "TR UNLOAD";
};

// Make the driver full skill. This makes him less likely to do dumb things
// when they take contact.
(driver _vehicle) setSkill 1;

if (_vehicleType isKindOf "Air") then
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
if (_vehicleBehaviour == 0) then
{
	// RTB and despawn.
	private _vehicleReturnWp = _vehicleGroup addWaypoint [_spawnPosition, 0];
	_vehicleReturnWp setWaypointTimeout [2,2,2]; // Let the unit stop before being despawned.
	_vehicleReturnWp setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];
};

// print a confirmation
[localize "STR_AMAE_REINFORCEMENT_DISPATCHED"] call Ares_fnc_showZeusMessage;


#include "\achilles\modules_f_ares\module_footer.inc.sqf"
