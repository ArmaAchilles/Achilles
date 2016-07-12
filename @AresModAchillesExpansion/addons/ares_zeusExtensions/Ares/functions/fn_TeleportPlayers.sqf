private ["_playersToTeleport","_teleportLocation","_showTeleportMessage"];

_playersToTeleport = _this select 0;
_teleportLocation = _this select 1;
_showTeleportMessage = [_this, 2, true, [true]] call BIS_fnc_param;

// Show some text to the players that are going to be teleported.
if (_showTeleportMessage) then
{
	Ares_playersToShowMessageTo = _playersToTeleport;
	publicVariable "Ares_playersToShowMessageTo";
	[{ if (player in Ares_playersToShowMessageTo) then { titleText [localize "STR_YOU_ARE_BEING_TELEPORTED", "BLACK", 1]; sleep 1; titleFadeOut 2; };}, "BIS_fnc_spawn"] call BIS_fnc_MP;
};

while {count _playersToTeleport != 0} do
{
	_unit_to_tp = vehicle (_playersToTeleport select 0);
	
	[_unit_to_tp, _teleportLocation, _showTeleportMessage] spawn 
	{
		_unit = _this select 0;
		_teleportLocation = _this select 1;
		_showTeleportMessage = _this select 2;
		if (_showTeleportMessage) then
		{
			sleep 1;
		};

		_unit setVehiclePosition [_teleportLocation, [], 0, "FORM"];
	};
	_playersToTeleport = _playersToTeleport - crew _unit_to_tp;
	
	sleep 0.01;
};
