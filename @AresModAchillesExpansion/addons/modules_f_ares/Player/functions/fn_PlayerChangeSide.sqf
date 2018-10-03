////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/13/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_PlayerChangeSide.sqf
//  DESCRIPTION: Module for changing the side of player
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc"

private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// default values
private _units = [];
private _side = east;

if (isNull _unitUnderCursor) then
{
	// select players
	private _dialogResult = [
		format ["%1 (%2)",localize "STR_AMAE_CHANGE_SIDE_OF_PLAYER",localize "STR_AMAE_SELECT_PLAYERS"],
		[
			[localize "STR_AMAE_MODE",[localize "STR_AMAE_ZEUS", localize "STR_AMAE_ALL",localize "STR_AMAE_SELECTION",localize "STR_AMAE_SIDE", localize "STR_AMAE_PLAYERS", localize "STR_AMAE_GROUP"]],
			["", ["..."]],
			[localize "STR_AMAE_SIDE","SIDE"]
		],
		"Achilles_fnc_RscDisplayAttributes_selectPlayers"
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

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
			private _selection = [toLower localize "STR_AMAE_PLAYERS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_selection select {isPlayer _x};
		};
		case 3:
		{
			private _side_index = _dialogResult select 2;
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
	if (_units isEqualTo []) exitWith { [localize "STR_AMAE_NO_PLAYER_IN_SELECTION"] call Achilles_fnc_ShowZeusErrorMessage };

	// select side to switch
	_dialogResult =
	[
		localize "STR_AMAE_CHANGE_SIDE_OF_PLAYER",
		[
			[localize "STR_AMAE_SIDE", "SIDE"]
		]
	] call Ares_fnc_ShowChooseDialog;
	if (_dialogResult isEqualTo []) exitWith {};
	_side = [east,west,independent,civilian] select ((_dialogResult select 0) - 1);
}
else
{
	private _dialogResult =
	[
		localize "STR_AMAE_CHANGE_SIDE_OF_PLAYER",
		[
			[localize "STR_AMAE_CHANGE_SIDE_FOR", [localize "STR_AMAE_ENTIRE_GROUP", localize "STR_AMAE_SELECTED_PLAYER"]],
			[localize "STR_AMAE_SIDE", "SIDE"]
		]
	] call Ares_fnc_ShowChooseDialog;

	if (count _dialogResult > 0) then
	{
		private _side_index = _dialogResult select 1;
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

if (_units isEqualTo []) exitWith {};

while {count _units > 0} do
{
	private _unit = _units select 0;
	private _oldGroup = group _unit;
	private _goupID = groupId _oldGroup;
	private _selectedUnits = (units _oldGroup) arrayIntersect _units;
	private _newGroup = createGroup _side;
	_newGroup setGroupIdGlobal [_goupID];
	_selectedUnits joinSilent _newGroup;
	_units = _units - _selectedUnits;
};
[localize "STR_AMAE_CHANGED_SIDE_FOR_PLAYERS", count _units] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.inc"
