/*
	Creates a new logic unit with a specified name.
	
	Parameters:
		0 - 3D position - position of the logic.
		1 - String (Optional) - Logic Name
		2 - Group (Optional) - The group to add the logic to.
*/

_position = [_this, 0] call BIS_fnc_Param; 
_name = [_this, 1, "Logic"] call BIS_fnc_Param;
_group = [_this, 2, grpNull] call BIS_fnc_Param;

if (isNull _group) then
{
	_center = createCenter sideLogic;
	_group = createGroup _center;
};
_logic = _group createUnit ["LOGIC", _position, [], 0, "NONE"];
_logic setName _name;
_logic;