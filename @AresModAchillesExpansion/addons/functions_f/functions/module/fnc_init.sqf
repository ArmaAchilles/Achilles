/*
	Function:
		Achilles_fnc_module_init
	
	Authors:
		Kex
	
	Description:
		A function for Zeus modules (called from the module code)
		Handles the module initialization.
		The local variable _logic and _params must be defined, where [_logic, _params] is the argument array of the module function, which is the caller scope!
		Sets the following variables in the _logic namespace
			#position	- <ARRAY> of <SCALAR> The position where _logic was placed
			#selection	- <OBJECT> or <GROUP> or <ARRAY> of (<OBJECT> or <GROUP>) The selected entities
			#attachedTo	- <OBJECT> The object to which the _logic is attached to.
		The function is smart in the way that if a module was place on a unit, but a group is expected, it will not print an error, but set #selection to the group of that unit.
	
	Parameters (with selection):
		_expectedSelection	- <ARRAY> Tells what has to be selected; Empty if nothing has to be selected
			_selectionLabel			- <STRING> Localized text of what has to be selected (for selection option)
			_expectedType			- <STRING> The type that is expected to be selected (either "OBJECT" or "GROUP")
			_expectedParentClasses	- <ARRAY> of <STRING> [[]] with the parent class names of the expected selection
										If set to [], then any class is valid
										For groups this criterion will only fail if none of the units have a valid class
			_excludePlayers			- <BOOL> [false] If true, players and groups with players are excluded
		_modes				- <ARRAY> The modes that will be called next
			_onSuccess				- <STRING> The mode that is called on success
			_onFailed				- <STRING> The mode that is called on fail
			_onCanceled				- <STRING> The mode that is called on cancellation
		_hasSelectionOption	- <BOOL> [false] If true, then the selection option is used when the module is placed on nothing
		_doMultiSelect		- <BOOL> [false] If true, then #selection will return an array of entities instead of a single entity
	
	Alternative Parameters (without selection):
		_nextMode			- <string> The mode that is called next
	
	Returns:
		none
	
	Exampes:
		(begin example)
		params ["_logic"];
		// example 1: nothing to be select
		["next"] call Achilles_fnc_module_init;
		// example 2: select man and allow selection option with multi select.
		[[localize "STR_AMAE_UNIT", "OBJECT", ["Man"]], ["edit", "failed", "canceled"], true, true] call Achilles_fnc_module_init;
		// example 3: select a single car or tank
		[[localize "STR_AMAE_VEHICLE", "OBJECT", ["Car", "Tank"]], ["edit", "failed", "canceled"]] call Achilles_fnc_module_init;
		// example 4: select a single group and allow selection option
		[[localize "STR_AMAE_GROUP", "GROUP", []], ["edit", "failed", "canceled"], true] call Achilles_fnc_module_init;
		(end)
*/

#include "\achilles\functions_f\includes\macros.inc.sqf"

// Set default values
_logic setVariable ["#position", getPos _logic];
_logic setVariable ["#selection", objNull];
_logic setVariable ["#attachedTo", _logic getVariable [QFUNC_BIS_1(curatorAttachObject,object), objNull]];

// Exit if nothing has to be selected
params ["_nextMode"];
if (_nextMode isEqualType "") exitWith
{
	[_nextMode, _params] call _fnc_scriptNameParent;
};
_nextMode = "";

// Get selection parameters
params
[
	["_expectedSelection", [], [[]]],
	["_modes", [], [[]]],
	["_hasSelectionOption", false, [false]],
	["_doMultiSelect", false, [false]]
];
_expectedSelection params
[
	["_selectionLabel", "", [""]],
	["_expectedType", "", [""]],
	["_expectedParentClasses", [], [[]]],
	["_excludePlayers", false, [false]]
];
_modes params
[
	["_onSuccess", "", [""]],
	["_onFailed", "", [""]],
	["_onCanceled", "", [""]]
];

// Get the entity on which the module was placed
private _mouseOver = _logic getVariable [QFUNC_BIS_1(curatorObjectPlaced,mouseOver), []];
_mouseOver params
[
	["", "", [""]],
	["_entity", objNull, [objNull, grpNull]]
];

// Return group if group is expected, but unit was selected
if ((_expectedType isEqualTo "GROUP") && {_entity isEqualType objNull}) then
{
	_entity = group _entity;
};

// Set selection 
_logic setVariable ["#selection", [_entity, [_entity]] select _doMultiSelect];


if (isNull _entity) then
{
	// If nothing was selected
	
	if !(_doMultiSelect) exitWith
	{
		// Error: Nothing selected and no selection option available
		_nextMode = _onFailed;
	};
	// Selection option
	[] call FUNC_ACHIL_1(module,selectionOption);
	// No next mode, since it's handled by the selection option
	_nextMode = "";
}
else
{
	// If something was selected
	
	if (_expectedType isEqualTo "OBJECT") then
	{
		if (_entity isEqualType grpNull) exitWith
		{
			// Error: Object was selected, but group is expected
			_nextMode = _onFailed;
		};
		if (_excludePlayers && {isPlayer _entity}) exitWith
		{
			// Error: Player was selected, but not expected
			_nextMode = _onFailed;
		};
		if (!(_expectedParentClasses isEqualTo []) && (_expectedParentClasses findIf {_entity isKindOf _x} isEqualTo -1)) exitWith
		{
			// Error: Wrong class was selected
			_nextMode = _onFailed;
		};
		_nextMode = _onSuccess;
	}
	else
	{
		private _units = units _entity;
		if (_units findIf {isPlayer _x} >= 0) exitWith
		{
			// Error: Player in group, but not expected
			_nextMode = _onFailed;
		};
		if (_units count {private _entity = _x; _expectedParentClasses findIf {(_entity isKindOf _x) || ((objectParent _entity) isKindOf _x)} isEqualTo 0}) exitWith
		{
			// Error: No valid class in group
			_nextMode = _onFailed;
		};
		_nextMode = _onSuccess;
	};
};

// Call the next mode
if !(_nextMode isEqualTo "") then
{
	[_nextMode, _params] call _fnc_scriptNameParent;
};
