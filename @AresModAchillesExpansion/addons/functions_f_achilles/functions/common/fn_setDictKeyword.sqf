////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 10/4/16
//	VERSION: 1.0
//	FILE: functions_f_achilles\functions\common\functions\fn_setDict.sqf
//  DESCRIPTION: Creates or adds an element to a dict
//
//	ARGUMENTS:
//	_this select 0:		STRING		- dict name
//  _this select 1:		ARRAY		- array of strings in order ["category","subcategory",...]
//  _this select 2:		ANYTHING	- object that is added to the dict
//
//	RETURNS:
//	_this:				ARRAY		- array in dict format
//
//	Example:
//	[_myDict, ["category1","subcategory1"]], 2] call Achilles_fnc_findInDict;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//WARNING: Needs checking of variable _nested_categories!

private ["_input_array","_indice_array","_element","_output_array"];

private _input_dict 		= param [0,[],[[]]];
private _path_by_categories	= param [1,[],[[]]];
_element 			= param [2,nil,[]];

private _output_dict = [];

private _nested_categories = _path_by_categories;

if (count _input_dict == 0) then
{	// create a new dict
	
	// create category references
	for "_i" from 0 to ((count _path_by_categories) - 1) do
	{
		private _temp_ref = [_path_by_categories select _i];
		for "_j" from 1 to _i do
		{
			_temp_ref = [_temp_ref];
		};
		_output_dict pushBack _temp_ref;
	};
	// create element reference
	private _temp_ref = [_element];
	for "_i" from 1 to ((count _path_by_categories) - 1) do
	{
		_temp_ref = [_temp_ref];
	};
	_output_dict pushBack _temp_ref;
	
} else
{
	// modify existing dict
	
	// determine array index path for the new element and create non-existing categories
	private _path_by_index = [];
	for "_i" from 0 to ((count _path_by_categories) - 1) do
	{
		// get i'th list and unpack it to i'th level
		private _category_list = _input_dict select _i;
		{
			_category_list = _category_list select _x;
		} forEach _path_by_index;
		
		// find the i'th category given by input
		private _category = _nested_categories select _i;
		private _category_index = _category_list find _category;
		
		if (_category_index == -1) exitWith
		{
			// category does not exist => create a new category entry
			
			_category_index = _category_list pushBack _category;
			_path_by_index pushBack _category_index;
			
			for "_j" from (_i + 1) to ((count _path_by_categories) - 1) do
			{
				// get i'th list and unpack it to i'th level
				_category_list = _input_dict select _j;
				// keep track of the unpacking
				private _temp_ref = [[_j,_category_list]];
				{
					_category_list = _category_list select _x;
					_temp_ref pushBack [_x,_category_list];
				} forEach _path_by_index;
			};
		};
		_path_by_index pushBack _category_index;
	};
};




private _dict_storage = [] call compile format ["Achilles_var_dictStorage_%1;",_dictName];
if (isNil "_dict_storage") then
{
	reverse _nested_categories;
	private _temp_dict = [_nested_categories select 0, [_element]];
	for "_i" from 1 to ((count _nested_categories) - 1) do
	{
		_temp_dict = [_nested_categories select _i, _temp_dict];
	};
	private _dict = _temp_dict;
	
} else
{
	// unpack dict
	private _temp_dict = _dict_storage;
	private _nested_dicts = [_temp_dict];
	private _nested_indices = [];
	for "_i" from 0 to ((count _nested_categories) - 1) do
	{
		private _temp_level_categories = _temp_dict apply {_x select 0};
		private _temp_category = _nested_categories select _i;
		private _temp_category_index = _temp_level_categories find _temp_category;
		if (_temp_category_index == -1) then
		{
			_temp_dict pushBack [_temp_category,[]];
			_nested_categories = _nested_categories select [_i + 1,(count _nested_categories) - _i - 1];
			reverse _nested_categories;		
		} else
		{
			_temp_dict = _temp_dict select _temp_category_index select 1;
			_nested_dicts pushBack _temp_dict
		};
		_nested_indices pushBack _temp_category_index;
	};
	
	// set element
	_temp_dict pushBack _element;
	
	// pack dict
	reverse _nested_dicts;
	reverse _nested_indices;
	for "_i" from 0 to ((count _nested_dicts) - 1) do
	{
		private _old_dict = _temp_dict;
		_temp_dict = _nested_dicts select _i;
		_temp_dict set [_nested_indices select _i, _old_dict];
	};
	private _dict = _temp_dict;
};
_dict call compile format ["Achilles_var_dictStorage_%1 = _this;",_dictName];
_dict;
