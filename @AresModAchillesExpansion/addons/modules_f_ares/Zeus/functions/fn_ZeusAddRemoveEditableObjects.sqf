#include "\achilles\modules_f_ares\module_header.hpp"

private _center_pos = position _logic;

private _dialogResult =
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

if (_dialogResult isEqualTo []) exitWith {};
private _addObject = (_dialogResult select 0) == 0;
private _range_mode = _dialogResult select 1;
private _obj_type = _dialogResult select 3;

private _objectsToProcess = [];

if (_range_mode == 0) then
{
	private _radius = parseNumber (_dialogResult select 2);
	_objectsToProcess = switch (_obj_type) do
	{
		case 0: {nearestObjects [_center_pos, [],_radius, true]};
		case 1:
		{
			private _units = nearestObjects [_center_pos, ["Man","LandVehicle","Air","Ship"], _radius, true];
			if (_dialogResult select 4 == 1) then
			{
				private _side = [(_dialogResult select 5) - 1] call BIS_fnc_sideType;
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
			private _units = (allUnits + vehicles);
			if (_dialogResult select 4 == 1) then
			{
				private _side = [(_dialogResult select 5) - 1] call BIS_fnc_sideType;
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

private _allCuratorObjectsBefore = curatorEditableObjects (getAssignedCuratorLogic player);
// protect the main essential module from being added
_objectsToProcess = _objectsToProcess select
{
	private _object = _x;
	private _type = toLower typeOf _object;
	if (Achilles_Debug_Output_Enabled) exitWith	{ true;	};
	({_type == _x} count ["logic", "modulehq_f", "modulemptypegamemaster_f", "land_helipadempty_f"] == 0) and {(_type select [0,13]) != "modulecurator"} /*and {{_object isKindOf _x} count ["Land_Carrier_01_hull_GEO_Base_F","Land_Carrier_01_hull_base_F","DynamicAirport_01_F"] == 0}*/
};
[_objectsToProcess, _addObject] call Ares_fnc_AddUnitsToCurator;

private _addedObjects = 0;
private _allCuratorObjectsAfter = curatorEditableObjects (getAssignedCuratorLogic player);
if (_addObject) then
{
	{
        _addedObjects = _addedObjects + 1;
	} foreach (_objectsToProcess select {(_x in _allCuratorObjectsAfter && !(_x in _allCuratorObjectsBefore)) && !isNull _x});
}
else
{
	{
		_addedObjects = _addedObjects + 1;
	} foreach (_objectsToProcess select {(_x in _allCuratorObjectsBefore && !(_x in _allCuratorObjectsAfter)) && !isNull _x && _x != _logic});
};

private _displayText = [localize "STR_ADD_OBJEKTE_TO_ZEUS", localize "STR_REMOVED_OBJEKTE_FROM_ZEUS"] select (_dialogResult select 0);
[objNull, format [_displayText, _addedObjects]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
