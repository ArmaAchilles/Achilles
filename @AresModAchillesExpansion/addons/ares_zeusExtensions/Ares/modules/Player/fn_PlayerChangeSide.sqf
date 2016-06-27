////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/13/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_PlayerChangeSide.sqf
//  DESCRIPTION: Module for changing the side of player
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\ares_zeusExtensions\Ares\module_header.hpp"


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
			[localize "STR_MODE",[localize "STR_ALL",localize "STR_SELECTION",localize "STR_SIDE"]],
			[localize "STR_SIDE","ALLSIDE"]
		],
		"Ares_fnc_RscDisplayAttributes_ChangePlayerSide"
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult == 0) exitWith {};
	
	_units = switch (_dialogResult select 0) do
	{
		case 0: 
		{
			[{alive _this}, allPlayers] call Achilles_fnc_filter;
		};
		case 1: 
		{
			_selection = [toLower localize "STR_PLAYERS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {[]};
			[{isPlayer _this},_selection] call Achilles_fnc_filter;
		};
		case 2: 
		{
			_side_index = _dialogResult select 1;
			if (_side_index == 0) exitWith {[player]};
			_side = [east,west,independent,civilian] select ((_dialogResult select 1) - 1);
			[{(alive _this) and (side _this == _side)}, allPlayers] call Achilles_fnc_filter};
		;
	};
	sleep 1;

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
		switch (_dialogResult select 1) do
		{
			case 2: { _side = west; };
			case 3: { _side = independent; };
			case 4: { _side = civilian; };
		};
		
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
	_newGroup setGroupId [_goupID];
	_selectedUnits joinSilent _newGroup;
	_units = _units - _selectedUnits;
};
[localize "STR_CHANGED_SIDE_FOR_PLAYERS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"

