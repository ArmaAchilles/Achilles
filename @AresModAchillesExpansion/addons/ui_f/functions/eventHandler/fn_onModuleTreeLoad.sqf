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
//	[] call Achilles_fnc_onModuleTreeLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;

// Get the UI control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _moduleTreeCtrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Get all existing module categories
private _categoryList = [];
for "_i" from 0 to ((_moduleTreeCtrl tvCount []) - 1) do
{
	_categoryList pushBack (_moduleTreeCtrl tvText [_i]);
};

// Add achilles modules
{
	private _moduleClass = _x;
	private _moduleCfg = configFile >> "cfgVehicles" >> _moduleClass;
	private _moduleName = getText (_moduleCfg >> "displayName");
	private _moduleIcon = getText (_moduleCfg >> "portrait");
	private _categoryClass = getText (_moduleCfg >> "category");
	private _categoryName = getText (configFile >> "CfgFactionClasses" >> _categoryClass >> "displayName");
	private _dlc = getText (_moduleCfg >> "dlc");
	private _addonIcon = getText (configFile >> "CfgMods" >> _dlc >> "logoSmall");
	_categoryList =
	[
		_moduleTreeCtrl,
		_categoryList,
		_categoryName,
		_moduleName,
		_moduleClass,
		0,
		_moduleIcon,
		_addonIcon
	] call Achilles_fnc_appendToModuleTree;
} forEach Achilles_var_availableModuleClasses;

// Add custom modules
if (!isNil "Ares_Custom_Modules") then
{
	{
		_x params
		[
			"_categoryName",
			"_moduleDisplayName"
		];
		private _moduleClassName = format ["Ares_Module_User_Defined_%1", _forEachIndex];

		_categoryList =
		[
			_moduleTreeCtrl,
			_categoryList,
			_categoryName,
			_moduleDisplayName,
			_moduleClassName
		] call Achilles_fnc_appendToModuleTree;
	} forEach Ares_Custom_Modules;
};

//Sort category and module list
_moduleTreeCtrl tvSort [[], false];
for "_i" from 0 to ((_moduleTreeCtrl tvCount []) - 1) do
{
	_moduleTreeCtrl tvSort [[_i], false];
};

// Set module category list for 
_categoryList sort true;
Ares_category_list = _categoryList;

// Create unit trees: Filter and collapse
if (count Achilles_var_excludedFactions > 0 or Achilles_var_moduleTreeCollapse) then
{
	{
		private _treeCtrl = _display displayCtrl _x;
		for "_i" from ((_treeCtrl tvCount []) - 1) to 0 step -1 do
		{
			private _path = [_i];
			private _factionName = _treeCtrl tvText _path;
			if (format ["%1%2", _factionName, _forEachIndex] in Achilles_var_excludedFactions) then
			{
				_treeCtrl tvDelete _path;
			}
			else
			{
				if (Achilles_var_moduleTreeCollapse) then
				{
					_treeCtrl tvCollapse _path;
				};
			};
		};
	} forEach
	[
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV
	];
};

// Create empty unit tree: Collapse
if (Achilles_var_moduleTreeCollapse) then
{
	{
		private _treeCtrl = _display displayCtrl _x;
		for "_i" from 0 to ((_treeCtrl tvCount []) - 1) do
		{
			_treeCtrl tvCollapse [_i];
		};
	} forEach
	[
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
	];
};

// Create group trees: Filter and collapse
{
	private _treeCtrl = _display displayCtrl _x;
	for "_i" from ((_treeCtrl tvCount [0]) - 1) to 0 step -1 do
	{
		private _path = [0,_i];
		private _factionName = _treeCtrl tvText _path;
		if (format ["%1%2", _factionName, _forEachIndex] in Achilles_var_excludedFactions) then
		{
			_treeCtrl tvDelete _path;
		}
		else
		{
			_treeCtrl tvCollapse _path;
		};
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER
];

// Create CIV and empty groups: Collapse
{
	private _treeCtrl = _display displayCtrl _x;
	for "_i" from 0 to ((_treeCtrl tvCount [0]) - 1) do
	{
		_treeCtrl tvCollapse [0,_i];
	};
} forEach
[
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV,
	IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY
];

// Add DLC icons to empty objects to remind player which he can place for non-apex users.
if (Achilles_var_moduleTreeDLC) then
{
	private _treeCtrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
	for "_i" from 0 to ((_treeCtrl tvCount []) - 1) do
	{
		for "_j" from 0 to ((_treeCtrl tvCount [_i]) - 1) do
		{
			for "_k" from 0 to ((_treeCtrl tvCount [_i,_j]) - 1) do
			{
				private _path = [_i,_j,_k];
				private _moduleClassName = _treeCtrl tvData _path;
				private _dlc = [(configFile >> "CfgVehicles" >> _moduleClassName), "dlc", ""] call BIS_fnc_returnConfigEntry;
				private _addonIcon = [(configFile >> "CfgMods" >> _dlc), "logoSmall", ""] call BIS_fnc_returnConfigEntry;
				if (_addonIcon != "") then
				{
					_treeCtrl tvSetPictureRight [_path, _addonIcon];
				};
			};
		};
	};
};

// Asset previews for objects
[_display] spawn
{
	params ["_display"];
	{
		private _treeCtrl = _display displayCtrl _x;

		// Loop through tree levels - e.g. NATO
		for "_i" from 0 to ((_treeCtrl tvCount [0]) - 1) do
		{
			// e.g. Men
			for "_j" from 0 to ((_treeCtrl tvCount [_i]) - 1) do
			{
				// e.g. Rifleman
				for "_k" from 0 to ((_treeCtrl tvCount [_i, _j]) - 1) do
				{
					private _path = [_i, _j, _k];

					private _objectClassName = _treeCtrl tvData _path;
					private _editorPreviewPath = [(configFile >> "CfgVehicles" >> _objectClassName), "editorPreview", ""] call BIS_fnc_returnConfigEntry;

					if (_editorPreviewPath != "") then
					{
						_treeCtrl tvSetPictureRight [_path, _editorPreviewPath];
					};
				};
			};
		};
	} forEach [
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
		IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
	];
};

/*private _editorPreviewCtrl = _display ctrlCreate ["RscPictureKeepAspect", -1];

{
	private _treeCtrl = _display displayCtrl _x;

	// TODO: Event handler always fails to attach
	private _someNumber = _treeCtrl ctrlAddEventHandler ["onTreeMouseHold", {
		params ["_ctrl"];

		private _objectClassName = _ctrl tvData [0,0,0];
		private _editorPreviewPath = [(configFile >> "CfgVehicles" >> _objectClassName), "editorPreview", ""] call BIS_fnc_returnConfigEntry;

		if (_editorPreviewPath != "") then
		{
			_editorPreviewCtrl ctrlSetText _editorPreviewPath;
		};
	}];

	diag_log _someNumber;
} forEach [
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
	IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
];*/
