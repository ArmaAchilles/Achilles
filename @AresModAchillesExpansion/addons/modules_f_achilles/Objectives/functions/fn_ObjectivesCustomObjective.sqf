/*
	Author: CreepPork_LV

	Description:
		Reworked Custom Objective module to add support for module icons and extra features that are available in Eden.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

#define SIDES [west, east, independent]

_deleteModuleOnExit = false;

private _icons = [[], []]; // [["Display name"], ["Icon paths"]]

{
	private _displayName = getText (_x >> "displayName");
	private _iconPath = (_icons select 1) pushBack (getText (_x >> "icon"));

	if (_displayName isEqualTo "") then
	{
		_displayName = ((str _x) splitString "/\") select 3;
	};

	(_icons select 0) pushBack ([_displayName] call CBA_fnc_capitalize);
} forEach ("true" configClasses (configFile >> "CfgTaskTypes"));

private _dialogResult =
[
	"Create Custom Objective",
	[
		["COMBOBOX", "Side", ["West", "East", "Independent"]], // Side
		["COMBOBOX", "State", ["Assigned", "Created", "Completed", "Failed", "Canceled"]], // State
		["COMBOBOX", "Destination", ["Module position", "Disabled"]], // Destination (Show, Hide)
		["COMBOBOX", "Icon", (_icons select 0), 0, false, [], (_icons select 1)], // Icons
		["COMBOBOX", "Always Visible", ["Yes", "No"], 1], // Always Visible
		["COMBOBOX", "Show Notification", ["Yes", "No"], 1], // Show Notification
		["TEXT", "Task ID", [], ""], // Task ID
		["TEXT", "Parent Task ID", [], ""], // Parent Task ID
		["TEXT", "Title", [], ""], // Title
		["TEXT", "Waypoint name", [], ""], // Waypoint Name
		["MESSAGE", "Description", [], ""] // Description
	]
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_taskSide",
	"_taskState",
	"_taskDestination",
	"_taskIcon",
	"_taskVisibility",
	"_taskNotification",
	"_taskID",
	"_parentTaskID",
	"_taskTitle",
	"_taskWaypoint",
	"_taskDescription"
];

// TODO: Event handler if moved
// If selected Module Position
_taskDestination = if (_taskDestination isEqualTo 0) then
{
	[_object, getPos _logic] select (_object isEqualType objNull);
}
else
{
	objNull;
};

[
	SIDES select _taskSide,
	[_taskID, _parentTaskID],
	[_taskDescription, _taskTitle, _taskWaypoint],
	_taskDestination,
	_taskState,
	1,
	_taskNotification == 0,
	(_icons select 0) select _taskIcon,
	false
] call BIS_fnc_taskCreate;

#include "\achilles\modules_f_ares\module_footer.hpp"