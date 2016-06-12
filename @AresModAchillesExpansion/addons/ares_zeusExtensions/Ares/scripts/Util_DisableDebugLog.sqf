[
	"Util",
	"Disable Debug Log",
	{
		Ares_Debug_Output_Enabled = false;
		["Debug output disabled."] call Ares_fnc_ShowZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;