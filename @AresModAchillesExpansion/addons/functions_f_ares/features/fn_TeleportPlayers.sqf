private ["_unit_to_tp"];
params[["_playersToTeleport", [objNull]], ["_teleportLocation", [0,0,0]], ["_showTeleportMessage", true], ["_includeVehicles", true]];

// Show some text to the players that are going to be teleported.
if (_showTeleportMessage) then
{
	// prevent curators from seeing the message
	Ares_playersToShowMessageTo = _playersToTeleport - (allCurators apply {getAssignedCuratorUnit _x});
	publicVariable "Ares_playersToShowMessageTo";
	[{ if (player in Ares_playersToShowMessageTo) then { titleText [localize "STR_YOU_ARE_BEING_TELEPORTED", "BLACK", 1]; sleep 1; titleFadeOut 2; };}, "BIS_fnc_spawn"] call BIS_fnc_MP;
};

while {count _playersToTeleport != 0} do
{
	if (_includeVehicles) then
	{
		_unit_to_tp = vehicle (_playersToTeleport select 0);
	} else
	{
		_unit_to_tp = _playersToTeleport select 0
	};
	
	[_unit_to_tp, _teleportLocation, _showTeleportMessage] spawn 
	{
		private _unit = _this select 0;
		_teleportLocation = _this select 1;
		_showTeleportMessage = _this select 2;
		if (_showTeleportMessage) then
		{
			sleep 1;
		};

		_unit setVehiclePosition [_teleportLocation, [], 0, "FORM"];
	};
	
	if (_includeVehicles) then
	{	
		_playersToTeleport = _playersToTeleport - crew _unit_to_tp;
	} else
	{
		_playersToTeleport = _playersToTeleport - [_unit_to_tp];
	};
	
	sleep 0.01;
};
