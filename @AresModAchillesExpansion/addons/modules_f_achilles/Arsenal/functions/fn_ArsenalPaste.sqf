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

#include "\achilles\modules_f_ares\module_header.inc"

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
private _replace = (_dialogResult select 0) == 0;

uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", ""];
createDialog "Ares_CopyPaste_Dialog";

[
    {isNull ((findDisplay 123) displayCtrl 1000)}, 
    {
        params ["_object", "_replace"];

		private _dialogResult = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Result", -1];
		if (_dialogResult isEqualTo -1) exitWith {};

        private _dialogText = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Text", ""];

        // Security concern, but no other way to convert string to array.
        private _cargo = call compile _dialogText;

		if !(_cargo isEqualType []) exitWith {[localize "STR_AMAE_ARSENAL_FAILED_TO_PARSE"] call Achilles_fnc_ShowZeusErrorMessage};
		
		if (count (_cargo select 0) > 0 and {_cargo select 0 select 0 isEqualType []}) then
		{
			// if cargo contains virtual and standard inventory (- v0.0.9c and v1.0.2 - syntax)
			_cargo params ["_virtualCargo","_standardCargo"];
			[_object, _virtualCargo, _replace] call Achilles_fnc_updateVirtualArsenal;
			[_object, _standardCargo, _replace] call Achilles_fnc_updateStandardInventory;
		}
		else
		{
			// if cargo only contains virtual inventory (v1.0.0 - v1.0.1 syntax)
			[_object, _cargo, _replace] call Achilles_fnc_updateVirtualArsenal; 
		};
        [localize "STR_AMAE_INVENTORY_PASTED"] call Ares_fnc_ShowZeusMessage;
    },
    [_object, _replace]
] call CBA_fnc_waitUntilAndExecute;

#include "\achilles\modules_f_ares\module_footer.inc"