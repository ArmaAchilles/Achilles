////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/13/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_PlayerChangeSide.sqf
//  DESCRIPTION: Module for changing the side of player
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"


_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;


// default values
_units = [];
_side = east;

if (isNull _unitUnderCursor) then
{
	// select players
	_dialogResult = [
		format ["%1 (%2)",localize "STR_CHANGE_SIDE_OF_PLAYER",localize "STR_SELECT_PLAYERS"], 
		[ 
			[localize "STR_MODE",[localize "STR_ZEUS", localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE", localize "STR_PLAYER", localize "STR_GROUP"]],
			["", ["..."]],
			[localize "STR_SIDE","SIDE"]
		],
		"Achilles_fnc_RscDisplayAttributes_selectPlayers"
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult == 0) exitWith {};
	
	_units = switch (_dialogResult select 0) do
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
			_selection = [toLower localize "STR_PLAYERS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_selection select {isPlayer _x};
		};
		case 3: 
		{
			_side_index = _dialogResult select 2;
			_side = [east,west,independent,civilian] select (_side_index - 1);
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
	if (isNil "_units") exitWith {};
	if (count _units == 0) exitWith 
	{
		[localize "STR_NO_PLAYER_IN_SELECTION"] call Ares_fnc_ShowZeusMessage; 
		playSound "FD_Start_F";
	};
	
	// select side to switch
	_dialogResult = 
	[
		localize "STR_CHANGE_SIDE_OF_PLAYER",
		[
			[localize "STR_SIDE", "SIDE"]
		]
	] call Ares_fnc_ShowChooseDialog;
	if (count _dialogResult == 0) exitWith {};
	_side = [east,west,independent,civilian] select ((_dialogResult select 0) - 1);
}
else
{
	_dialogResult = 
	[
		localize "STR_CHANGE_SIDE_OF_PLAYER",
		[
			[localize "STR_CHANGE_SIDE_FOR", [localize "STR_ENTIRE_GROUP", localize "STR_SELECTED_PLAYER"]],
			[localize "STR_SIDE", "SIDE"]
		]
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult > 0) then
	{
		_side_index = _dialogResult select 1;
		_side = [east,west,independent,civilian] select (_side_index - 1);
		
		switch (_dialogResult select 0) do
		{
			case 0:
			{
				_units = units (group _unitUnderCursor);
			};
			case 1:
			{
				_units pushBack _unitUnderCursor;
			};
		};
	};
};

if (count _units == 0) exitWith {};

while {count _units > 0} do
{
	_unit = _units select 0;
	_oldGroup = group _unit;
	_goupID = groupId _oldGroup;
	_selectedUnits = (units _oldGroup) arrayIntersect _units;
	_newGroup = createGroup _side;
	_newGroup setGroupIdGlobal [_goupID];
	_selectedUnits joinSilent _newGroup;
	_units = _units - _selectedUnits;
};
[localize "STR_CHANGED_SIDE_FOR_PLAYERS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"

