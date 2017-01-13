#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define IDD_SPAWN_REINFORCEMENT				133798

#define IDC_SPAWN_REINFORCEMENT_SIDE 		20000
#define IDC_SPAWN_REINFORCEMENT_FACTION		20001
#define IDC_SPAWN_REINFORCEMENT_CATEGORY	20002
#define IDC_SPAWN_REINFORCEMENT_VEHICLE		20003
#define IDC_SPAWN_REINFORCEMENT_LZDZ		20005
#define IDC_SPAWN_REINFORCEMENT_WP_TYPE_C	20006
#define IDC_SPAWN_REINFORCEMENT_WP_TYPE_L	10006
#define IDC_SPAWN_REINFORCEMENT_GROUP		20007

#define CURATOR_IDCs 	[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]

_VALID_CATEGORIES = [localize "STR_CHOPPERS", localize "STR_CARS", localize "STR_APCS", localize "STR_TANKS", localize "STR_SHIPS", localize "STR_PLANES", localize "STR_RHS_VEHCLASS_APC", localize "STR_RHS_VEHCLASS_IFV", localize "STR_RHS_VEHCLASS_TRUCK", localize "STR_RHS_VEHCLASS_CAR", localize "STR_RHS_VEHCLASS_TANK", localize "STR_RHS_VEHCLASS_AIRPLANE", localize "STR_RHS_VEHCLASS_HELICOPTER", localize "STR_RHSUSF_VEHCLASS_MRAP"];

disableSerialization;
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_dialog = findDisplay IDD_SPAWN_REINFORCEMENT;

private ["_mode", "_ctrl", "_comboIndex"];

_mode = _this select 0;
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

