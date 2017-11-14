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

params [["_message", "No Message", []], ["_fileName", "N/A", []]];

if (!(isNil "Achilles_Debug_Output_Enabled")) then
{
	if (Achilles_Debug_Output_Enabled) then
	{
		if (_fileName isEqualTo "N/A") then 
		{
			systemChat (format["[ACHILLES] %1", _message]);
			diag_log format["[ACHILLES] %1", _message];
		}
		else
		{
			systemChat (format["[ACHILLES] [%1] %2", _fileName, _message]);
			diag_log format["[ACHILLES] [%1] %2", _fileName, _message];
		};
	};
};
