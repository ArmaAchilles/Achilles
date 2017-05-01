#include "\achilles\modules_f_ares\module_header.hpp"

_center_pos = position _logic;

_dialogResult = 
[
	localize "STR_ADD_REMOVE_EDITABLE_OBJECTS",
	[
		[
			localize "STR_MODE", [localize "STR_ADD", localize "STR_REMOVE"]
		],
		[
			localize "STR_RANGE",[localize "STR_RADIUS",localize "STR_ALL_OBJECTS_IN_MISSION"]
		],
		[
			localize "STR_RADIUS","","50"
		],
		[
			localize "STR_TYPE",[localize "STR_ALL",localize "STR_UNITS",localize "STR_VEHICLE",localize "STR_STATIC_OBJECTS",localize "STR_GAME_LOGIC"]
		],
		[
			localize "STR_MODE",[localize "STR_ALL",localize "STR_SIDE"]
		],
		[
			localize "STR_SIDE","SIDE"
		]
	],
	"Achilles_fnc_RscDisplayAttributes_editableObjects"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_addObject = if ((_dialogResult select 0) == 0) then {true} else {false};
_range_mode = _dialogResult select 1;
_obj_type = _dialogResult select 3;

private _objectsToProcess = [];

if (_range_mode == 0) then
{
	_radius = parseNumber (_dialogResult select 2);
	_objectsToProcess = switch (_obj_type) do
	{
		case 0: {nearestObjects [_center_pos, [],_radius, true]};
		case 1: 
		{
			_units = nearestObjects [_center_pos, ["Man","LandVehicle","Air","Ship"], _radius, true];
			if (_dialogResult select 4 == 1) then
			{
				_side = [(_dialogResult select 5) - 1] call BIS_fnc_sideType;
				_units select {(side _x) isEqualTo _side and count crew _x > 0};
			} else
			{
				_units select {count crew _x > 0};
			};
		};
		case 2: {nearestObjects [_center_pos, ["LandVehicle","Air","Ship"], _radius, true]};
		case 3: {nearestObjects [_center_pos, ["Static"], _radius, true]};
		case 4: {nearestObjects [_center_pos, ["Logic"], _radius, true]};
	};
} else
{
	_objectsToProcess = switch (_obj_type) do
	{
		case 0: {allMissionObjects ""};
		case 1: 
		{
			_units = (allUnits + vehicles);
			if (_dialogResult select 4 == 1) then
			{
				_side = [(_dialogResult select 5) - 1] call BIS_fnc_sideType;
				_units select {(side _x) isEqualTo _side};
			} else
			{
				_units;
			};
		};
		case 2: {vehicles};
		case 3: {allMissionObjects "Static"};
		case 4: {allMissionObjects "Logic"};
	};	
};

// protect the main curator module from deletion
_objectsToProcess = _objectsToProcess select {typeOf _x != "ModuleCurator_F"};
[_objectsToProcess, _addObject] call Ares_fnc_AddUnitsToCurator;

_displayText = [localize "STR_ADD_OBJEKTE_TO_ZEUS", localize "STR_REMOVED_OBJEKTE_FROM_ZEUS"] select (_dialogResult select 0);
[objNull, format [_displayText, count _objectsToProcess]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
