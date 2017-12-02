/*
	Gets the object from an array that is farthest from a particular point.

	Parameters:
		0 - Position Array - The point of reference for the search.
		1 - Array of Objects - The objects to search through.

	Returns:
		The object from the array that was farthest to the point of reference.
*/

params [["_pointOfReference", [0, 0, 0], [[]], 3], ["_candidateObjects", [], [[]]]];

private _farthest = objNull;
private _farthestDistance = 0;
{
	if (isNull _farthest || _pointOfReference distance _x > _farthestDistance) then
	{
		_farthest = _x;
		_farthestDistance = _pointOfReference distance _farthest;
	};
} forEach _candidateObjects;

_farthest
