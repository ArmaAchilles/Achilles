params[["_playersToTeleport", [objNull]], ["_teleportLocation", [0,0,0]], ["_showTeleportMessage", true], ["_includeVehicles", true]];

// Show some text to the players that are going to be teleported.
if (_showTeleportMessage) then
{
	// prevent curators from seeing the message
	Ares_playersToShowMessageTo = _playersToTeleport - (allCurators apply {getAssignedCuratorUnit _x});
	publicVariable "Ares_playersToShowMessageTo";
    [[], {if (player in Ares_playersToShowMessageTo) then { titleText [localize "STR_YOU_ARE_BEING_TELEPORTED", "BLACK", 1]; sleep 1; titleFadeOut 2}}] remoteExec ["spawn", -2];
};

while {!(_playersToTeleport isEqualto [])} do
{
	private _unit_to_tp = [_playersToTeleport select 0, vehicle (_playersToTeleport select 0)] select _includeVehicles;

	[_unit_to_tp, _teleportLocation, _showTeleportMessage] spawn
	{
		params ["_unit", "_teleportLocation", "_showTeleportMessage"];
		if (_showTeleportMessage) then
		{
			sleep 1;
		};

		_unit setVehiclePosition [_teleportLocation, [], 0, "FORM"];
	};

	_playersToTeleport = [_playersToTeleport - [_unit_to_tp], _playersToTeleport - crew _unit_to_tp] select _includeVehicles;

	sleep 0.01;
};
