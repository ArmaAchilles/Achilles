private ["_key","_handled"];
_key = _this select 1;
_handled = false;
switch (true) do
{
	case (_key == 29): // CTRL
	{
		Ares_Ctrl_Key_Pressed = true;
	};
	case (_key == 42): // SHIFT
	{
		Ares_Shift_Key_Pressed = true;
	};
	case (_key in actionKeys  "CuratorLevelObject"):
	{
		_curatorSelected = ["object"] call Achilles_fnc_getCuratorSelected;
		{
			[getAssignedCuratorLogic player, _x] call Achilles_fnc_HandleCuratorObjectEdited;
		} forEach _curatorSelected;
	};
};
_handled
