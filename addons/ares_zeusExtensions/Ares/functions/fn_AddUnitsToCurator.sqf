/*
	Adds (or removes) a set of objects to all of the curator modules that are active.
	
	Parameters:
		0 - Array - The set of objects to add or remove from curator control.
		1 - Boolean - True to add the objects to curator control, false to remove them from curator control. Default is True.
*/

_unitsToModify = [_this, 0, [], [[]]] call BIS_fnc_param;
_addToCurator = [_this, 1, true, [true]] call BIS_fnc_param;

if (isNil "Ares_addUnitsToCuratorFunction") then
{
	Ares_addUnitsToCuratorFunction =
	{
		if (_this select 1) then
		{
			{ _x addCuratorEditableObjects [(_this select 0), true]; } foreach allCurators;
		}
		else
		{
			{ _x removeCuratorEditableObjects [(_this select 0), true]; } foreach allCurators;
		};
	};
	publicVariable "Ares_addUnitsToCuratorFunction";
};

[[_unitsToModify, _addToCurator], "Ares_addUnitsToCuratorFunction", false] call BIS_fnc_MP;
true