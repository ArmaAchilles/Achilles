/*
	Gets the group of the unit under the mouse cursor.

	Params:
		0 - [Object] The module's logic unit that is trying to get the unit under the cursor. Will automatically be deleted if no unit is under the cursor.

	Returns:
		The group of the unit under the cursor (if any). Otherwise the logic unit parameter is deleted.
*/

private _logic = _this select 0;
private _unitUnderCursor = [_logic] call Ares_fnc_GetUnitUnderCursor;

if (!isNull _unitUnderCursor) exitWith
{
    group _unitUnderCursor;
};

grpNull;
