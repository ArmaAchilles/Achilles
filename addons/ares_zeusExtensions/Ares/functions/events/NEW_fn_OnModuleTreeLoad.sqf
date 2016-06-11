/*
	Does magic to add custom items to a category in Zeus.
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_display","_ctrl","_category","_categoryName","_categoryMod","_subCategories","_leafData","_categoryData","_categoryBranches","_vanillaCategoryData","_vanillaCategoryBranches","_moduleClassList","_index","_custom"];

disableSerialization;

//Safety precaution, wait for the curator screen to be displayed
while {isNull (findDisplay IDD_RSCDISPLAYCURATOR)} do {
	sleep 1;
};

// Get function  arguments
_selection = param [0,""];

// Get the UI control
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Generate a structure holding the data for all the entries we need to add to the display.
_leafData = []; // An array of arrays with information on items in each category - [ ["CategoryName", "DisplayName", "ModuleClass", "icon"], ... ]

// Holding structure for vanilla categories
_vanillaCategoryData = [];
_vanillaCategoryBranches = [];

// The code is only executed when the whole tree is created and not on a selective update
if (_selection != "Custom Modules") then
{
	// Get all Vanilla Categories we want and delete the undesired ones
	
	private '_i';
	_i = 0;
	while {_i < (_ctrl tvCount [])} do
	{
		_categoryName = _ctrl tvText [_i];
		if (_categoryName in ["Animals","Chem lights","Effects","Flares","Smoke shells"]) then
		{
			_ctrl tvDelete [_i];
		} else
		{
			_vanillaCategoryData pushBack [_categoryName,false];
			_vanillaCategoryBranches pushBack [_i];
			_i = _i + 1;
		};
	};

	// Generate the leaf data for the modules defined as items in the mod.
	diag_log format ["Trace back: _ach_units = %1", (getArray (configFile >> "cfgPatches" >> "Achilles" >> "units"))];
	_all_units = (getArray (configFile >> "cfgPatches" >> "Ares" >> "units"));
	_all_units append (getArray (configFile >> "cfgPatches" >> "Achilles" >> "units"));
	{
		// Only add modules that define themselves in the "Ares" category
		_moduleCategory = gettext (configFile >> "CfgVehicles" >> _x >> "category");
		if(_moduleCategory == "Ares") then
		{
			_categoryName = gettext (configFile >> "CfgVehicles" >> _x >> "subCategory");
			_displayName = gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
			_className = _x;
			_icon = gettext (configFile >> "CfgVehicles" >> _x >> "icon");
			_leafData pushBack [_categoryName, _displayName, _className, _icon];
			diag_log format ["Trace back: _elementary_leaf = %1", [_categoryName, _displayName, _className, _icon]];
		};
	} forEach _all_units;
	diag_log format ["Trace back: _all_units = %1", _all_units];

};

diag_log format ["Trace back: _vanillaCategoryData = %1", _vanillaCategoryData];
diag_log format ["Trace back: _vanillaCategoryBranches = %1", _vanillaCategoryBranches];

// All leaves followed are user-dfined modules
_NonCustomLeafDataCount = count _leafData;

// Delete the user-defined modules if they are selectively updated
if (_selection == "Custom Modules") then 
{
	for "_i" from 0 to ((_ctrl tvCount []) - 1) step 1 do
	{
		_category = _ctrl tvText [_i];
		if (_category == "Custom Modules") exitWith {_ctrl tvDelete [_i];};
	};
	
};

// Process the user-defined modules and grab the display data for them.
if (not isNil "Ares_Custom_Modules") then
{
	{
		_categoryName = _x select 0;
		_displayName = _x select 1;
		_className = format ["Ares_Module_User_Defined_%1", _forEachIndex];
		_icon = "\ares_zeusExtensions\Achilles\data\icon_unit.paa";
		_leafData pushBack [_categoryName, _displayName, _className, _icon];
	} forEach Ares_Custom_Modules;
};

// Figure out the names of the categories we need to generate - and generate some data for them.
_categoryData = [];
{
	_categoryName = _x select 0;
	
	_isAlreadyInData = false;
	{
		if ((_x select 0) == _categoryName) exitWith { _isAlreadyInData = true; };
	} forEach (_categoryData + _vanillaCategoryData);
	
	if (not _isAlreadyInData) then
	{
		_custom = (_NonCustomLeafDataCount <= _forEachIndex);
		_categoryData pushBack [_categoryName,_custom];
	};
} forEach _leafData;

diag_log format ["Trace back: _categoryData = %1", _categoryData];
diag_log format ["Trace back: _leafData = %1", _leafData];

// Create parent of custom modules
_tvBranchCustom = [_ctrl tvAdd [[], "Custom Modules"]];
_ctrl tvSetData [_tvBranchCustom, "Ares_Module_Empty"];

diag_log format ["Trace back: _tvBranchCustom = %1", _tvBranchCustom];

// Create new categories and add them to the tree.
_categoryBranches = [];
{
	_tvText = _x select 0;
	_custom = _x select 1;
	_tvData = "Ares_Module_Empty"; // All of the categories use the 'Empty' module. There's no logic associated with them.
	_tvBranch = if (_custom) then {_tvBranchCustom+[_ctrl tvAdd [_tvBranchCustom, _tvText]]} else {[_ctrl tvAdd [[], _tvText]]};
	diag_log format ["Trace back cat: _tvBranch = %1", _tvBranch];
	_ctrl tvSetData [_tvBranch, _tvData];

	_categoryBranches pushBack _tvBranch;
} forEach _categoryData;

//After creating the new categories we merge vanilla and Ares since some modules are in a vanilla category
_combinedCategoryData = _vanillaCategoryData + _categoryData;
_combinedCategoryBranches = _vanillaCategoryBranches + _categoryBranches;

diag_log format ["Trace back after cat: _combinedCategoryData = %1", _combinedCategoryData];
diag_log format ["Trace back after cat: _combinedCategoryBranches = %1", _combinedCategoryBranches];
diag_log format ["Trace back after cat: _categoryBranches = %1", _categoryBranches];


//Add all of the leaf nodes into their correct categories
{
	//Get values from leaf data [["CategoryName", "DisplayName", "ModuleClass", "icon"], ...]
	_moduleSubCategory = _x select 0;
	_moduleDisplayName = _x select 1;
	_moduleClassName = _x select 2;
	_moduleIcon = _x select 3;

	// Serach for the branch we need to add this item to
	_tvModuleBranch = nil;
	{
		if(_moduleSubCategory == (_x select 0)) exitWith
		{
			// We assume that the _combinedCategoryBranches is a parallel array with the _combinedCategoryData array.
			_tvModuleBranch = _combinedCategoryBranches select _forEachIndex;
		};
	} forEach _combinedCategoryData;
	
	if (not isNil "_tvmodulebranch") then
	{
		//Create the new tree entry in the branch
		_leaf = [_ctrl tvAdd [_tvModuleBranch, _moduleDisplayName]];
		_newPath = _tvModuleBranch + _leaf;
		diag_log format ["Trace back leaf: _newPath = %1", _newPath];
		diag_log format ["Trace back leaf: _leaf = %1", _leaf];
		diag_log format ["Trace back leaf: _tvModuleBranch = %1", _tvModuleBranch];
		//Copy all of the data into it
		_ctrl tvSetData [_newPath, _moduleClassName];
		_ctrl tvSetPicture [_newPath, _moduleIcon];
		_ctrl tvSetValue [_newPath, _forEachIndex];
	};
} forEach _leafData;

//Sort the new categories
{
	_ctrl tvSort [_x, false];
} forEach _combinedCategoryBranches;

//Sort the base module list
_ctrl tvSort [[], false];