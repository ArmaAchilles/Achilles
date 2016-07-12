[
	"Util",
	"Make Zeus Visible",
	{
		[player, false] call Ares_fnc_MakePlayerInvisible;
		["Zeus is now visible."] call Ares_fnc_ShowZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;