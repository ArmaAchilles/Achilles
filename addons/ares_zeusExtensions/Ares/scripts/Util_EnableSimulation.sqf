[
	"Util",
	"Enable Simulation",
	{
		_unitUnderCursor = _this select 1;
		if (isNull _unitUnderCursor) then
		{
			["Module must be dropped on an object."] call Ares_fnc_ShowZeusMessage;
		}
		else
		{
			_codeBlock = {_this enableSimulationGlobal true;};
			[_codeBlock, _unitUnderCursor, false] call Ares_fnc_BroadcastCode;
			["Simulation enabled."] call Ares_fnc_ShowZeusMessage;
		};
	}
] call Ares_fnc_RegisterCustomModule;