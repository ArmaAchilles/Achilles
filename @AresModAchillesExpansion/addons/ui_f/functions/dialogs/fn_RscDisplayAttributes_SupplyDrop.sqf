#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

/*
	Author: CreepPork_LV, Kex

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
#define IDC_SPAWN_SUPPLYDROP_CARGO_INVENTORY	20007
#define IDC_SPAWN_SUPPLYDROP_CARGO_SIDE 		20008
#define IDC_SPAWN_SUPPLYDROP_CARGO_FACTION		20009
#define IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY		20010
#define IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE_LABEL 10011
#define IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE		20011

#define CURATOR_IDCs 							[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]

disableSerialization;
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _dialog = findDisplay IDD_SPAWN_SUPPLYDROP;

params["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

switch (_mode) do
{
	case "LOADED":
	{
		{
			private _ctrl = _dialog displayCtrl _x;
			_ctrl lbSetCurSel lbCurSel _ctrl;
		} forEach [IDC_SPAWN_SUPPLYDROP_SIDE, IDC_SPAWN_SUPPLYDROP_CARGO_TYPE];
	};
	case "SIDE":
	{
		private _ctrlFaction = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_FACTION;

		lbClear _ctrlFaction;
		{
			_ctrlFaction lbAdd _x;
		} forEach (Achilles_var_supplyDrop_factions select _comboIndex);

		// Last choice
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_lastChoice = [(lbSize _ctrlFaction) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlFaction);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlFaction lbSetCurSel _lastChoice;
	};
	case "FACTION":
	{
		private _sideId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_SIDE);
		private _ctrlCategory = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CATEGORY;

		lbClear _ctrlCategory;
		{
			_ctrlCategory lbAdd _x;
		} forEach (Achilles_var_supplyDrop_categories select _sideId select _comboIndex);

		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_lastChoice = [(lbSize _ctrlCategory) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlCategory);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlCategory lbSetCurSel _lastChoice;
	};
	case "CATEGORY":
	{
		private _sideId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_SIDE);
		private _factionId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_FACTION);

		private _ctrlVehicle = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_VEHICLE;
		lbClear _ctrlVehicle;
		{
			_ctrlVehicle lbAdd getText (configFile >> "CfgVehicles" >> _x >> "displayName");
		} forEach (Achilles_var_supplyDrop_vehicles select _sideId select _factionId select _comboIndex);

		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", 0];
		_lastChoice = [(lbSize _ctrlVehicle) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlVehicle);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlVehicle lbSetCurSel _lastChoice;
	};
	case "CARGO_TYPE":
	{
		// Get all the cargo box controls.
		private _cargoBoxInventoryCtrl = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_INVENTORY;

		// Get all the cargo vehicle controls.
		private _cargoVehicleSide = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE;
		private _cargoVehicleFaction = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION;
		private _ctrlCategory = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY;
		private _cargoVehicleVehicle = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE;
		private _ctrlCargoVehicleLabel = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE_LABEL;

		// If Ammo Crate was selected
		if (_comboIndex == 0) then
		{
			// Enable the cargo box controls.
			{
				_x ctrlSetFade 0;
				_x ctrlEnable true;
				_x ctrlCommit 0;
			} forEach [_cargoBoxInventoryCtrl];

			// Disable all the cargo vehicle controls.
			{
				_x ctrlSetFade 0.8;
				_x ctrlEnable false;
				_x ctrlCommit 0;
			} forEach [_cargoVehicleSide, _cargoVehicleFaction];

			_ctrlCargoVehicleLabel ctrlSetText (localize "STR_AMAE_AMMUNITION_CRATE");

			lbClear _ctrlCategory;
			{
				_ctrlCategory lbAdd _x;
			} forEach Achilles_var_supplyDrop_supplySubCategories;

			private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_10", 0];
			_lastChoice = [(lbSize _ctrlCategory) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlCategory);
			_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
			_ctrlCategory lbSetCurSel _lastChoice;
		};

		// If cargo vehicle was selected
		if (_comboIndex == 1) then
		{
			// Enable the cargo vehicle controls.
			{
				_x ctrlSetFade 0;
				_x ctrlEnable true;
				_x ctrlCommit 0;
			} forEach [_cargoVehicleSide, _cargoVehicleFaction];

			// Disable the cargo box controls.
			{
				_x ctrlSetFade 0.8;
				_x ctrlEnable false;
				_x ctrlCommit 0;
			} forEach [_cargoBoxInventoryCtrl];

			_ctrlCargoVehicleLabel ctrlSetText (localize "STR_AMAE_VEHICLE");
			_cargoVehicleSide lbSetCurSel lbCurSel _cargoVehicleSide;
		};
	};
	case "CARGO_SIDE":
	{
		private _ctrlFaction = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION;

		lbClear _ctrlFaction;
		{
			_ctrlFaction lbAdd _x;
		} forEach (Achilles_var_supplyDrop_cargoFactions select _comboIndex);

		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_9", 0];
		_lastChoice = [(lbSize _ctrlFaction) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlFaction);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlFaction lbSetCurSel _lastChoice;
	};
	case "CARGO_FACTION":
	{
		private _ctrlSide = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE;
		private _sideId = lbCurSel _ctrlSide;
		private _ctrlCategory = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_CATEGORY;

		lbClear _ctrlCategory;
		{
			_ctrlCategory lbAdd _x;
		} forEach (Achilles_var_supplyDrop_cargoCategories select _sideId select _comboIndex);

		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_10", 0];
		_lastChoice = [(lbSize _ctrlCategory) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlCategory);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlCategory lbSetCurSel _lastChoice;
	};
	case "CARGO_CATEGORY":
	{
		private _sideId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_SIDE);
		private _factionId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_FACTION);
		private _typeId = lbCurSel (_dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_TYPE);

		private _ctrlVehicle = _dialog displayCtrl IDC_SPAWN_SUPPLYDROP_CARGO_VEHICLE;
		lbClear _ctrlVehicle;
		if (_typeId == 1) then
		{
			{
				_ctrlVehicle lbAdd getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			} forEach (Achilles_var_supplyDrop_cargoVehicles select _sideId select _factionId select _comboIndex);
		} else
		{
			{
				_ctrlVehicle lbAdd getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			} forEach (Achilles_var_supplyDrop_supplies select _comboIndex);
		};
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_11", 0];
		_lastChoice = [(lbSize _ctrlVehicle) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlVehicle);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlVehicle lbSetCurSel _lastChoice;
	};
};