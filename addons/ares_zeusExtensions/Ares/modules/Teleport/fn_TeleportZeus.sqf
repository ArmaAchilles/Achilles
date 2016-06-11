#include "\ares_zeusExtensions\Ares\module_header.hpp"

_playersToTeleport = [player];

// Get the location to teleport to.
_location = getPos _logic;

// Call the teleport function.
[_playersToTeleport, _location, false] call Ares_fnc_TeleportPlayers;

[objNull, format["Teleported zeus to %1", _location]] call bis_fnc_showCuratorFeedbackMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
