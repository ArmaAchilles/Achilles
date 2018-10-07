/*
    Author:
        CreepPork_LV
    
    Description:
        Removes Virtual Arsenal from any object.

    Parameters:
        None
    
    Returns:
        Nothing
*/

#include "\achilles\modules_f_ares\module_header.inc.sqf"

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

// Remove Arsenal
{
    if (["arsenal"] call Achilles_fnc_isACELoaded) then
    {
		[_x, true] call ace_arsenal_fnc_removeBox;
    };
	_x call BIS_fnc_removeVirtualWeaponCargo;
	_x call BIS_fnc_removeVirtualMagazineCargo;
	_x call BIS_fnc_removeVirtualItemCargo;
	_x call BIS_fnc_removeVirtualBackpackCargo;
	["AmmoboxExit", [_x]] call BIS_fnc_arsenal;
} forEach _objects;

// Show message
[localize "STR_AMAE_ARSENAL_REMOVED"] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"