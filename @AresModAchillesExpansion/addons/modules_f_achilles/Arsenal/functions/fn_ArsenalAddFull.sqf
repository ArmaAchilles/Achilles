/*
	Author:
		CreepPork_LV
	
	Description:
		Adds full Virtual Arsenal to any object.

	Parameters:
		None
	
	Returns:
		Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// If no object has been selected then prompt selection of multiple objects
private _objects = if (isNull _object) then
{
	[localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits;
}
else
{
	[_object];
};
if (isNil "_objects") exitWith {};

// Add Arsenal
{
	if (["arsenal"] call Achilles_fnc_isACELoaded) then
	{
		[_x, true] call ace_arsenal_fnc_removeBox;
		[_x, true, true] call ace_arsenal_fnc_initBox;
	};
	systemChat "AmmoboxInit";
	["AmmoboxInit", [_x, true]] spawn BIS_fnc_Arsenal;
} forEach _objects;

// Show message
[localize "STR_AMAE_ARSENAL_ADDED"] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"