/*
	This code runs the code block associated with a registered module.
*/

params["_moduleId", "_logic"];

if (isNil "Ares_Custom_Modules") exitWith
{
	// No registered modules.
	["ExecuteCustomModuleCode: No custom modules registered."] call Achilles_fnc_logMessage;
};

if (count Ares_Custom_Modules <= _moduleId) exitWith
{
	// Not enough registered modules.
	["ExecuteCustomModuleCode: Module ID larger than number of custom modules."] call Achilles_fnc_logMessage;
};

private _data = Ares_Custom_Modules select _moduleId;

if (isNil "_data") exitWith
{
	["ExecuteCustomModuleCode: Unable to get data for moduleId."] call Achilles_fnc_logMessage;
};

_data params["_categoryName", "_displayName", "_codeBlock"];

[format ["ExecuteCustomModuleCode: Running code for '%1'->'%2'", _categoryName, _displayName]] call Achilles_fnc_logMessage;
private _position = position _logic;
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
deleteVehicle _logic; // Delete the logic module before we actually execute the code in case the call fails.
[_position, _unitUnderCursor] call _codeBlock;
[format ["ExecuteCustomModuleCode: Done running code for '%1'->'%2'", _categoryName, _displayName]] call Achilles_fnc_logMessage;
