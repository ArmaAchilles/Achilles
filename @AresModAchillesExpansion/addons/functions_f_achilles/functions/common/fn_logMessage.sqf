/*
	Author: CreepPork_LV, Anton Struyk

	Description:
	 Logs a message to .rpt file and systemChat.

  Parameters:
    _this select: 0 - ANYTHING - Main message
		_this select: 1 - ANYTHING - (Optional) Extra tag, e.g. file name, sorting, etc.

  Returns:
    Nothing
*/

private _message = "";
private _fileName = "N/A";
_message = _this select 0;
_fileName = param[1, "N/A", [], []];

if (not (isNil "Achilles_Debug_Output_Enabled")) then
{
	if (Achilles_Debug_Output_Enabled) then
	{
		systemChat (format["[ACHILLES] [%1] %2", _fileName, _message]);
		diag_log format["[ACHILLES] [%1] %2", _fileName, _message];
	};
};
