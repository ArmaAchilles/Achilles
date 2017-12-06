////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/11/17
//	VERSION: 1.0
//  DESCRIPTION: function that allows changing groups side
//
//	ARGUMENTS:
//	_this select 0:			GROUP	- the group the side should be changed
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[group player] call Achilles_fnc_changeSideAttribute;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_group = param [0,grpNull,[grpNull]];
private _side = side _group;

if (isNil "Achilles_var_changeSide_init_done") then
{
	publicVariable "Achilles_fnc_changeSide_local";
	Achilles_var_changeSide_init_done = true;
};

_dialogResult =
[
	localize "STR_CHANGE_SIDE",
	[
		[localize "STR_SIDE","SIDE",([_side] call BIS_fnc_sideID) + 1, true]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_side = [(_dialogResult select 0) - 1] call BIS_fnc_sideType;

private _curatorSelected = ["group"] call Achilles_fnc_getCuratorSelected;

{
	if (local leader _x) then
	{
		[_x, _side] call Achilles_fnc_changeSide_local;
	} else
	{
		[_x, _side] remoteExecCall ["Achilles_fnc_changeSide_local", leader _x];
	};
} forEach _curatorSelected;