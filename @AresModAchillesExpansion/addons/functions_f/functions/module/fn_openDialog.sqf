/*
	Function:
		Achilles_fnc_module_openDialog
	
	Authors:
		Kex
	
	Description:
		A function for Zeus modules (called from the module code)
		Opens a dynamic dialog that sets variables in the _logic namespace
		The local variable _logic must be defined in the caller scope!
	
	Parameters:
		_title 		- <STRING> Localized dialog title
		_controls 	- <ARRAY> The controls of the dialog
			_label 			- <STRING> Localized label for the control
			_variable		- <STRING> The variable to be set in the _logic namespace
			_type			- <STRING> Control type; These are defined below
			_params 		- <ARRAY> Additional control dependent parameters
			_default		- <SCALAR> or <STRING> or <ARRAY> [...] Default value
			_forceDefault 	- <BOOL> [true] If true, the default value is enforced
		_links 		- <ARRAY> The modes that will be called next
			_onConfirmed	- <STRING> The mode that is called on pressing ok
			_onCanceled		- <STRING> The mode that is called on pressing cancel
	
	Returns:
		none
	
	Exampes:
		(begin example)
		params ["_logic"];
		[
		] call Achilles_fnc_module_openDialog;
		(end)
*/

