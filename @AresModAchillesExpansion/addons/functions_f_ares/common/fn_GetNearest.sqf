/*
	Gets the position from an array that is nearest to a particular point.

	Parameters:
		0 - Position - The point of reference for the search.
		1 - Array of positions - The objects to search through.

	Returns:
		The position from the array that is nearest to the point of reference.
		Returns an empty array if the array of positions is empty.
*/

params [["_pointOfReference", [0,0,0], [[]], 3], ["_candidatePositions", [], [[]]]];

private _nearest = [];
private _nearestDistance = 0;
{
	if (_nearest isEqualTo [] || _pointOfReference distance _x < _nearestDistance) then
	{
		_nearest = _x;
		_nearestDistance = _pointOfReference distance _nearest;
	};
} forEach _candidatePositions;

_nearest
