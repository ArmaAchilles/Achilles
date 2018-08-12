/*
    Author:
        CreepPork_LV
    
    Description:
        Shows dialog that gives the abillity to copy Virtual Cargo and "real" items.

    Parameters:
        None
    
    Returns:
        Nothing
*/

#include "\achilles\modules_f_ares\module_header.h"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

private _virtualCargo = [_object, true] call Achilles_fnc_getVirtualArsenal;
private _standardCargo = 
[
	getitemcargo _object,
	getweaponcargo _object,
	getmagazinecargo _object,
	getbackpackcargo _object
];
private _data = [_virtualCargo, _standardCargo];

if (isServer) then 
{
    copyToClipboard str _data;
    [localize "STR_AMAE_COPIED_ITEMS_TO_CLIPBOARD"] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", str _data];
createDialog "Ares_CopyPaste_Dialog";

#include "\achilles\modules_f_ares\module_footer.h"