#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

#define IDD_SPAWN_REINFORCEMENT				133798

#define IDC_SPAWN_REINFORCEMENT_SIDE 		20000
#define IDC_SPAWN_REINFORCEMENT_FACTION		20001
#define IDC_SPAWN_REINFORCEMENT_CATEGORY	20002
#define IDC_SPAWN_REINFORCEMENT_VEHICLE		20003
#define IDC_SPAWN_REINFORCEMENT_LZDZ		20005
#define IDC_SPAWN_REINFORCEMENT_GROUP		20006

#define CURATOR_IDCs 	[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER]

_VALID_CATEGORIES = [localize "STR_CHOPPERS", localize "STR_CARS", localize "STR_APCS", localize "STR_TANKS", localize "STR_SHIPS"];


/*
IDD_RSCDISPLAYCURATOR = 312;
 IDD_SPAWN_REINFORCEMENT			=	133798;
 IDC_SPAWN_REINFORCEMENT_SIDE 		=20000;
 IDC_SPAWN_REINFORCEMENT_FACTION	=	20001;
 IDC_SPAWN_REINFORCEMENT_CATEGORY	=20002;
 IDC_SPAWN_REINFORCEMENT_VEHICLE	=	20003;
 IDC_SPAWN_REINFORCEMENT_LZDZ		=20005;
 IDC_SPAWN_REINFORCEMENT_GROUP		=20006;
 CURATOR_IDCs = [271, 270, 272];
 _VALID_CATEGORIES = ["Helicopters","Cars","Tanks","APCs","Boats"];
*/
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
							// minimal cargo space == 2
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
		
		[((localize "STR_SIDE") call Achilles_fnc_TextToVariableName),controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case ((localize "STR_SIDE") call Achilles_fnc_TextToVariableName):
	{
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_avaiable_faction_names = _dialog getVariable ["factions",[]];
		if (count _avaiable_faction_names == 0) exitWith {};
		_current_factions = _avaiable_faction_names select _current_side;
		
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		lbClear _faction_ctrl;
		{_faction_ctrl lbAdd _x} forEach _current_factions;
		_faction_ctrl lbSetCurSel 0;
		
		[((localize "STR_FACTION") call Achilles_fnc_TextToVariableName),controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case ((localize "STR_FACTION") call Achilles_fnc_TextToVariableName):
	{
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_avaiable_vehicle_category_names = _dialog getVariable ["vehicle_categories",[]];
		if (count _avaiable_vehicle_category_names == 0) exitWith {};
		_current_categories = _avaiable_vehicle_category_names select _current_side select _current_faction;
		
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		lbClear _category_ctrl;
		{_category_ctrl lbAdd _x} forEach _current_categories;
		_category_ctrl lbSetCurSel 0;
		
		[((localize "STR_VEHICLE_CATEGORY") call Achilles_fnc_TextToVariableName),controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	
	
		_infantry_groups = _dialog getVariable ["infantry_groups",[]];
		if (count _infantry_groups == 0) exitWith {};
		_current_cfgGroups = _infantry_groups select _current_side select _current_faction;
		_current_GroupNames = [{getText (_this >> "name")},_current_cfgGroups] call Achilles_fnc_map;
		
		_group_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_GROUP;
		lbClear _group_ctrl;
		{_group_ctrl lbAdd _x} forEach _current_GroupNames;
		_group_ctrl lbSetCurSel 0;
		
		[((localize "STR_INFANTRY_GROUP") call Achilles_fnc_TextToVariableName),controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case ((localize "STR_VEHICLE_CATEGORY") call Achilles_fnc_TextToVariableName):
	{
		_category_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_CATEGORY;
		_current_category = lbCurSel _category_ctrl;
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
		_vehicle_ctrl lbSetCurSel 0;
		
		[((localize "STR_VEHICLE") call Achilles_fnc_TextToVariableName),controlNull,0] call Ares_fnc_RscDisplayAttributes_Create_Reinforcement;
	};
	case ((localize "STR_VEHICLE") call Achilles_fnc_TextToVariableName):
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
	};
	case ((localize "STR_INFANTRY_GROUP") call Achilles_fnc_TextToVariableName):
	{
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;
		
		_infantry_groups = _dialog getVariable ["infantry_groups",[]];
		if (count _infantry_groups == 0) exitWith {};
		Ares_var_reinforcement_infantry_group =  _infantry_groups select _current_side select _current_faction select _comboIndex;
	};
	default {};
};