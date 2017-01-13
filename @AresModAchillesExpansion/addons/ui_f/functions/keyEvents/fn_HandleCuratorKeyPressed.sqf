private ["_key","_handled"];
_key = _this select 1;
_handled = false;
switch (_key) do
{
	case 29: // CTRL
	{
		Ares_Ctrl_Key_Pressed = true;
	};
	case 42: // SHIFT
	{
		Ares_Shift_Key_Pressed = true;
	};
};
_handled
