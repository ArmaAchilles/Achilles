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
//	["myDict", ["category1","subcategory1"]], 2] call Achilles_fnc_findInDict; //returns [["category1",["subcategory1",[2]]]]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params[["_dict_name", "", [""]], ["_nested_categories", [], [[]]], "_element"];

private _dict = [];

private _dict_storage = [] call compile format ["Achilles_var_dictStorage_%1;",_dict_name];
if (isNil "_dict_storage") then
{
	reverse _nested_categories;
	private _temp_dict = [_nested_categories select 0, [_element]];
	for "_i" from 1 to ((count _nested_categories) - 1) do
	{
		_temp_dict = [_nested_categories select _i, _temp_dict];
	};
	_dict = _temp_dict;

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
	_dict = _temp_dict;
};
_dict call compile format ["Achilles_var_dictStorage_%1 = _this;",_dict_name];
_dict
