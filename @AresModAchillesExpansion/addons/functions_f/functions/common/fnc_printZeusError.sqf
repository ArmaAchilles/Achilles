/*
	Function:
		Achilles_fnc_printZeusError
	
	Authors:
		Kex
	
	Description:
		Displays the error message in the top bar of the Zeus interface.
	
	Parameters:
		_message	- <STRING> or <ARRAY> The message as a string or a format array.
	
	Returns:
		none
	
	Exampes:
		(begin example)
		// <STRING> example
		["ERROR: NO PLAYERS FOUND!"] call Achilles_fnc_printZeusError;
		// <ARRAY> example
		[["ERROR: %1 IS NOT AN AI!", name player]] call Achilles_fnc_printZeusError;
		(end)
*/

#include "\achilles\functions_f\includes\macros.inc.sqf"

params
[
	["_message", "ERROR", ["",[]]]
];

[objNull, _message] call FUNC_BIS_0(showCuratorFeedbackMessage);
playSound "FD_Start_F";
