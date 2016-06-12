[
	"Arsenal",
	"Add Full Arsenal",
	{
		_unitUnderCursor = _this select 1;
		if (not (isNull _unitUnderCursor)) then
		{
			["AmmoboxInit", [_unitUnderCursor, true]] spawn BIS_fnc_arsenal;
			["Arsenal Added"] call Ares_fnc_ShowZeusMessage;
		}
		else
		{
			["Must be placed on an object."] call Ares_fnc_ShowZeusMessage;
		};
	}
] call Ares_fnc_RegisterCustomModule;