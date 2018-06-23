#include "\achilles\modules_f_ares\module_header.hpp"

private _center_pos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_ADD_REMOVE_EDITABLE_OBJECTS",
	[
		[localize "STR_AMAE_MODE", [localize "STR_AMAE_ADD", localize "STR_AMAE_REMOVE"]],
		[localize "STR_AMAE_RANGE",[localize "STR_AMAE_RADIUS_NO_SI",localize "STR_AMAE_ALL_OBJECTS_IN_MISSION"]],
		[localize "STR_AMAE_RADIUS","","50"],
		[localize "STR_AMAE_TYPE",[localize "STR_AMAE_ALL",localize "STR_AMAE_UNITS",localize "STR_AMAE_VEHICLE",localize "STR_AMAE_STATIC_OBJECTS",localize "STR_AMAE_GAME_LOGIC"]],
		[localize "STR_AMAE_INCLUDE_SIMPLE_OBJECTS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
		[localize "STR_AMAE_SIDE",[localize "STR_AMAE_ALL",localize "STR_AMAE_SELECTION"]],
		[localize "STR_AMAE_SIDE","SIDE"]
	],
	"Achilles_fnc_RscDisplayAttributes_editableObjects"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_removeObjectNum", "_rangeMode", "_strRadius", "_objType", "_includeSimpleObjectsNum", "_sideMode", "_sideIdx"];
private _addObject = (_removeObjectNum == 0);
private _includeSimpleObjects = (_includeSimpleObjectsNum == 0);

private _objectsToProcess = [];

if (_rangeMode == 0) then
{
	private _radius = parseNumber _strRadius;
	_objectsToProcess = switch (_objType) do
	{
		case 0: {nearestObjects [_center_pos, [],_radius, true]};
		case 1:
		{
			private _units = nearestObjects [_center_pos, ["Man","LandVehicle","Air","Ship"], _radius, true];
			if (_sideMode == 1) then
			{
				private _side = [_sideIdx - 1] call BIS_fnc_sideType;
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
}
else
{
	_objectsToProcess = switch (_objType) do
	{
		case 0: {allMissionObjects ""};
		case 1:
		{
			private _units = (allUnits + vehicles);
			if (_sideMode == 1) then
			{
				private _side = [_sideIdx - 1] call BIS_fnc_sideType;
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

// protect the main essential module from being added
_objectsToProcess = _objectsToProcess select
{
	if (Achilles_Debug_Output_Enabled) then
	{
		true;
	}
	else
	{
		private _type = toLower typeOf _x;
		(!(_type in ["logic", "modulehq_f", "modulemptypegamemaster_f", "land_helipadempty_f", "ares_module_base", "achilles_module_base"]) && {(_type select [0,13]) != "modulecurator"}) /*&& {{_object isKindOf _x} count ["Land_Carrier_01_hull_GEO_Base_F","Land_Carrier_01_hull_base_F","DynamicAirport_01_F"] == 0}*/
    };
};

private _objectsModified = [_objectsToProcess, _addObject, _includeSimpleObjects] call Ares_fnc_AddUnitsToCurator;

[format [[localize "STR_AMAE_ADD_OBJEKTE_TO_ZEUS", localize "STR_AMAE_REMOVED_OBJEKTE_FROM_ZEUS"] select _removeObjectNum, _objectsModified]] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
