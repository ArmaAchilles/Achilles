////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 14/11/16
//	VERSION: 3.0
//	FILE: achilles\ui_f\functions\displayCurator\fn_OnModuleTreeLoad.sqf
//  DESCRIPTION: Integrates Ares Modules in Curator Interface Tree
//
//	ARGUMENTS:
//	_this select 0:		BOOL	- load custom modules only (true: append new custom module; false: load entire tree)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[false] call Achilles_fnc_OnModuleTreeLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#define ACHILLES_CATEGORIES [localize "STR_AMAE_BUILDINGS",localize "STR_AMAE_OBJECTS",localize "STR_AMAE_ARSENAL",localize "STR_AMAE_AI_BEHAVIOUR",localize "STR_AMAE_DEV_TOOLS",localize "STR_AMAE_EQUIPMENT",localize "STR_AMAE_PLAYERS",localize "STR_AMAE_REINFORCEMENTS",localize "STR_AMAE_SPAWN"]

disableSerialization;

// Get function  arguments
private _custom_only = param [0,false,[false]];

// Get the UI control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;


//prepare lists
private _category_list = [];
private _all_modules = (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_ares" >> "units"));
_all_modules append (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_achilles" >> "units"));

// Get all Vanilla Categories


for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	private _categoryName = _ctrl tvText [_i];
	if (Achilles_var_moduleTreeHelmet and (_categoryName in ACHILLES_CATEGORIES)) then
	{
		_ctrl tvSetPicture [[_i], "\achilles\data_f_achilles\icons\icon_achilles_small.paa"];
	};
	_category_list pushBack _categoryName;
};



// add dlc icons
for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	for "_j" from 0 to ((_ctrl tvCount [_i]) - 1) do
	{
		private _path = [_i,_j];
		private _moduleClassName = _ctrl tvData _path;
		if (Achilles_var_moduleTreeDLC) then
		{
			private _dlc = [(configFile >> "CfgVehicles" >> _moduleClassName), "dlc", ""] call BIS_fnc_returnConfigEntry;
			private _addonIcon = [(configFile >> "CfgMods" >> _dlc), "logoSmall", ""] call BIS_fnc_returnConfigEntry;
			if (_addonIcon != "") then
			{
				_ctrl tvSetPictureRight [_path, _addonIcon];
			};
		};
	};
};


// Add Custom modules
if (!isNil "Ares_Custom_Modules") then
{
	{
		private _categoryName = _x select 0;
		private _moduleDisplayName = _x select 1;
		private _moduleClassName = format ["Ares_Module_User_Defined_%1", _forEachIndex];

		_category_list = [_ctrl,_category_list,_categoryName,_moduleDisplayName,_moduleClassName,_forEachIndex] call Achilles_fnc_AppendToModuleTree;
	} forEach Ares_Custom_Modules;
};

//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};

//get module list
_category_list sort true;
Ares_category_list = _category_list;


/*
_tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;

//Add missing objects: Rocks

_categoryName = getText (configfile >> "CfgEditorCategories" >> "EdCat_Environment" >> "displayName");
_categoryIndex = _tree_ctrl tvAdd [[],_categoryName];
_subCategoryName = getText (configfile >> "CfgEditorSubcategories" >> "EdSubcat_Rocks" >> "displayName");
_subCategoryIndex = _tree_ctrl tvAdd [[_categoryIndex],_subCategoryName];
{
	_objectName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
	_objectIndex =  _tree_ctrl tvAdd [[_categoryIndex,_subCategoryIndex],_objectName];
	_tree_ctrl tvSetData [[_categoryIndex,_subCategoryIndex,_objectIndex],_x];
} forEach ((configfile >> "CfgVehicles" >> "Rocks_base_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass);
_tree_ctrl tvSort [[_categoryIndex,_subCategoryIndex],false];
_tree_ctrl tvSort [[],false];

//Add missing objects: Ruins
_categoryName = getText (configfile >> "CfgEditorCategories" >> "EdCat_Environment" >> "displayName");
_categoryIndex = _tree_ctrl tvAdd [[],_categoryName];

//{} forEach ((configfile >> "CfgVehicles" >> "Ruins_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass);
*/

//collapse unit tree or remove faction
if (count Achilles_var_excludedFactions > 0 or Achilles_var_moduleTreeCollapse) then
{
	{
		private _tree_ctrl = _display displayCtrl _x;
		for "_i" from ((_tree_ctrl tvCount []) - 1) to 0 step -1 do
		{
			private _path = [_i];
			private _faction_name = _tree_ctrl tvText _path;
			if (_faction_name in Achilles_var_excludedFactions) then
			{
				_tree_ctrl tvDelete _path;
			} else
			{
				if (Achilles_var_moduleTreeCollapse) then
				{
					_tree_ctrl tvCollapse _path;
				};
			};
		};
	} forEach
	[
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER
	];
};

//collapse unit trees
if (Achilles_var_moduleTreeCollapse) then
{
	{
		private _tree_ctrl = _display displayCtrl _x;
		for "_i" from 0 to ((_tree_ctrl tvCount []) - 1) do
		{
			_tree_ctrl tvCollapse [_i];
		};
	} forEach
	[
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
	];
};

//collapse group trees or remove faction
{
	private _tree_ctrl = _display displayCtrl _x;
	for "_i" from ((_tree_ctrl tvCount [0]) - 1) to 0 step -1 do
	{
		private _path = [0,_i];
		private _faction_name = _tree_ctrl tvText _path;
		if (_faction_name in Achilles_var_excludedFactions) then
		{
			_tree_ctrl tvDelete _path;
		} else
		{
			_tree_ctrl tvCollapse _path;
		};
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER
];

//collapse group trees
{
	private _tree_ctrl = _display displayCtrl _x;
	for "_i" from 0 to ((_tree_ctrl tvCount [0]) - 1) do
	{
		_tree_ctrl tvCollapse [0,_i];
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY
];

// Add DLC icons to empty objects to remind player which he can place for non-apex users.
if (Achilles_var_moduleTreeDLC) then
{
	private _tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
	for "_i" from 0 to ((_tree_ctrl tvCount []) - 1) do
	{
		for "_j" from 0 to ((_tree_ctrl tvCount [_i]) - 1) do
		{
			for "_k" from 0 to ((_tree_ctrl tvCount [_i,_j]) - 1) do
			{
				private _path = [_i,_j,_k];
				private _moduleClassName = _tree_ctrl tvData _path;
				private _dlc = [(configFile >> "CfgVehicles" >> _moduleClassName), "dlc", ""] call BIS_fnc_returnConfigEntry;
				private _addonIcon = [(configFile >> "CfgMods" >> _dlc), "logoSmall", ""] call BIS_fnc_returnConfigEntry;
				if (_addonIcon != "") then
				{
					_tree_ctrl tvSetPictureRight [_path, _addonIcon];
				};
			};
		};
	};
};
