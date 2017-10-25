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

params [["_numberToParse", 0], ["_isInverted", false]]
private _return = "error";

if (_isInverted) then
{
	if (_numberToParse == 0) then
	{
		_return = true;
	}
	else
	{
		_return = false;
	};
}
else
{
	if (_numberToParse == 0) then
	{
		_return = false;
	}
	else
	{
		_return = true;
	};
};

_return;