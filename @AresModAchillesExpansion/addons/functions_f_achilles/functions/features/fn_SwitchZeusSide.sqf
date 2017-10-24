////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_SwitchZeusSide.sqf
//  DESCRIPTION: function that allows selecting an animation for a unit.
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- affected zeus player
//	_this select 1:			SCALAR	- side index (0: sideLogic, 1: east, 2: west, 3: independent, 4: civilian)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_zeus_player,0] call Achilles_fnc_SwitchZeusSide;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define SIDES [sideLogic,east,west,independent,civilian]

private ["_group"];

private _unit = param [0,ObjNull,[ObjNull]];
private _side_index = param [1,0,[0]];

// create curator group for each side if they do not exist
if (isNil "Achilles_var_curator_groups") then
{
	private _unit_side = side _unit;

	Achilles_var_curator_groups = [];
	{
		if (_x == _unit_side) then
		{
			_group = group _unit;
		} else
		{
			_group = createGroup _x;
			"Logic" createUnit  [position _unit, _group];
		};
		Achilles_var_curator_groups pushBack _group;
	} forEach SIDES;
};

private _new_group = Achilles_var_curator_groups select _side_index;

// create a new group if old one was deleted
if (isNull _new_group) then
{
	private _new_group = createGroup (SIDES select _side_index);
	"Logic" createUnit  [position _unit, _new_group];
	Achilles_var_curator_groups set [_side_index,_new_group];
};

//private _new_side = side _new_group;

[_unit] joinSilent _new_group;
_new_group selectLeader _unit;
