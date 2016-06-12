#include "\ares_zeusExtensions\Ares\module_header.hpp"

// Generate list of the players to teleport.
_playersToTeleport = [];
{
	if (isPlayer _x && (side _x) == resistance) then
	{
		_playersToTeleport set [count _playersToTeleport, _x];
	};
} forEach allUnits;

// Get the location to teleport them to.
_location = getPos _logic;

// Call the teleport function.
[_playersToTeleport, _location] call Ares_fnc_TeleportPlayers;

[objNull, format["Teleported %1 players to %2", (count _playersToTeleport), _location]] call bis_fnc_showCuratorFeedbackMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
