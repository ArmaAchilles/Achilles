////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/13/16
//	VERSION: 1.0
//	FILE: Ares\functions\fn_PlayerTeleport.sqf
//  DESCRIPTION: Teleport Module
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

_tp_pos = position _logic;

_dialogResult = [
	localize "STR_TELEPORT", 
	[ 
		[localize "STR_MODE",[localize "STR_ZEUS", localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE", localize "STR_PLAYER", localize "STR_GROUP"]],
		["", ["..."]],
		[localize "STR_SIDE","ALLSIDE"]
	],
	"Achilles_fnc_RscDisplayAttributes_selectPlayers"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_playersToTeleport = switch (_dialogResult select 0) do
{
	case 0:
	{
		[player];
	};
	case 1: 
	{
		[{alive _this}, allPlayers] call Achilles_fnc_filter;
	};
	case 2: 
	{
		_selection = [toLower localize "STR_PLAYERS"] call Achilles_fnc_SelectUnits;
		if (isNil "_selection") exitWith {nil};
		[{isPlayer _this},_selection] call Achilles_fnc_filter;
	};
	case 3: 
	{
		_side_index = _dialogResult select 2;
		if (_side_index == 0) exitWith {[player]};
		_side = [east,west,independent,civilian] select (_side_index - 1);
		[{(alive _this) and (side _this == _side)}, allPlayers] call Achilles_fnc_filter
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
if (count _playersToTeleport == 0) exitWith 
{
	["No players in selection!"] call Ares_fnc_ShowZeusMessage; 
	playSound "FD_Start_F";
};

// Call the teleport function.
[_playersToTeleport, _tp_pos] call Ares_fnc_TeleportPlayers;

[objNull, format["Teleported %1 players to %2", (count _playersToTeleport), _tp_pos]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"

