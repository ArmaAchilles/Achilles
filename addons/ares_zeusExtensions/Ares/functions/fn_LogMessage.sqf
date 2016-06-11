private["_message"];
_message = _this select 0;
if (count _this > 1) then
{
	_message = format _this;
};

if (not (isNil "Ares_Debug_Output_Enabled")) then
{
	if (Ares_Debug_Output_Enabled) then
	{
		player vehicleChat format["[ARES] %1", _message];
		diag_log format["[ARES] %1", _message];
	};
};
