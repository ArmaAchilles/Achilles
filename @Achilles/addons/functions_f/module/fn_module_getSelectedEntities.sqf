/*
	Function:
		Achilles_fnc_module_getSelectedEntities
	
	Authors:
		Kex
	
	Description:
		Returns the entity on which the module was placed.
		If the module was not placed on any
		The local variable _logic must be defined in the caller scope!
	
	Parameters:
		none
	
	Returns:
		none
	
	Exampes:
		(begin example)
		params ["_logic"];
		[] call Achilles_fnc_module_init;
		(end)
*/

// add event handlers
// note that curator event handlers are not set here and are calling the "handle"
_logic setVariable ["handle", _fnc_scriptNameParent];

_logic addEventHandler ["Deleted",
{
	params ["_logic"];
	["onModuleDeleted", [_logic]] call (_logic getVariable ["handle", {}]);
}];
