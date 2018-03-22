private _message = _this select 0;
if (count _this > 1) then
{
	_message = format _this;
};

if (!isNil "Ares_Debug_Output_Enabled" && {Ares_Debug_Output_Enabled}) then
{
	player vehicleChat format["[ARES] %1", _message];
	diag_log format["[ARES] %1", _message];
};
