#include "\ares_zeusExtensions\Ares\module_header.hpp"

// Get the position to teleport to
_teleportLocation = getPos _logic;

// Generate a list of the player objects and their names
_groupList = [];
_groupNameList = [];
{
	_group = _x;
	_groupName = groupID _group;
	{
		if (isPlayer _x) exitWith
		{
			_groupList pushBack _group;
			_groupNameList pushBack _groupName;
		};
	} forEach (units _group);
} forEach allGroups;

// Ask the user who to teleport
_dialogResult =
	[
		"Teleport Group",
		[
			["Group Name", _groupNameList]
		]
	] call Ares_fnc_ShowChooseDialog;

if ((count _dialogResult) > 0) then
{
	// Teleport the selected player.
	_groupToTeleport = _groupList select (_dialogResult select 0);
	[units _groupToTeleport, _teleportLocation] call Ares_fnc_TeleportPlayers;
	[objNull, format["'%1' teleported to %2", _groupNameList select (_dialogResult select 0), _teleportLocation]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