switch (_mode) do
{
	case "LOADED":
	{
		_avaiable_faction_names = [[],[],[]];
		_avaiable_faction_paths = [[],[],[]];
		{
			_idc = _x;
			_tree_ctrl = _display displayCtrl _idc;
			for "_i" from 0 to ((_tree_ctrl tvCount []) - 1)	do
			{
				_faction_name_list = _avaiable_faction_names select _forEachIndex;
				_faction_name_list pushBack (_tree_ctrl tvText [_i]);
				_avaiable_faction_names set [_forEachIndex, _faction_name_list];
				
				_faction_path_list = _avaiable_faction_paths select _forEachIndex;
				_faction_path_list pushBack [_i];
				_avaiable_faction_paths set [_forEachIndex, _faction_path_list];
			};
		} forEach CURATOR_IDCs;
	
		_CfgGroupsSides = 
		[
			([configfile >> "CfgGroups"] call BIS_fnc_getCfgSubClasses), 
			[], 
			{getNumber (configfile >> "CfgGroups" >> _x >> "side")},
			"ASCEND",
			{getNumber (configfile >> "CfgGroups" >> _x >> "side") <= 2}
		] call BIS_fnc_sortBy;
		
		_CfgFactionClasses =
		[
			([configfile >> "CfgFactionClasses"] call BIS_fnc_getCfgSubClasses),
			[],
			{getText (configfile >> "CfgFactionClasses" >> _x >> "displayName")},
			"ASCEND",
			{getNumber (configfile >> "CfgFactionClasses" >> _x >> "side") in [0,1,2]}
		] call BIS_fnc_sortBy;
		
		_infantry_groups = [[],[],[]];
		{
			_factionClass = _x;
			_side_index = getNumber (configfile >> "CfgFactionClasses" >> _factionClass >> "side");

			_factionName = getText (configfile >> "CfgFactionClasses" >> _factionClass >> "displayName");
			if (_factionName in (_avaiable_faction_names select _side_index)) then
			{
				_CfgGroupsSide = _CfgGroupsSides select _side_index;
				_infantry_criterion = if (_factionClass find "rhs" != -1) then {"aliveCategory"} else {"name"};
				_infantry = [];
				{
					if (getText (configfile >> "CfgGroups" >> _CfgGroupsSide >> _factionClass >> _x >> _infantry_criterion) == "Infantry" or configName (configfile >> "CfgGroups" >> _CfgGroupsSide >> _factionClass >> _x) == "Infantry") exitWith 
					{
						_infantry = ([configfile >> "CfgGroups" >> _CfgGroupsSide >> _factionClass >> _x] call BIS_fnc_returnChildren);
					};
				} forEach ([configfile >> "CfgGroups" >> _CfgGroupsSide >> _factionClass] call BIS_fnc_getCfgSubClasses);
				
				if (count _infantry > 0) then
				{
					_infantry_list = _infantry_groups select _side_index;
					_infantry_list pushBack _infantry;
					_infantry_groups set [_side_index, _infantry_list];	
				} else
				{
					_faction_name_list = _avaiable_faction_names select _side_index;
					_faction_index = _faction_name_list find _factionName;
					_faction_name_list = _faction_name_list - [_factionName];
					_avaiable_faction_names set [_side_index,_faction_name_list];
					
					_faction_path_list = _avaiable_faction_paths select _side_index;
					_faction_path_list = _faction_path_list - [_faction_path_list select _faction_index];
					_avaiable_faction_paths set [_side_index, _faction_path_list];
				};
			};
		} forEach _CfgFactionClasses;
		
		_avaiable_vehicle_category_names = [[],[],[]];
		_avaiable_vehicle_names = [[],[],[]];
		_avaiable_vehicle_classes = [[],[],[]];
		{
			_idc = _x;
			_side_index = _forEachIndex;
			_tree_ctrl = _display displayCtrl _idc;
			{
				_faction_path = _x;
				_faction_category_name = [];
				_faction_vehicle_names = [];
				_faction_vehicle_classes = [];
				
				for "_i" from 0 to ((_tree_ctrl tvCount _faction_path) - 1)	do
				{
					_category_path = _faction_path + [_i];
					_category_name = _tree_ctrl tvText _category_path;
					_vehicle_names = [];
					_vehicle_classes = [];
					if (_category_name in _VALID_CATEGORIES) then
					{
						for "_i" from 0 to ((_tree_ctrl tvCount _category_path) - 1)	do
						{
							_vehicle_path = _category_path + [_i];
							_vehicle_class = _tree_ctrl tvData _vehicle_path;
							_CrewTara = [_vehicle_class,false] call BIS_fnc_crewCount;
							_CrewBrutto =  [_vehicle_class,true] call BIS_fnc_crewCount;
							_CrewNetto = _CrewBrutto - _CrewTara;
							if (_CrewNetto >= 2) then 
							{
								_vehicle_names pushBack (_tree_ctrl tvText _vehicle_path);
								_vehicle_classes pushBack _vehicle_class;
							};
						};
					};
					if (count _vehicle_names > 0) then 
					{
						_faction_category_name pushBack _category_name;
						_faction_vehicle_names pushBack _vehicle_names;
						_faction_vehicle_classes pushBack _vehicle_classes;
					};
				};
				_vehicle_category_list = _avaiable_vehicle_category_names select _side_index;
				_vehicle_category_list pushBack _faction_category_name;
				_avaiable_vehicle_category_names set [_side_index, _vehicle_category_list];
			
				_vehicle_name_list = _avaiable_vehicle_names select _side_index;
				_vehicle_name_list pushBack _faction_vehicle_names;
				_avaiable_vehicle_names set [_side_index, _vehicle_name_list];
				
				_vehicle_class_list = _avaiable_vehicle_classes select _side_index;
				_vehicle_class_list pushBack _faction_vehicle_classes;
				_avaiable_vehicle_classes set [_side_index, _vehicle_class_list];				
			} forEach (_avaiable_faction_paths select _side_index);		
		} forEach CURATOR_IDCs;

		_dialog setVariable ["factions",_avaiable_faction_names];
		_dialog setVariable ["vehicle_categories",_avaiable_vehicle_category_names];
		_dialog setVariable ["vehicle_names",_avaiable_vehicle_names];
		_dialog setVariable ["vehicle_classes",_avaiable_vehicle_classes];
		_dialog setVariable ["infantry_groups",_infantry_groups];
		
		{
			_ctrl = _dialog displayCtrl (IDC_SPAWN_REINFORCEMENT_SIDE + _x);
			_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_last_choice = if (_last_choice < lbSize _ctrl) then {_last_choice} else {(lbSize _ctrl) - 1};
			_ctrl lbSetCurSel _last_choice;
			if (_x == 0) then
			{
				[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Create_Reinforcement;
			};
		} forEach [0,4,5,7,8,9];		
	};
	case "0":
	{
		_side_ctrl = _ctrl;
		_current_side = _comboIndex;
		
		_avaiable_faction_names = _dialog getVariable ["factions",[]];
		if (count _avaiable_faction_names == 0) exitWith {};
		_current_factions = _avaiable_faction_names select _current_side;
		
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		lbClear _faction_ctrl;
		{_faction_ctrl lbAdd _x} forEach _current_factions;
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = if (_last_choice < lbSize _faction_ctrl) then {_last_choice} else {(lbSize _faction_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_faction_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
		[1,_faction_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "1":
	{
		_faction_ctrl = _ctrl;
		_current_faction = _comboIndex;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_avaiable_vehicle_category_names = _dialog getVariable ["vehicle_categories",[]];
		if (count _avaiable_vehicle_category_names == 0) exitWith {};
		_current_categories = _avaiable_vehicle_category_names select _current_side select _current_faction;
		
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		lbClear _category_ctrl;
		{_category_ctrl lbAdd _x} forEach _current_categories;

		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_last_choice = if (_last_choice < lbSize _category_ctrl) then {_last_choice} else {(lbSize _category_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_category_ctrl lbSetCurSel _last_choice;
		
		[2,_category_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Create_Reinforcement;		
	
		_infantry_groups = _dialog getVariable ["infantry_groups",[]];
		if (count _infantry_groups == 0) exitWith {};
		_current_cfgGroups = _infantry_groups select _current_side select _current_faction;
		_current_GroupNames = _current_cfgGroups apply {getText (_x >> "name")};
		
		_group_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_GROUP;
		lbClear _group_ctrl;
		{_group_ctrl lbAdd _x} forEach _current_GroupNames;

		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_7", 0];
		_last_choice = if (_last_choice < lbSize _group_ctrl) then {_last_choice} else {(lbSize _group_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_group_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
		[7,_group_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "2":
	{
		_category_ctrl = _ctrl;
		_current_category = _comboIndex;
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_avaiable_vehicle_names = _dialog getVariable ["vehicle_names",[]];
		if (count _avaiable_vehicle_names == 0) exitWith {};
		_current_vehicles = _avaiable_vehicle_names select _current_side select _current_faction select _current_category;
		
		_vehicle_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_VEHICLE;
		lbClear _vehicle_ctrl;
		{_vehicle_ctrl lbAdd _x} forEach _current_vehicles;

		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", 0];
		_last_choice = if (_last_choice < lbSize _vehicle_ctrl) then {_last_choice} else {(lbSize _vehicle_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_vehicle_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_2", _comboIndex];
		[3,_vehicle_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case "3":
	{
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		_current_category = lbCurSel _category_ctrl;
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_avaiable_vehicle_classes = _dialog getVariable ["vehicle_classes",[]];
		if (count _avaiable_vehicle_classes == 0) exitWith {};
		Ares_var_reinforcement_vehicle_class = _avaiable_vehicle_classes select _current_side select _current_faction select _current_category select _comboIndex; 
		
		if (Ares_var_reinforcement_vehicle_class isKindOf "Air") then
		{

			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_C;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlEnable true;
			_ctrl ctrlCommit 0;

			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_L;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;
			
			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_C;
			_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_6", 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_last_choice = if (_last_choice < lbSize _ctrl) then {_last_choice} else {(lbSize _ctrl) - 1};
			_ctrl lbSetCurSel _last_choice;
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach [IDC_SPAWN_REINFORCEMENT_WP_TYPE_C,IDC_SPAWN_REINFORCEMENT_WP_TYPE_L];
		};
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_3", _comboIndex];
	};
	case "7":
	{
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_infantry_groups = _dialog getVariable ["infantry_groups",[]];
		if (count _infantry_groups == 0) exitWith {};
		Ares_var_reinforcement_infantry_group =  _infantry_groups select _current_side select _current_faction select _comboIndex;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_7", _comboIndex];
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};