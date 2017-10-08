/*
	Author: CreepPork_LV, modified by Kex

	Description:
		Change what sides are going to be friendly.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"
#define SIDES [east, west, independent]

private "_bluforSelectNumber";

if ([blufor, independent] call BIS_fnc_sideIsFriendly) then
{
	_bluforSelectNumber = 3;
}
else
{
	_bluforSelectNumber = 4;
};

private _dialogResult = 
[
	localize "STR_CHANGE_SIDE_RELATIONS",
	[
		[localize "STR_SIDE", ["OPFOR", "BLUFOR", localize "STR_INDEPENDENT"], 1],
		[localize "STR_MODE", [localize "STR_HOSTILE_TO", localize "STR_FRIENDLY_TO"], 1],
		[localize "STR_SIDE", ["OPFOR", "BLUFOR", localize "STR_INDEPENDENT", localize "STR_NOBODY"], _bluforSelectNumber]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

private _firstSelectedSide = (_dialogResult select 0) call BIS_fnc_sideType;

if (_dialogResult select 2 < 3) then
{
	private _secondSelectedSide = (_dialogResult select 2) call BIS_fnc_sideType;
	if (_firstSelectedSide == _secondSelectedSide) exitWith {[localize "STR_SIDES_CANT_MATCH"] call Achilles_fnc_ShowZeusErrorMessage};
	
	private _friend_value = _dialogResult select 1;
	[_firstSelectedSide, [_secondSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];
	[_secondSelectedSide, [_firstSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];
} else
{
	private _other_sides = SIDES - [_firstSelectedSide];
	private _friend_value = 1 - (_dialogResult select 1);
	{
		[_firstSelectedSide, [_x, _friend_value]] remoteExecCall ["setFriend", 2];
		[_x, [_firstSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];
	} forEach _other_sides;
};

#include "\achilles\modules_f_ares\module_footer.hpp"