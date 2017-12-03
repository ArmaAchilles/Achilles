////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/13/16
//	VERSION: 1.0
//	FILE: Ares\functions\fn_PlayerTeleport.sqf
//  DESCRIPTION: Teleport Module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _tp_pos = position _logic;

private _dialogResult = [
	localize "STR_AMAE_TELEPORT",
	[
		[localize "STR_AMAE_MODE",[localize "STR_AMAE_ZEUS", localize "STR_AMAE_ALL",localize "STR_AMAE_SELECTION",localize "STR_AMAE_SIDE", localize "STR_AMAE_PLAYERS", localize "STR_AMAE_GROUP"]],
		["", ["..."]],
		[localize "STR_AMAE_SIDE","ALLSIDE"],
		[localize "STR_AMAE_INCLUDE_VEHICLES",[localize "STR_AMAE_FALSE",localize "STR_AMAE_TRUE"]]
	],
	"Achilles_fnc_RscDisplayAttributes_selectPlayers"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

private _playersToTeleport = switch (_dialogResult select 0) do
{
	case 0:
	{
		[player];
	};
	case 1:
	{
		allPlayers select {alive _x};
	};
	case 2:
	{
		private _selection = [toLower localize "STR_AMAE_PLAYERS"] call Achilles_fnc_SelectUnits;
		if (isNil "_selection") exitWith {nil};
		_selection select {isPlayer _x};
	};
	case 3:
	{
		private _side_index = _dialogResult select 2;
		if (_side_index == 0) exitWith {[player]};
		private _side = [east,west,independent,civilian] select (_side_index - 1);
		allPlayers select {(alive _x) and (side _x == _side)};
	};
	case 4:
	{
		Ares_var_selectPlayers;
	};
	case 5:
	{
		Ares_var_selectPlayers;
	};
};
sleep 1;

if (isNil "_playersToTeleport") exitWith {};
if (_playersToTeleport isEqualTo []) exitWith
{
	["No players in selection!"] call Ares_fnc_ShowZeusMessage;
	playSound "FD_Start_F";
};
private _includeVehicles = if ((_dialogResult select 3) == 0) then {false} else {true};

// Call the teleport function.
[_playersToTeleport, _tp_pos, true, _includeVehicles] call Ares_fnc_TeleportPlayers;

[objNull, format["Teleported %1 players to %2", (count _playersToTeleport), _tp_pos]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
