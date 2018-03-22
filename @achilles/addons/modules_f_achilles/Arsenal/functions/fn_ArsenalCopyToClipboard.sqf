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

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

private _data = [_object, true] call Achilles_fnc_getVirtualArsenal;

if (isServer) then 
{
    copyToClipboard str _data;
    [localize "STR_AMAE_COPIED_ITEMS_TO_CLIPBOARD"] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", str _data];
createDialog "Ares_CopyPaste_Dialog";

#include "\achilles\modules_f_ares\module_footer.hpp"