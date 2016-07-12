/*
	This code runs the code block associated with a registered module.
*/

_moduleId = _this select 0;
_logic = _this select 1;
if (isNil "Ares_Custom_Modules") exitWith
{
	// No registered modules.
	["ExecuteCustomModuleCode: No custom modules registered."] call Ares_fnc_LogMessage;
};

if (count Ares_Custom_Modules <= _moduleId) exitWith
{
	// Not enough registered modules.
	["ExecuteCustomModuleCode: Module ID larger than number of custom modules."] call Ares_fnc_LogMessage;
};

_data = Ares_Custom_Modules select _moduleId;

if (isNil "_data") exitWith
{
	["ExecuteCustomModuleCode: Unable to get data for moduleId."] call Ares_fnc_LogMessage;
};

_categoryName = _data select 0;
_displayName = _data select 1;
_codeBlock = _data select 2;

[format ["ExecuteCustomModuleCode: Running code for '%1'->'%2'", _categoryName, _displayName]] call Ares_fnc_LogMessage;
_position = position _logic;
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
deleteVehicle _logic; // Delete the logic module before we actually execute the code in case the call fails.
[_position, _unitUnderCursor] call _codeBlock;
[format ["ExecuteCustomModuleCode: Done running code for '%1'->'%2'", _categoryName, _displayName]] call Ares_fnc_LogMessage;