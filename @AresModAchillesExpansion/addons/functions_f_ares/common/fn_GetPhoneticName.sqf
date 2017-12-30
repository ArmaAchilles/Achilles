/*
	Gets the phonetic ('Alpha', 'Bravo', 'Charlie'...) name for a given index in the alphabet. If
	the number is longer than the available values then a number is added as well (i.e. 'Alpha-1' or 'Alpha-3').

	Parameters:
		0 - Number - The number of the name to retrieve.

	Returns:
		String - The name corresponding to the number provided.
*/

params[["_index", 0, [0]]];

private _names = [];
for '_i' from 97 to 122 do
{
	_names pushBack (localize format ["str_a3_radio_%1", toString [_i]]);
};

if (_index >= count _names) exitWith
{
	private _suffix = floor (_index / (count _names));
	format ["%1-%2", (_names select (_index mod (count _names))), _suffix];
};
_names select _index
