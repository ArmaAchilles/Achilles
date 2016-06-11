private ["_closestMarker", "_closestMarkerDistance"];

#include "\ares_zeusExtensions\Ares\module_header.hpp"

// Get the position to teleport to
_teleportLocation = getPos _logic;

// Generate a list of the player objects and their names
_playerList = [];
_playerNameList = [];
{
	if (isPlayer _x) then
	{
		_playerList pushBack _x;
		_playerNameList pushBack (name _x);
	};
} forEach playableUnits;

// Ask the user who to teleport
_dialogResult =
	[
		"Teleport Player",
		[
			["Player Name", _playerNameList]
		]
	] call Ares_fnc_ShowChooseDialog;

if ((count _dialogResult) > 0) then
{
	// Teleport the selected player.
	_playerToTeleport = _playerList select (_dialogResult select 0);
	[[_playerToTeleport], _teleportLocation] call Ares_fnc_TeleportPlayers;
	[objNull, format["%1 teleported to %2", _playerNameList select (_dialogResult select 0), _teleportLocation]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
