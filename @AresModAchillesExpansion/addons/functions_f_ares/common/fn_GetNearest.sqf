/*
	Gets the object from an array that is nearest to a particular point.

	Parameters:
		0 - Position Array - The point of reference for the search.
		1 - Array of Objects - The objects to search through.

	Returns:
		The object from the array that was nearest to the point of reference.
*/

params [["_pointOfReference", [0,0,0], [[]], 3], ["_candidateObjects", [], [[]]]];

private _nearest = objNull;
private _nearestDistance = 0;
{
	if (isNull _nearest || _pointOfReference distance _x < _nearestDistance) then
	{
		_nearest = _x;
		_nearestDistance = _pointOfReference distance _nearest;
	};
} forEach _candidateObjects;

_nearest
