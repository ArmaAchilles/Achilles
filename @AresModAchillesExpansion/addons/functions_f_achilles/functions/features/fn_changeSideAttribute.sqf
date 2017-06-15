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
		private _new_group = createGroup _side;
		(units _x) joinSilent _new_group;
		deleteGroup _x;
	} else
	{
		[[_x,_side],
		{
			params ["_old_group","_new_side"];
			private _new_group = createGroup _new_side;
			(units _old_group) joinSilent _new_group;
			deleteGroup _old_group;
		}] remoteExec ["call", leader _x];
	};
} forEach _curatorSelected;