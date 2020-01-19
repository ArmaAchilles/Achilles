/*
* Author: CreepPork_LV
* Changes the side of a unit or a group to the specified side.
*
* Arguments:
* 0: Object for which to change the side <OBJECT|GROUP>
* 1: The side to change the object to <SIDE> (default: east)
*
* Return Value:
* Nothing
*
* Example:
* [group player, west] call Achilles_fnc_changeSide_local
* [player, west] call Achilles_fnc_changeSide_local
*
* Public: Yes
*/

params
[
	["_objectToChangeSide", grpNull, [grpNull, objNull]],
	["_newSide", east, [sideUnknown]]
];

// Exit if the requested side is equal
if (side _objectToChangeSide isEqualTo _newSide) exitWith {};

// Handle groups
if (_objectToChangeSide isEqualType grpNull) exitWith
{
	private _newGroup = createGroup _newSide;
	(units _objectToChangeSide) joinSilent _newGroup;

	deleteGroup _objectToChangeSide;
};

// Handle a single unit
if (_objectToChangeSide isEqualType objNull) then
{
	private _oldGroup = group _objectToChangeSide;
	private _oldGroupUnitCount = count (units _oldGroup);

	private _newGroup = createGroup _newSide;
	[_objectToChangeSide] joinSilent _newGroup;

	// If there are no units remaining in the old group then delete the old group.
	if ((_oldGroupUnitCount - 1) isEqualTo 0) then
	{
		deleteGroup _oldGroup;
	}
};