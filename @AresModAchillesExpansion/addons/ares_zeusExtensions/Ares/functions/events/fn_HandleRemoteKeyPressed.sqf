private ["_key","_handled"];
_key = _this select 1;
_handled = false;

if (_key in (actionKeys "Chat")) then
{
	// if remote control unit and open chat => open controlled unit's chat
	if (!isNil "bis_fnc_moduleRemoteControl_unit") then 
	{
		[bis_fnc_moduleRemoteControl_unit] spawn Achilles_fnc_chatter;
		_handled = true;
	};
};
_handled
