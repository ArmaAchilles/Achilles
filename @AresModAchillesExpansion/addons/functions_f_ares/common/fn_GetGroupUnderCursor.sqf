/*
	Gets the group of the unit under the mouse cursor.
	
	Params:
		0 - [Object] The module's logic unit that is trying to get the unit under the cursor. Will automatically be deleted if no unit is under the cursor.
		
	Returns:
		The group of the unit under the cursor (if any). Otherwise the logic unit parameter is deleted.
*/

private ["_logic", "_unitUnderCursor", "_group"];
_logic = _this select 0;
_unitUnderCursor = [_logic] call Ares_fnc_GetUnitUnderCursor;
_group = grpNull;
if (not isNull _unitUnderCursor) then
{
	_group = group _unitUnderCursor;
};

_group;
