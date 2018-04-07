/*
	Author: Kex, based on Anton's implementation

	Description:
		Selects a logic from the passed logic list based on the selected algorithm.
		This function is used for selecting position logics such as LZ, RP and targets. 

	Parameters:
		ARRAY - A reference position. This is required for the "nearest" and "farthest" options
    	ARRAY - Array of objects; the logics that can be selected.
		SCALAR - (Default: 0) The choice algorithm (0: random, 1: nearest, 2: farthest, (i>2): select (i-3)th element.

	Returns:
    	OBJECT - The selected logic.
*/

params [["_refPosition",[0,0,0],[[]],3], ["_candidateLogics",[],[[]]], ["_choiceAlgorithm",0,[0]]];

_return = switch (_choiceAlgorithm) do
{
	case 0: // Random
	{
		_candidateLogics call BIS_fnc_selectRandom;
	};
	case 1: // Nearest
	{
		[_refPosition, _candidateLogics] call Ares_fnc_GetNearest;
	};
	case 2: // Farthest
	{
		[_refPosition, _candidateLogics] call Ares_fnc_GetFarthest;
	};
	default // Specific target
	{
		_candidateLogics select (_choiceAlgorithm - 3);
	};
};

_return;
