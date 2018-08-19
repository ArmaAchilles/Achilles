/*
	Function:
		Achilles_fnc_printZeusMessage
	
	Authors:
		Kex
	
	Description:
		Displays the message in the top bar of the Zeus interface.
	
	Parameters:
		_message	- <STRING> or <ARRAY> The message as a string or a format array.
	
	Returns:
		none
	
	Exampes:
		(begin example)
		// <STRING> example
		["HELLO THERE!"] call Achilles_fnc_printZeusMessage;
		// <ARRAY> example
		[[GENERAL %1!", name player]] call Achilles_fnc_printZeusMessage;
		(end)
*/

params
[
	[_message, "", ["",[]]]
];

[objNull, _message] call BIS_fnc_showCuratorFeedbackMessage;
