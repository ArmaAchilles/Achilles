/*
	Gets the position or object from an array that is farthest from a particular point.

	Parameters:
		0 - Position or object - The point of reference for the search.
		1 - Array of positions or objects - The objects to search through.

	Returns:
		The object or position from the array that is farthest to the point of reference.
		Returns an empty array if the array of positions is empty.
*/

params [["_pointOfReference", [0,0,0], [[],objNull], 3], ["_candidatePositions", [], [[]]]];

private _farthest = [];
private _farthestDistance = 0;
{
	if (_pointOfReference distance _x > _farthestDistance) then
	{
		_farthest = _x;
		_farthestDistance = _pointOfReference distance _farthest;
	};
} forEach _candidatePositions;

_farthest
