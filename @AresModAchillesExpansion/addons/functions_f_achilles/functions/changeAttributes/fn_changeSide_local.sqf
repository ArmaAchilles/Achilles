////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR:			Kex, CreepPork_LV
// DATE:			01/03/2019
// VERSION:			1.3.0
// DESCRIPTION:		changes side of group or unit locally
//
// ARGUMENTS:		0: GROUP|OBJECT - the group or unit that the side should be changed
//					1: SIDE - the new side
//
// RETURNS:			nothing
//
// EXAMPLE:			[group player, west] call Achilles_fnc_changeSide_local;
// EXAMPLE:			[player, west] call Achilles_fnc_changeSide_local;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_objectToChangeSide", grpNull, [grpNull, objNull]],
	["_newSide", east, [sideUnknown]]
];

// Handle groups
if (_objectToChangeSide isEqualType grpNull) then
{
	private _groupLeader = leader _objectToChangeSide;

	// Exit if the requested side is equal
	if (side _groupLeader == _newSide) exitWith {};

	private _newGroup = createGroup _newSide;
	(units _objectToChangeSide) joinSilent _newGroup;

	deleteGroup _objectToChangeSide;
};

// Handle a single unit
if (_objectToChangeSide isEqualType objNull) then
{
	// Exit if the requested side is the same as the current one
	if (side _objectToChangeSide == _newSide) exitWith {};

	private _oldGroup = group _objectToChangeSide;
	private _oldGroupUnitCount = count (units _oldGroup);

	private _newGroup = createGroup _newSide;
	[_objectToChangeSide] joinSilent _newGroup;

	// If there are no units remaining in the old group then delete the old group.
	if ((_oldGroupUnitCount - 1) == 0) then
	{
		deleteGroup _oldGroup;
	}
};