/*
	Function:
		Achilles_fnc_module_init
	
	Authors:
		Kex
	
	Description:
		A function for Zeus modules (called from the module code)
		Handles the module initialization.
		The local variable _logic must be defined in the caller scope!
		Sets the following variables in the _logic namespace
			#sel - <OBJECT> or <GROUP> or <ARRAY> of (<OBJECT> or <GROUP>) The selected entities
			#pos - <ARRAY> of <SCALAR> The position where _logic was placed
	
	Parameters:
		_expectedSelection	- <ARRAY> Tells what has to be selected; Empty if nothing has to be selected
			_selectionLabel			- <STRING> Localized text of what has to be selected (for selection option)
			_expectedType			- <STRING> The type that is expected to be selected (either "OBJECT" or "GROUP")
			_expectedParentClasses	- <ARRAY> of <STRING> with the parent class names of the expected selection
								This argument is not needed if _expectedType is "GROUP"
		_links				- <ARRAY> The modes that will be called next
			_onSuccess				- <STRING> The mode that is called on success
			_onFailed				- <STRING> The mode that is called on fail
			_onCanceled				- <STRING> The mode that is called on cancellation
		_hasSelectionOption	- <BOOL> [false] If true, then the selection option is used when the module is placed on nothing
		_doMultiSelect		- <BOOL> [false] If true, then #sel will return an array of entities instead of a single entity
	
	Returns:
		none
	
	Exampes:
		(begin example)
		params ["_logic"];
		// example 1: nothing to be select
		[] call Achilles_fnc_module_init;
		// example 2: select man and allow selection option with multi select.
		[[localize "STR_AMAE_UNIT", "OBJECT", ["Man"]], ["edit", "failed", "canceled"], true, true] call Achilles_fnc_module_init;
		// example 3: select a single car or tank
		[[localize "STR_AMAE_VEHICLE", "OBJECT", ["Car", "Tank"]], ["edit", "failed", "canceled"]] call Achilles_fnc_module_init;
		// example 4: select a single group and allow selection option
		[[localize "STR_AMAE_GROUP", "GROUP"], ["edit", "failed", "canceled"], true] call Achilles_fnc_module_init;
		(end)
*/

