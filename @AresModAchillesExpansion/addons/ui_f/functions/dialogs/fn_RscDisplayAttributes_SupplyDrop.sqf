#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

/*
	Author: CreepPork_LV

	Description:
		Controls the options for the Supply Drop module.

	Parameters:
    	_this select 0: - STRING  - In which phase is the dialog, loading, being closed, seperate dialog controls
		_this select 1: - CONTROL - The control that was used
		_this select 2: - SCALAR  - Tells what option was selected

	Returns:
    	Nothing
*/

#define IDD_SPAWN_SUPPLYDROP					133798

#define IDC_SPAWN_SUPPLYDROP_SIDE 				20000
#define IDC_SPAWN_SUPPLYDROP_FACTION			20001
#define IDC_SPAWN_SUPPLYDROP_CATEGORY			20002
#define IDC_SPAWN_SUPPLYDROP_VEHICLE			20003
#define IDC_SPAWN_SUPPLYDROP_BEHAVIOUR			20004
#define IDC_SPAWN_SUPPLYDROP_LZDZ				20005
#define IDC_SPAWN_SUPPLYDROP_CARGO_TYPE 		20006
#define IDC_SPAWN_SUPPLYDROP_CARGO_CRATE 		20007
#define IDC_SPAWN_SUPPLYDROP_CARGO_INVENTORY	20008
#define IDC_SPAWN_SUPPLYDROP_CARGO_SIDE 		20009
#define IDC_SPAWN_SUPPLYDROP_CARGO_FACTION		20010
#define IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY		20011
#define IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE		20012

#define CURATOR_IDCs 							[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]

// TODO: Changes the localization values to default A3 ones
#define VALID_CATEGORIES_HELICOPTERS 			[localize "STR_CHOPPERS", localize "STR_RHS_VEHCLASS_HELICOPTER"]
#define VALID_CATEGORIES_PLANES 				[localize "STR_PLANES", localize "STR_RHS_VEHCLASS_AIRPLANE"]
#define VALID_CARGO_CATEGORIES 					[localize "STR_CARS", localize "STR_APCS", localize "STR_SHIPS", localize "STR_RHS_VEHCLASS_APC", localize "STR_RHS_VEHCLASS_IFV", localize "STR_RHS_VEHCLASS_TRUCK", localize "STR_RHS_VEHCLASS_CAR", localize "STR_RHS_VEHCLASS_TANK", localize "STR_RHSUSF_VEHCLASS_MRAP"]

#define SIDES 									["East", "West", "Independent"]
#define CARGO_SIDES 							["East", "West", "Independent", "Civilian"]

disableSerialization;
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _dialog = findDisplay IDD_SPAWN_SUPPLYDROP;

