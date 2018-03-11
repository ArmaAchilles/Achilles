/*
	Author: CreepPork_LV

	Description:
		Reworked Custom Objective module to add support for module icons and extra features that are available in Eden.

	Parameters:
    	None

	Returns:
    	Nothing
*/

private _iconChoices = [];
private _iconPaths = [];

{
	private _displayName = getText (_x >> "displayName");
	private _iconPath = _iconPaths pushBack (getText (_x >> "icon"));

	if (_displayName isEqualTo "") then
	{
		_displayName = ((str _x) splitString "/\") select 3;
	};

	_iconChoices pushBack ([_displayName] call CBA_fnc_capitalize);
} forEach ("isClass _x" configClasses (configFile >> "CfgTaskTypes"));

private _dialogResult =
[
	"Create Custom Objective",
	[
		["COMBOBOX", "Side", ["West", "East", "Independent"]], // Side
		["COMBOBOX", "State", ["Assigned", "Created", "Completed", "Failed", "Canceled"]], // State
		["COMBOBOX", "Destination", ["Module position", "Disabled"]], // Destination (Show, Hide)
		["TEXT", "Task ID", [], ""], // Task ID
		["TEXT", "Parent Task ID", [], ""], // Parent Task ID
		["COMBOBOX", "Icon", _iconChoices, 0, false, [], _iconPaths], // Icons
		["COMBOBOX", "Always Visible", ["Yes", "No"], 1], // Always Visible
		["COMBOBOX", "Show Notification", ["Yes", "No"], 1], // Show Notification
		["TEXT", "Title", [], ""], // Title
		["TEXT", "Waypoint name", [], ""], // Waypoint Name
		["MESSAGE", "Description", [], ""] // Description
	]
] call Achilles_fnc_showChooseDialog;
