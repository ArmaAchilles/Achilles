/*
	Author: CreepPork_LV

	Description:
	 Converts a number to a boolean, if only the number is 0 or 1, else returns "error".

  Parameters:
    _this select: 0 - NUMBER - Number to parse

  Returns:
    BOOL - if successful ("error" string if is not successful)
*/

params [["_numberToParse", 0, [0]]];
private _return = "error";

_return = if (_numberToParse == 0) then {false};
_return = if (_numberToParse == 1) then {true};

_return;