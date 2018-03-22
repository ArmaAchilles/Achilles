////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR:			Kex
// DATE:			7/16/17
// VERSION:			AMAE001
// DESCRIPTION:		changes side of group locally
//
// ARGUMENTS:		0: GROUP - the group the side should be changed
//					1: SIDE - the new side
//
// RETURNS:			nothing
//
// EXAMPLE:			[group player, west] call Achilles_fnc_changeSide_local;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_old_group", grpNull, [grpNull]], ["_new_side", east, [sideUnknown]]];

private _new_group = createGroup _new_side;
(units _old_group) joinSilent _new_group;
deleteGroup _old_group;