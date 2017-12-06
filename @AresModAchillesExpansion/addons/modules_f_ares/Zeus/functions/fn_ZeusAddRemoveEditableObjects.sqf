#include "\achilles\modules_f_ares\module_header.hpp"

private _center_pos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_ADD_REMOVE_EDITABLE_OBJECTS",
	[
		[
			localize "STR_AMAE_MODE", [localize "STR_AMAE_ADD", localize "STR_AMAE_REMOVE"]
		],
		[
			localize "STR_AMAE_RANGE",[localize "STR_AMAE_RADIUS",localize "STR_AMAE_ALL_OBJECTS_IN_MISSION"]
		],
		[
			localize "STR_AMAE_RADIUS","","50"
		],
		[
			localize "STR_AMAE_TYPE",[localize "STR_AMAE_ALL",localize "STR_AMAE_UNITS",localize "STR_AMAE_VEHICLE",localize "STR_AMAE_STATIC_OBJECTS",localize "STR_AMAE_GAME_LOGIC"]
		],
		[
			localize "STR_AMAE_MODE",[localize "STR_AMAE_ALL",localize "STR_AMAE_SIDE"]
		],
		[
			localize "STR_AMAE_SIDE","SIDE"
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
		case 0: {_center_pos nearEntities _radius};
		case 1:
		{
			private _units = _center_pos nearEntities [["Man","LandVehicle","Air","Ship"], _radius];
			if (_dialogResult select 4 == 1) then
			{
				private _side = [(_dialogResult select 5) - 1] call BIS_fnc_sideType;
				_units select {(side _x) isEqualTo _side and count crew _x > 0};
			} else
			{
				_units select {count crew _x > 0};
			};
		};
		case 2: {_center_pos nearEntities [["LandVehicle","Air","Ship"], _radius]};
		case 3: {_center_pos nearEntities ["Static", _radius]};
		case 4: {_center_pos nearEntities ["Logic", _radius]};
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
	if (Achilles_Debug_Output_Enabled) then { true } else {
	(!(_type in ["logic", "modulehq_f", "modulemptypegamemaster_f", "land_helipadempty_f"]) and {(_type select [0,13]) != "modulecurator"}) /*and {{_object isKindOf _x} count ["Land_Carrier_01_hull_GEO_Base_F","Land_Carrier_01_hull_base_F","DynamicAirport_01_F"] == 0}*/
    };
};
[_objectsToProcess, _addObject] call Ares_fnc_AddUnitsToCurator;

private _addedObjects = 0;
private _allCuratorObjectsAfter = curatorEditableObjects (getAssignedCuratorLogic player);
if (_addObject) then
{
    //_addedObjects = count (_objectsToProcess select {(_x in _allCuratorObjectsAfter && !(_x in _allCuratorObjectsBefore)) && !isNull _x});
	if (!(_allCuratorObjectsBefore isEqualTo _allCuratorObjectsAfter)) then
	{
		_addedObjects = count (_allCuratorObjectsAfter - _allCuratorObjectsBefore);
	};
}
else
{
	if (!(_allCuratorObjectsBefore isEqualTo _allCuratorObjectsAfter)) then
	{
		_addedObjects = count (_allCuratorObjectsBefore - _allCuratorObjectsAfter);
	};
};

private _displayText = [localize "STR_AMAE_ADD_OBJEKTE_TO_ZEUS", localize "STR_AMAE_REMOVED_OBJEKTE_FROM_ZEUS"] select (_dialogResult select 0);
[objNull, format [_displayText, _addedObjects]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
