private _message = "";
private _fileName = "N/A";
_message = _this select 0;
_fileName = _this select 1;

if (not (isNil "Achilles_Debug_Output_Enabled")) then
{
	if (Achilles_Debug_Output_Enabled) then
	{
		player vehicleChat format["[ACHILLES] [%1] %2", _fileName, _message];
		diag_log format["[ACHILLES] [%1] %2", _fileName, _message];
	};
};
