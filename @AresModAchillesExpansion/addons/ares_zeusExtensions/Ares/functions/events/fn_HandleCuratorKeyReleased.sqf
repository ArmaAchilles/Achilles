_key = _this select 1;
_handled = false;
[format ["Key Released %1", _key]] call Ares_fnc_LogMessage;
switch (_key) do
{
	case 29: // CTRL
	{
		["CTRL Released"] call Ares_fnc_LogMessage;
		Ares_Ctrl_Key_Pressed = false;
	};
	case 42: // SHIFT
	{
		["SHIFT Released"] call Ares_fnc_LogMessage;
		Ares_Shift_Key_Pressed = false;
	};
};
_handled;