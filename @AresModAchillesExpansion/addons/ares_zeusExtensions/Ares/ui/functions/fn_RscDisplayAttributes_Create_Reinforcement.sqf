#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define IDD_SPAWN_REINFORCEMENT				133798

#define IDC_SPAWN_REINFORCEMENT_SIDE 		20000
#define IDC_SPAWN_REINFORCEMENT_FACTION		20001
#define IDC_SPAWN_REINFORCEMENT_CATEGORY	20002
#define IDC_SPAWN_REINFORCEMENT_VEHICLE		20003
#define IDC_SPAWN_REINFORCEMENT_LZDZ		20005

#define CURATOR_IDCs [IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]

_VALID_CATEGORIES = [localize "STR_CHOPPERS", localize "STR_CARS", localize "STR_APCS", localize "STR_TANKS", localize "STR_SHIPS"];

disableSerialization;
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_dialog = findDisplay IDD_SPAWN_REINFORCEMENT;

_mode = _this select 0;
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

switch (_mode) do
{
	case "LOADED":
	{
		["Side",controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "Side":
	{
		_idc = CURATOR_IDCs select _comboIndex;
		_tree_ctrl = _display displayCtrl _idc;
		_dialog setVariable ["side_ctrl",_tree_ctrl];
		
		_faction_names = [];
		_faction_paths = [];
		for "_i" from 0 to ((_tree_ctrl tvCount []) - 1)	do
		{
			_faction_names pushBack (_tree_ctrl tvText [_i]);
			_faction_paths pushBack [_i];
		};
		
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		
		_dialog setVariable ["faction_paths",_faction_paths];
		
		lbClear _faction_ctrl;
		{_faction_ctrl lbAdd _x} forEach _faction_names;
		_faction_ctrl lbSetCurSel 0;
		["Faction",controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "Faction":
	{
	
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		
		_faction_path = (_dialog getVariable "faction_paths") select _comboIndex;
		_tree_ctrl = _dialog getVariable "side_ctrl";
		
		_category_names = [];
		_category_paths = [];
		for "_i" from 0 to ((_tree_ctrl tvCount _faction_path) - 1)	do
		{
			_category_path = _faction_path + [_i];
			_category_name = _tree_ctrl tvText _category_path;
			if (_category_name in _VALID_CATEGORIES) then
			{
				_category_names pushBack _category_name;
				_category_paths pushBack _category_path;
			};
		};
		
		_dialog setVariable ["category_paths",_category_paths];
		
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		
		lbClear _category_ctrl;
		{_category_ctrl lbAdd _x} forEach _category_names;
		_category_ctrl lbSetCurSel 0;
		["Vehicle_Category",controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "Vehicle_Category":
	{
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		
		_category_path = (_dialog getVariable "category_paths") select _comboIndex;
		_tree_ctrl = _dialog getVariable "side_ctrl";
		
		_vehicle_names = [];
		_vehicle_classes = [];
		for "_i" from 0 to ((_tree_ctrl tvCount _category_path) - 1)	do
		{
			_vehicle_path = _category_path + [_i];
			_vehicle_class = _tree_ctrl tvData _vehicle_path;
			// only consider vehicles with enough cargo space
			_CrewTara = [_vehicle_class,false] call BIS_fnc_crewCount;
			_CrewBrutto =  [_vehicle_class,true] call BIS_fnc_crewCount;
			_CrewNetto = _CrewBrutto - _CrewTara;
			if (_CrewNetto >= 4) then 
			{
				_vehicle_names pushBack (_tree_ctrl tvText _vehicle_path);
				_vehicle_classes pushBack _vehicle_class;
			};
		};
		
		_dialog setVariable ["vehicle_classes",_vehicle_classes];
		
		_vehicle_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_VEHICLE;
		
		lbClear _vehicle_ctrl;
		if (count _vehicle_names == 0) then {_vehicle_ctrl lbAdd "empty list"} else {{_vehicle_ctrl lbAdd _x} forEach _vehicle_names;};
		_vehicle_ctrl lbSetCurSel 0;
		["Vehicle",controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "Vehicle":
	{
		Ares_var_reinforcement_vehicle_class = (_dialog getVariable "vehicle_classes") select _comboIndex;
	};
	case "Vehicle_Behaviour_(After_Drop)": {};
	case "Vehicle_LZ/DZ": {};
	case "Unit_RP": {};
	case "Unit_Behaviour": {};
	case "UNLOAD": {};
	default {systemChat "ERROR IN fn_RscDisplayAttributes_Spawn_Reinforcement.sqf"};
};