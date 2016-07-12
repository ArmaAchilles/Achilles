[
	"Util",
	"Make Zeus Invisible",
	{
		[player, true] call Ares_fnc_MakePlayerInvisible;
		["Zeus is now invisible."] call Ares_fnc_ShowZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;