/*
	Gets the phonetic ('Alpha', 'Bravo', 'Charlie'...) name for a given index in the alphabet. If
	the number is longer than the available values then a number is added as well (i.e. 'Alpha-1' or 'Alpha-3').
	
	Parameters:
		0 - Number - The number of the name to retrieve.
	
	Returns:
		String - The name corresponding to the number provided.
*/

_index = [_this, 0, 0] call BIS_fnc_param;

_names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-Ray", "Yankee", "Zulu"];

private ["_name"];
if (_index >= count _names) then
{
	_suffix = floor (_index / (count _names));
	_name = format ["%1-%2", (_names select (_index mod (count _names))), _suffix];
}
else
{
	_name = _names select _index;
};

_name;