/*
	Author: CreepPork_LV

	Description:
	 Converts a number to a boolean, if only the number is 0 or 1, else returns "error".

  Parameters:
    _this select: 0 - NUMBER - Number to parse
	_this select: 1 - BOOL - Is order inverted (optional)

  Returns:
    BOOL - if sucessful ("error" string if is not successful)
*/

params [["_numberToParse", 0, [0]], ["_isInverted", false, [false]]]
private _return = "error";

if (_isInverted) then
{
	_return = _numberToParse == 0;
}
else
{
	_return = _numberToParse == 1;
};

_return;