params["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

switch (_mode) do
{
	//////////
	//
	// Name: LOADED
	//
	// Called: When the dialog is opened.
	//
	// Handles: Faction names, indexes, aircraft names, classnames and cargo information.
	//
	//////////
	case "LOADED":
	{
		//////////
		//
		// Faction names, indexes and aircraft names, classnames for Aircraft.
		//
		//////////

		// Faction names for each side (East, West, Indep)
		private _factions = [[], [], []];
		private _factionIndexes = [[], [], []];

		private _cargoFactions = [[], [], []];
		private _cargoFactionIndexes = [[], [], []];

		// All aircrafts available for each side (East, West, Indep)
		private _aircrafts = [[], [], []];
		private _aircraftClassnames = [[], [], []];

		private _cargoVehicles = [[], [], []];
		private _cargoVehicleClassnames = [[], [], []];

		// Get our factions from the Curator interface (this also removes any factions that are disallowed or disabled for the curator)
		{
			// The tree
			private _treeCtrl = _display displayCtrl _x;

			// Aircraft
			private _factionArray = _factions select _forEachIndex;
			private _factionIndexesArray = _factionIndexes select _forEachIndex;

			private _aircraftArray = _aircrafts select _forEachIndex;
			private _aircraftClassnamesArray = _aircraftClassnames select _forEachIndex;

			// Cargo
			private _cargoFactionArray = _cargoFactions select _forEachIndex;
			private _cargoFactionIndexesArray = _cargoFactionIndexes select _forEachIndex;

			private _cargoVehicleArray = _cargoVehicles select _forEachIndex;
			private _cargoVehicleClassnamesArray = _cargoVehicleClassnames select _forEachIndex;
			
			// Go through all factions (NATO, NATO (Pacific), FIA, etc.)
			for "_i" from 0 to (_treeCtrl tvCount []) do
			{
				// Add our faction array to the array
				private _arrayIndexForFaction = _aircraftArray pushBack [];
				private _arrayClassnameIndexForFaction = _aircraftClassnamesArray pushBack [];

				private _cargoIndexForFaction = _cargoVehicleArray pushBack [];
				private _cargoClassnameIndexForFaction = _cargoVehicleClassnamesArray pushBack [];

				// Go through all of the faction subcategories (Cars, Tanks, Planes, Helicopters, etc.)
				for "_y" from 0 to (_treeCtrl tvCount [_i]) do
				{
					private _parentValue = _treeCtrl tvText [_i];
					private _subValue = _treeCtrl tvText [_i, _y];

					private _hasHelicopters = _subValue in VALID_CATEGORIES_HELICOPTERS;
					private _hasPlanes = _subValue in VALID_CATEGORIES_PLANES;
					
					if (_hasHelicopters || _hasPlanes) then
					{
						// Add the faction only then when it's in the allowed catgories and if it is not already in the array (if one faction has Planes and Helicopters)
						if (!(_parentValue in _factionArray)) then
						{
							_factionArray pushBack _parentValue;
							_factionIndexesArray pushBack _i;
						};

						private _type = ["PLANE", "HELICOPTER"] select (_subValue in VALID_CATEGORIES_HELICOPTERS);

						// Create seperate arrays for each faction that contain helicopters OR planes.
						private _arrayIndexForType = (_aircraftArray select _arrayIndexForFaction) pushBack [_type];
						private _arrayClassnameIndexForType = (_aircraftClassnamesArray select _arrayClassnameIndexForFaction) pushBack [_type];
						
						// Loop through all the aircraft that are in the Planes or Helicopters category
						for "_z" from 0 to (_treeCtrl tvCount [_i, _y]) do
						{
							// Do not add if the name was an empty string (sometimes it returns it)
							if ((_treeCtrl tvText [_i, _y, _z]) != "") then 
							{
								((_aircraftArray select _arrayIndexForFaction) select _arrayIndexForType) pushBack (_treeCtrl tvText [_i, _y, _z]);
								((_aircraftClassnamesArray select _arrayClassnameIndexForFaction) select _arrayClassnameIndexForType) pushBack (_treeCtrl tvData [_i, _y, _z]);
							};
						};
					};

					// Cargo
					if (_subValue in VALID_CARGO_CATEGORIES) then
					{
						if (!(_parentValue in _cargoFactionArray)) then
						{
							_cargoFactionArray pushBack _parentValue;
							_cargoFactionIndexesArray pushBack _i;
						};

						// Create seperate arrays for each faction that contain helicopters OR planes.
						private _arrayIndexForType = (_cargoVehicleArray select _cargoIndexForFaction) pushBack [_treeCtrl tvText [_i, _y]];
						private _arrayClassnameIndexForType = (_cargoVehicleClassnamesArray select _cargoClassnameIndexForFaction) pushBack [_treeCtrl tvText [_i, _y]];
						
						// Loop through all the aircraft that are in the Planes or Helicopters category
						for "_z" from 0 to (_treeCtrl tvCount [_i, _y]) do
						{
							// Do not add if the name was an empty string (sometimes it returns it)
							if ((_treeCtrl tvText [_i, _y, _z]) != "") then 
							{
								((_cargoVehicleArray select _cargoIndexForFaction) select _arrayIndexForType) pushBack (_treeCtrl tvText [_i, _y, _z]);
								((_cargoVehicleClassnamesArray select _cargoClassnameIndexForFaction) select _arrayClassnameIndexForType) pushBack (_treeCtrl tvData [_i, _y, _z]);
							};
						};
					};
				};
			};
		} forEach CURATOR_IDCs;

		// Sets the info into variables
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_factionsArray", _factions];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_factionsIndexes", _factionIndexes];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_aircraftClassnames", _aircraftClassnames];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_aircraftNames", _aircrafts];

		// Cargo info
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsArray", _cargoFactions];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsIndexes", _cargoFactionIndexes];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleNames", _cargoVehicles];
		_dialog setVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleClassnames", _cargoVehicleClassnames];

		// Set defaults and call other modes.
		{
			private _ctrl = _dialog displayCtrl _x;
			private _lastDigit = parseNumber ((toString [_x]) select [4]);
			private _lastChoice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _lastDigit], 0];
			_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
			_ctrl lbSetCurSel _lastChoice;

			if (_lastDigit == 0 || _lastDigit == 6 || _lastDigit == 9) then
			{
				[_lastDigit, _ctrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
			}
			else
			{
				uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _lastDigit], _lastChoice];
			};
		} forEach 
		[
			IDC_SPAWN_SUPPLYDROP_SIDE,
			IDC_SPAWN_SUPPLYDROP_BEHAVIOUR,
			IDC_SPAWN_SUPPLYDROP_LZDZ,
			IDC_SPAWN_SUPPLYDROP_CARGO_TYPE,
			IDC_SPAWN_SUPPLYDROP_CARGO_CRATE,
			IDC_SPAWN_SUPPLYDROP_CARGO_INVENTORY,
			IDC_SPAWN_SUPPLYDROP_CARGO_SIDE
		];
	};
	//////////
	//
	// Name: 0 (Side)
	//
	// Called by: LOADED.
	//
	// Handles: Adding factions to 1.
	//
	//////////
	case "0":
	{
		// Get all factions
		private _factions = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_factionsArray", []];
		if (_factions isEqualTo []) exitWith {};

		// Get all factions from the selected side
		private _selectedFactions = _factions select _comboIndex;

		// Clear the faction list box from everything
		private _factionCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_FACTION;
		lbClear _factionCtrl;

		// Add all the factions to the list box
		{_factionCtrl lbAdd _x} forEach _selectedFactions;

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_factionCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
		[1, _factionCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 1 (Faction)
	//
	// Called by: Side control.
	//
	// Handles: Adding aircraft categories and filtering aircraft.
	//
	//////////
	case "1":
	{
		// Get the currently selected side
		private _currentSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_SIDE);

		// Get currently selected faction
		private _selectedFaction = lbCurSel _ctrl;

		// Get all current available categories for the selected side
		private _aircraftNames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_aircraftNames", []];
		if (_aircraftNames isEqualTo []) exitWith {};

		// Get the faction indexes
		private _factionIndexes = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_factionsIndexes", []];
		if (_factionIndexes isEqualTo []) exitwith {};

		private _factionIndex = (_factionIndexes select _currentSide) select _selectedFaction;

		// Get the aircraft from that side
		private _aircraftSide = _aircraftNames select _currentSide;

		// Get the aircraft from that side's faction
		private _aircraftFaction = _aircraftSide select _factionIndex;

		// Get all the aircraft classnames
		private _aircraftClassnames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_aircraftClassnames", []];
		if (_aircraftClassnames isEqualTo []) exitWith {};

		// Set our variables for classnames
		private _classnamesForHelicopters = [];
		private _classnamesForPlanes = [];

		// Add helicopters and planes to the two arrays
		private _helicopterArray = [];
		private _planesArray = [];
		if ((count _aircraftFaction) isEqualTo 2) then 
		{
			// If there are planes and factions for the faction then add them to their specific arrays.
			_helicopterArray = _aircraftFaction select 0;
			_planesArray = _aircraftFaction select 1;

			// Set the appropriate arrays to the correct classnames.
			_classnamesForHelicopters = ((_aircraftClassnames select _currentSide) select _factionIndex) select 0;
			_classnamesForPlanes = ((_aircraftClassnames select _currentSide) select _factionIndex) select 1;
		}
		else
		{
			// Get the only array available (we don't know if it's for the helicopters or planes).
			private _helicopterOrPlaneArray = _aircraftFaction select 0;

			// Get the only classname array
			private _classnameArray = ((_aircraftClassnames select _currentSide) select _factionIndex) select 0;

			// Get the type name ("HELICOPTER", "PLANES").
			private _typeName = _helicopterOrPlaneArray select 0;

			// Check if that array is for the helicopters
			private _hasHelicopters = [false, true] select (_typeName isEqualTo "HELICOPTER");

			if (_hasHelicopters) then
			{
				// If it was helicopters then set the _helicopterArray to the helicopters for its array.
				_helicopterArray = _helicopterOrPlaneArray;
				_classnamesForHelicopters = _classnameArray;
			}
			else
			{
				// Same as above but only for planes.
				_planesArray = _helicopterOrPlaneArray;
				_classnamesForPlanes = _classnameArray;
			};
		};

		private _aircraftForDeletion = [];

		if (!(_helicopterArray isEqualTo [])) then
		{
			// Get all the classnames for the available aircraft
			private _selectableAircraftClassnames = _classnamesForHelicopters select _comboIndex;

			// Loop through every helicopter that is available
			{
				if (_x != "HELICOPTER") then
				{
					// I went with find, because select could be unreliable due if the previous element had been deleted (using _forEachIndex).
					// This solution may be slower but produces accurate indexes.
					private _aircraftIndex = _helicopterArray find _x;

					// Just in case it didn't find it
					if (_aircraftIndex != -1) then
					{
						// Get the classname of this specific aircraft
						private _aircraftClassname = _classnamesForHelicopters select _aircraftIndex;

						// Get the max sling loadable mass on the helicopter
						private _slingLoadPoints = getNumber (configFile >> "CfgVehicles" >> _aircraftClassname >> "slingLoadMaxCargoMass");

						// If the there are no points for this helicopter, then remove it from the list.
						if (_slingLoadPoints == 0) then
						{
							private _type = _helicopterArray select 0;

							// Push the aircraft info to a seperate array where it will be deleted there.
							_aircraftForDeletion pushBack [_x, _aircraftClassname, _type];
						};
					};
				};
			} forEach _helicopterArray;
		};

		if (!(_planesArray isEqualTo [])) then
		{
			// Get all the classnames for the available aircraft
			private _selectableAircraftClassnames = _classnamesForPlanes select _comboIndex;

			// Loop through every plane that is available
			{
				// Do not loop if the element is the Plane type.
				if (_x != "PLANE") then
				{
					private _aircraftIndex = _planesArray find _x;

					if (_aircraftIndex != -1) then
					{
						// Get classname
						private _aircraftClassname = _classnamesForPlanes select _aircraftIndex;

						// Check if the vehicle-in-vehicle transport class exists for that plane
						private _hasViVTransport = isClass (configFile >> "CfgVehicles" >> _aircraftClassname >> "VehicleTransport");

						// If not then delete the aircraft from the list.
						if (!_hasViVTransport) then
						{
							private _type = _planesArray select 0;
							_aircraftForDeletion pushBack [_x, _aircraftClassname, _type];
						};
					};
				};
			} forEach _planesArray;
		};

		// Workaround for the forEach loop due to other forEaches skipping elements when one of them is deleted.
		{
			// Get the passed params
			_x params ["_name", "_classname", "_type"];

			if (_type == "HELICOPTER") then
			{
				// We need a index to be updated on each deletion as the index will change
				private _index = _helicopterArray find _name;

				// Delete the name and classname from the respective arrays
				_helicopterArray deleteAt _index;
				_classnamesForHelicopters deleteAt _index;
			}
			else
			{
				// We need a index to be updated on each deletion as the index will change
				private _index = _planesArray find _name;

				// Delete the name and classname from the respective arrays
				_planesArray deleteAt _index;
				_classnamesForPlanes deleteAt _index;
			};

		} forEach _aircraftForDeletion;

		// Clear out the list box
		private _categoryCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CATEGORY;
		lbClear _categoryCtrl;

		// If there are any helicopters then add helicopters category name to the list box
		if (!(_helicopterArray isEqualTo []) && (count _helicopterArray > 1)) then
		{
			if ((_helicopterArray select 0) isEqualTo "HELICOPTER") then
			{
				_categoryCtrl lbAdd (localize "STR_CHOPPERS");
			};
		};

		// If there are any planes then add planes category name to the list box
		if (!(_planesArray isEqualTo []) && (count _planesArray) > 1) then
		{
			if ((_planesArray select 0) isEqualTo "PLANE") then
			{
				_categoryCtrl lbAdd (localize "STR_PLANES");
			};
		};

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_categoryCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_2", _comboIndex];
		[2, _categoryCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 2 (Vehicle Category)
	//
	// Called by: Aircraft factions.
	//
	// Handles: Adding aircraft names.
	//
	//////////
	case "2":
	{
		// Get all the aircraft names
		private _aircraftNames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_aircraftNames", []];
		if (_aircraftNames isEqualTo []) exitWith {};

		// Get the faction indexes
		private _factionIndexes = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_factionsIndexes", []];
		if (_factionIndexes isEqualTo []) exitwith {};

		// Get the currently selected side and faction
		private _currentSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_SIDE);
		private _currentFaction = (_factionIndexes select _currentSide) select (lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_FACTION));

		// Get all the aircraft that are available from the filters
		private _selectableAircraft = ((_aircraftNames select _currentSide) select _currentFaction) select _comboIndex;

		// Get the type of the aircraft ("HELICOPTER", "PLANE")
		private _aircraftType = _selectableAircraft select 0;

		// Clear out the list box
		private _vehicleCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_VEHICLE;
		lbClear _vehicleCtrl;

		// Add all the available aircraft
		{
			if (_x != "HELICOPTER" && _x != "PLANE") then
			{
				_vehicleCtrl lbAdd _x;
			};
		} forEach _selectableAircraft;

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_vehicleCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_3", _comboIndex];
		[3, _vehicleCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 3 (Vehicle names)
	//
	// Called by: Vehicle category.
	//
	// Handles: Sets the classname to a variable and sets the vehicle behaviour.
	//
	//////////
	case "3":
	{
		// Get the selected side, faction and category.
		private _selectedSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_SIDE);
		private _selectedFaction = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_FACTION);
		private _selectedCategory = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CATEGORY);

		// Get all the aircraft classnames.
		private _aircraftClassnames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_aircraftClassnames", []];
		if (_aircraftClassnames isEqualTo []) exitWith {};

		// Get the selected aircraft classname.
		private _selectedAircraft = (((_aircraftClassnames select _selectedSide) select _selectedFaction) select _selectedCategory) select (_comboIndex + 1);

		// Set the classname to be used later in the module when spawning the aircraft.
		player setVariable ["Achilles_var_supplyDrop_module_vehicleClass", _selectedAircraft];

		// Get the vehicle behaviour control.
		private _vehicleBehaviourCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_BEHAVIOUR;

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_vehicleBehaviourCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_3", _comboIndex];
	};
	//////////
	//
	// Name: 6 (Ammo Crate or Vehicle)
	//
	// Called by: LOADED.
	//
	// Handles: Ammuntion crate controls.
	//
	//////////
	case "6":
	{
		// Get all the cargo box controls.
		private _cargoBoxAmmoCrateCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CRATE;
		private _cargoBoxInventoryCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_INVENTORY;

		// Get all the cargo vehicle controls.
		private _cargoVehicleSide = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE;
		private _cargoVehicleFaction = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION;
		private _cargoVehicleCategory = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY;
		private _cargoVehicleVehicle = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE;

		// If Ammo Crate was selected
		if (_comboIndex == 0) then
		{
			// Enable the cargo box controls.
			{
				_x ctrlSetFade 0;
				_x ctrlEnable true;
				_x ctrlCommit 0;
			} forEach [_cargoBoxAmmoCrateCtrl, _cargoBoxInventoryCtrl];

			// Disable all the cargo vehicle controls.
			{
				_x ctrlSetFade 0.8;
				_x ctrlEnable false;
				_x ctrlCommit 0;
			} forEach [_cargoVehicleSide, _cargoVehicleFaction, _cargoVehicleCategory, _cargoVehicleVehicle];
		};

		// If cargo vehicle was selected
		if (_comboIndex == 1) then
		{
			// Enable the cargo vehicle controls.
			{
				_x ctrlSetFade 0;
				_x ctrlEnable true;
				_x ctrlCommit 0;
			} forEach [_cargoVehicleSide, _cargoVehicleFaction, _cargoVehicleCategory, _cargoVehicleVehicle];

			// Disable the cargo box controls.
			{
				_x ctrlSetFade 0.8;
				_x ctrlEnable false;
				_x ctrlCommit 0;
			} forEach [_cargoBoxAmmoCrateCtrl, _cargoBoxInventoryCtrl];
		};

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_6", _comboIndex];
	};
	//////////
	//
	// Name: 9 (Cargo side)
	//
	// Called by: LOADED.
	//
	// Handles: Cargo faction.
	//
	//////////
	case "9":
	{
		// Get the cargo vehicle faction control.
		private _cargoVehicleFactionCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION;

		private _factionArray = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsArray", []];
		if (_factionArray isEqualTo []) exitWith {};

		private _selectedFactions = _factionArray select (lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE));

		// Clear out the list box and add the cargo factions.
		lbClear _cargoVehicleFactionCtrl;
		{_cargoVehicleFactionCtrl lbAdd _x} forEach _selectedFactions;

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_9", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_cargoVehicleFactionCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_10", _comboIndex];
		[10, _cargoVehicleFactionCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 10 (Cargo faction)
	//
	// Called by: Cargo side control.
	//
	// Handles: Cargo vehicle category.
	//
	//////////
	case "10":
	{
		// Get the cargo vehicle category control.
		private _cargoVehicleCategoryCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY;

		// Get cargo vehicle names.
		private _cargoVehicles = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleNames", []];
		if (_cargoVehicles isEqualTo []) exitWith {};

		// Get cargo vehicle classnames.
		private _cargoVehicleClassnames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleClassnames", []];
		if (_cargoVehicles isEqualTo []) exitWith {};

		// Get cargo faction indexes.
		private _factionIndexes = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsIndexes", []];
		if (_factionIndexes isEqualTo []) exitWith {};

		// Get selected faction and side.
		private _selectedSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE);
		private _selectedFaction = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION);

		// Get the correct faction.
		private _factionIndex = (_factionIndexes select _selectedSide) select _selectedFaction;

		// Get the available vehicle names and classnames.
		private _selectedVehicles = (_cargoVehicles select _selectedSide) select _factionIndex;
		private _selectedClassnames = (_cargoVehicleClassnames select _selectedSide) select _factionIndex;

		// Array to delete vehicles.
		private _vehiclesForDeletion = [];
		{
			// Get all the classnames for the vehicle types.
			private _classnames = _selectedClassnames select _forEachIndex;

			// Get type.
			private _type = _x select 0;
			{
				// Get the vehicle classname.
				private _classname = _classnames select _forEachIndex;

				// Do not check if the type is the name.
				if (_x != _type) then
				{
					// Check if the vehicle can be sling loaded.
					private _slingLoadingPoints = getArray (configFile >> "CfgVehicles" >> _classname >> "slingLoadCargoMemoryPoints");

					// If it returned nothing.
					if (_slingLoadingPoints isEqualTo []) then
					{
						// Mark the vehicle for deletion.
						_vehiclesForDeletion pushBack [_x, _classname];
					};
				};
			} forEach _x;
		} forEach _selectedVehicles;

		// Workaround for the same issue as the previous deletion method.
		{
			_x params ["_name", "_classname"];
			{
				private _index = _x find _name;
				
				_x deleteAt _index;
				(_selectedClassnames select _forEachIndex) deleteAt _index;
			} forEach _selectedVehicles;
		} forEach _vehiclesForDeletion;

		// Clear out the list box and add the category names.
		private _categoryIndexes = [];		
		lbClear _cargoVehicleCategoryCtrl;
		{
			private _vehicles = _x;
			private _index = _forEachIndex;
			private _type = _vehicles select 0;
			{
				// If something was left (not just the type name).
				if (_type == _x && (count _vehicles > 1)) then
				{
					// Add it.
					_cargoVehicleCategoryCtrl lbAdd _type;
					
					// Add indexes.
					_categoryIndexes pushBack _index;
				};
			} forEach _x;
		} forEach _selectedVehicles;

		// Set the indexes.
		_dialog setVariable ["Achilles_var_supplyDrop_dialog_cargo_categoryIndexes", _categoryIndexes];

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_10", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_cargoVehicleCategoryCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_11", _comboIndex];
		[11, _cargoVehicleCategoryCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 11 (Cargo vehicle category)
	//
	// Called by: Cargo faction control.
	//
	// Handles: Cargo vehicle.
	//
	//////////
	case "11":
	{
		// Get the cargo vehicle control.
		private _cargoVehicleCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE;

		// Get names, indexes for categories and factions.
		private _cargoVehicles = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleNames", []];
		if (_cargoVehicles isEqualTo []) exitWith {};

		private _factionIndexes = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsIndexes", []];
		if (_factionIndexes isEqualTo []) exitWith {};

		private _categoryIndexes = _dialog getVariable ["Achilles_var_supplyDrop_dialog_cargo_categoryIndexes", []];
		if (_categoryIndexes isEqualTo []) exitWith {};

		// Get the selected items.
		private _selectedSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE);
		private _selectedFaction = (_factionIndexes select _selectedSide) select (lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION));
		private _selectedCategory = _categoryIndexes select lbCurSel _ctrl;

		private _selectedVehicles = ((_cargoVehicles select _selectedSide) select _selectedFaction) select _selectedCategory;
		
		// Add the names.
		private _type = _selectedVehicles select 0;
		lbClear _cargoVehicleCtrl;
		{
			if (_x != _type) then
			{
				_cargoVehicleCtrl lbAdd _x;
			}
		} forEach _selectedVehicles;

		// Handle last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_11", 0];
		_lastChoice = [(lbSize _ctrl) - 1, _lastChoice] select (_lastChoice < (lbSize _ctrl));
		_cargoVehicleCtrl lbSetCurSel _lastChoice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_12", _comboIndex];
		[12, _cargoVehicleCtrl, _lastChoice] call Achilles_fnc_RscDisplayAttributes_SupplyDrop;
	};
	//////////
	//
	// Name: 12 (Cargo vehicle)
	//
	// Called by: Cargo vehicle category.
	//
	// Handles: Assigns cargo vehicle classname.
	//
	//////////
	case "12":
	{
		private _cargoVehicleClassnames = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_vehicleClassnames", []];
		if (_cargoVehicleClassnames isEqualTo []) exitWith {};

		private _factionIndexes = _dialog getVariable ["Achilles_var_SupplyDrop_dialog_cargo_factionsIndexes", []];
		if (_factionIndexes isEqualTo []) exitWith {};

		private _categoryIndexes = _dialog getVariable ["Achilles_var_supplyDrop_dialog_cargo_categoryIndexes", []];
		if (_categoryIndexes isEqualTo []) exitWith {};

		private _selectedSide = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE);
		private _selectedFaction = (_factionIndexes select _selectedSide) select (lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION));
		private _selectedCategory = _categoryIndexes select lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY);

		// Set the classname for the cargo vehicle to be accessible later in the module.
		private _selectedVehicle = (((_cargoVehicleClassnames select _selectedSide) select _selectedFaction) select _selectedCategory) select (_comboIndex + 1);

		player setVariable ["Achilles_var_supplyDrop_module_cargoVehicle", _selectedVehicle];

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_12", _comboIndex];
	};
	case "UNLOAD": {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};