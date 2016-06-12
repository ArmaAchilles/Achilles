[
	"Util",
	"Remove All Actions",
	{
		_unitUnderCursor = _this select 1;
		if (not (isNull _unitUnderCursor)) then
		{
			removeallActions _unitUnderCursor;
			["All actions removed."] call Ares_fnc_ShowZeusMessage;
		}
		else
		{
			["Module needs to be dropped on a unit or object."] call Ares_fnc_ShowZeusMessage;
		};
	}
] call Ares_fnc_RegisterCustomModule;