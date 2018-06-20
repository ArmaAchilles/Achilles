params
[
	["_playersToTeleport", [objNull]],
	["_teleportLocation", [0,0,0]],
	["_showTeleportMessage", true],
	["_additionalOption", 0]
];

// Show some text to the players that are going to be teleported.
if (_showTeleportMessage) then
{
	// prevent curators from seeing the message
	Ares_playersToShowMessageTo = _playersToTeleport - (allCurators apply {getAssignedCuratorUnit _x});
	publicVariable "Ares_playersToShowMessageTo";
    [[], {if (player in Ares_playersToShowMessageTo) then { titleText [localize "STR_AMAE_YOU_ARE_BEING_TELEPORTED", "BLACK", 1]; sleep 1; titleFadeOut 2}}] remoteExec ["spawn", -2];
};

private _includeVehicles = (_additionalOption == 1);
private _doHALO = (_additionalOption == 2);

if (_doHALO) then
{
	_teleportLocation set [2, 3000];
};

while {!(_playersToTeleport isEqualto [])} do
{
	private _unit_to_tp = [_playersToTeleport select 0, vehicle (_playersToTeleport select 0)] select _includeVehicles;

	[_unit_to_tp, _teleportLocation, _showTeleportMessage, _doHALO] spawn
	{
		params ["_unit", "_teleportLocation", "_showTeleportMessage", "_doHALO"];
		if (_showTeleportMessage) then
		{
			sleep 1;
		};

		_unit setVehiclePosition [_teleportLocation, [], 0, "FORM"];
		_unit setPos [getPos _unit select 0, getPos _unit select 1, _teleportLocation select 2];
		if (_doHALO) then {[_unit] call Achilles_fnc_chute};
	};

	_playersToTeleport = [_playersToTeleport - [_unit_to_tp], _playersToTeleport - crew _unit_to_tp] select _includeVehicles;

	sleep 0.01;
};
