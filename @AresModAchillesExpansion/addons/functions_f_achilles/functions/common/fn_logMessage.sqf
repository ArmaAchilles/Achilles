private _message = "";
private _fileName = "N/A";
_message = _this select 0;
_fileName = _this select 1;
if (count _this > 1) then
{
	_message = format _this;
};

if (not (isNil "Achilles_Debug_Output_Enabled")) then
{
	if (Achilles_Debug_Output_Enabled) then
	{
		player vehicleChat format["[ACHILLES] [%1] %2", _fileName, _message];
		diag_log format["[ACHILLES] [%1] %2", _fileName, _message];
	};
};
