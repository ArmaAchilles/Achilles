params ["_ctrl", "_key", "_shiftKey", "_ctrlKey", "_altKey"];
private _handled = false;

switch (true) do
{
	case (_key in actionKeys "Chat"):
	{
		// if remote control unit and open chat => open controlled unit's chat
		if (!isNil "bis_fnc_moduleRemoteControl_unit") then
		{
			[bis_fnc_moduleRemoteControl_unit] spawn Achilles_fnc_chatter;
			_handled = true;
		};
	};
	case (_key in actionKeys "CuratorInterface"):
	{
		// if remote control unit and open chat => open controlled unit's chat
		if (!isNil "bis_fnc_moduleRemoteControl_unit" and {not isNil {bis_fnc_moduleRemoteControl_unit getVariable "Achilles_var_switchUnit_data"}}) then
		{
			[] call Achilles_fnc_switchUnit_exit;
			_handled = true;
		};
	};
};
_handled
