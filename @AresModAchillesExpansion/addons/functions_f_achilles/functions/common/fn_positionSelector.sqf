/*
	Author: Kex, based on Anton's implementation

	Description:
		Searches all position logics of a specific type.
		Returns the name and position of the logics sorted by name.

	Parameters:
		ARRAY - A reference position. This is required for the "nearest" and "farthest" options
    	ARRAY - Array of positions; the positions that can be selected.
		SCALAR - (Default: 0) The choice algorithm (0: random, 1: nearest, 2: farthest, (i>2): select (i-3)th element.

	Returns:
    	ARRAY - The selected position.
*/

params [["_refPosition",[0,0,0],[[]],3], ["_candidatePositions",[],[[]]], ["_choiceAlgorithm",0,[0]]];

_return = switch (_choiceAlgorithm) do
{
	case 0: // Random
	{
		_candidatePositions call BIS_fnc_selectRandom;
	};
	case 1: // Nearest
	{
		[_refPosition, _candidatePositions] call Ares_fnc_GetNearest;
	};
	case 2: // Farthest
	{
		[_refPosition, _candidatePositions] call Ares_fnc_GetFarthest;
	};
	default // Specific target
	{
		_candidatePositions select (_choiceAlgorithm - 3);
	};
};

_return;
