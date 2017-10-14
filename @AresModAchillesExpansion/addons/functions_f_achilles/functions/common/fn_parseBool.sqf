/*
	Author: CreepPork_LV

	Description:
	 Converts a number to a boolean, if only the number is 0 or 1, else returns "error".

  Parameters:
    _this select: 0 - NUMBER - Vehicle it was activated on

  Returns:
    BOOL - if sucessful ("error" string if is not successful)
*/

private _numberToParse = _this select 0;
private _return = "error";

if (_numberToParse == 0) then
{
	_return = false;
};
if (_numberToParse == 1) then
{
	_return = true;
};

_return;