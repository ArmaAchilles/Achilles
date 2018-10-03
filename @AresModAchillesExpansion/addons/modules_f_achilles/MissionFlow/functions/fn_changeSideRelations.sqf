/*
	Author: CreepPork_LV, modified by Kex

	Description:
		Change what sides are going to be friendly.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.inc"
#define SIDES [east, west, independent]

private _bluforSelectNumber = 4;

_bluforSelectNumber = [4, 3] select ([blufor, independent] call BIS_fnc_sideIsFriendly);

private _dialogResult =
[
	localize "STR_AMAE_CHANGE_SIDE_RELATIONS",
	[
		[localize "STR_AMAE_SIDE", ["OPFOR", "BLUFOR", localize "STR_AMAE_INDEPENDENT"], 1],
		[localize "STR_AMAE_MODE", [localize "STR_AMAE_HOSTILE_TO", localize "STR_AMAE_FRIENDLY_TO"], 1],
		[localize "STR_AMAE_SIDE", ["OPFOR", "BLUFOR", localize "STR_AMAE_INDEPENDENT", localize "STR_NOBODY"], _bluforSelectNumber],
		[localize "STR_AMAE_PLAY_MESSAGE", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

private _firstSelectedSide = (_dialogResult select 0) call BIS_fnc_sideType;

if (_dialogResult select 2 < 3) then
{
	private _secondSelectedSide = (_dialogResult select 2) call BIS_fnc_sideType;
	if (_firstSelectedSide == _secondSelectedSide) exitWith {[localize "STR_AMAE_SIDES_CANT_MATCH"] call Achilles_fnc_ShowZeusErrorMessage};

	private _friend_value = _dialogResult select 1;
	[_firstSelectedSide, [_secondSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];
	[_secondSelectedSide, [_firstSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];

	if (_dialogResult select 3 == 0) then
	{
		if (_friend_value == 1) then
		{
			[_firstSelectedSide, format ["SentGenBaseSideFriendly%1", _secondSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
			[_secondSelectedSide, format ["SentGenBaseSideFriendly%1", _firstSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
		}
		else
		{
			[_firstSelectedSide, format["SentGenBaseSideEnemy%1", _secondSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
			[_secondSelectedSide, format["SentGenBaseSideEnemy%1", _firstSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
		};
	};
}
else
{
	private _other_sides = SIDES - [_firstSelectedSide];
	private _friend_value = 1 - (_dialogResult select 1);
	{
		[_firstSelectedSide, [_x, _friend_value]] remoteExecCall ["setFriend", 2];
		[_x, [_firstSelectedSide, _friend_value]] remoteExecCall ["setFriend", 2];

		if (_dialogResult select 3 == 0) then
		{
			if (_friend_value == 1) then
			{
				[_firstSelectedSide, format ["SentGenBaseSideFriendly%1", _x], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
				[_x, format ["SentGenBaseSideFriendly%1", _firstSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
			}
			else
			{
				[_firstSelectedSide, format["SentGenBaseSideEnemy%1", _x], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
				[_x, format["SentGenBaseSideEnemy%1", _firstSelectedSide], "side"] remoteExecCall ["BIS_fnc_sayMessage", 0];
			};
		};
	} forEach _other_sides;
};

#include "\achilles\modules_f_ares\module_footer.inc"
