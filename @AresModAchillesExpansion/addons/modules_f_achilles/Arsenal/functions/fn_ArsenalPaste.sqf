/*
    Author:
        CreepPork_LV
    
    Description:
        Shows dialog in which the Curator can paste cargo items into the box.

    Parameters:
        None
    
    Returns:
        Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

private _dialogResult = 
[
	localize "STR_AMAE_ARSENAL_PASTE",
	[
		[localize "STR_AMAE_ARSENAL_COMBINE_OR_REPLACE", [localize "STR_AMAE_ARSENAL_REPLACE", localize "STR_AMAE_ARSENAL_COMBINE"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_pasteMode"];

_pasteMode = _pasteMode == 0;

uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", ""];
createDialog "Ares_CopyPaste_Dialog";

[
    {isNull ((findDisplay 123) displayCtrl 1000)}, 
    {
        params ["_object", "_pasteMode"];

		private _dialogResult = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Result", -1];
		if (_dialogResult isEqualTo -1) exitWith {};

        private _dialogText = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Text", ""];

        // Security concern, but no other way to convert string to array.
        _dialogText = call compile _dialogText;

		if (_dialogText isEqualTo "" || !(_dialogText isEqualType [])) exitWith {[localize "STR_AMAE_ARSENAL_FAILED_TO_PARSE"] call Achilles_fnc_ShowZeusErrorMessage};
		
        if (["arsenal"] call Achilles_fnc_isACELoaded) then
        {
            [_object, _dialogText, _pasteMode] call Achilles_fnc_ArsenalSetupACE;
        }
        else
        {
		    [_object, _dialogText, _pasteMode] call Achilles_fnc_ArsenalSetup;
        };

        [localize "STR_AMAE_INVENTORY_PASTED"] call Ares_fnc_ShowZeusMessage;
    },
    [_object, _pasteMode]
] call CBA_fnc_waitUntilAndExecute;

#include "\achilles\modules_f_ares\module_footer.hpp"