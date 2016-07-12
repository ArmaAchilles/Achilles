////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/6/16
//	VERSION: 1.0
//	FILE: Ares\modules\DevTools\fn_DevTools_createAdvancedCompositions.sqf
//  DESCRIPTION: Function for module "create advanced composition"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\ares_zeusExtensions\Ares\module_header.hpp"

_center_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (isNull _center_object) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

_selected_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
if (isNil "_selected_objects") exitWith {};
if (count _selected_objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
	
_center_pos = getPosATL _center_object;
_dir = direction _center_object;
_type = typeOf _center_object;
_enableSimulation = _center_object getVariable ["enabledSimulation", true];
_composition_details = [[_type, [0,0,0], _dir, _enableSimulation]];

{
		_dir = direction _x;
		_type = typeOf _x;
		_pos_diff = (getPosATL _x) vectorDiff _center_pos;
		_enableSimulation = _x getVariable ["enabledSimulation", true];
		_composition_details pushBack [_type, _pos_diff, _dir, _enableSimulation];
} forEach (_selected_objects - [_center_object]);

_dialogResult = 
[
	localize "STR_ADVANCED_COMPOSITION",
	[
		[localize "STR_CATEGORY", [localize "STR_LOADING_"]],
		[localize "STR_NAME", "", "MyFirstComposition"]
	],
	"Ares_fnc_RscDisplayAttributes_createAdvancedComposition"
] call Ares_fnc_ShowChooseDialog;

_composition_name = (_dialogResult select 1);
_category_name = Ares_var_composition_category;

_custom_composition_list = profileNamespace getVariable ["Achilles_var_compositions",[]];

_category_name_list = _custom_composition_list apply {_x select 0};

_index = _category_name_list find _category_name;
if (_index == -1) then
{
	_custom_composition_list pushBack [_category_name, [_composition_name, _composition_details]];
	_custom_composition_list = [_custom_composition_list,[],{_x select 0}] call BIS_fnc_sortBy;
} else
{
	_category_details = _custom_composition_list select _index select 1;
	_category_details pushBack [_composition_name, _composition_details];
	_category_details = [_category_details,[],{_x select 0}] call BIS_fnc_sortBy;
	_custom_composition_list set [_index, [_category_name, _category_details]]
};
profileNamespace setVariable ["Achilles_var_compositions",_custom_composition_list];
saveProfileNamespace;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
