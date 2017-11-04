/*
	Author: CreepPork_LV

	Description:
		Gets all LZs or RPs in the misison and sorts them.

	Parameters:
    	_this select 0: - STRING - What to return: "LZ" or "RP"

	Returns:
    	ARRAY - Multidimensional:
			_this select 0: - ARRAY - All LZ objects
			_this select 1: - ARRAY - All LZ object UI names (LZ Alpha)
*/

private _return = [[], []];
params [["_whatToReturn", "LZ", [""]]];

if (_whatToReturn == "LZ") then
{
	private _allLZsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Lz";
	if (count _allLZsPlaced == 0) exitWith {_return};

	private _allLZsPlacedSorted = 
	[
		_allLZsPlaced,
		[],
		{ _x getVariable ["SortOrder", 0]},
		"ASCEND"
	] call BIS_fnc_sortBy;

	{(_return select 0) pushBack _x} forEach _allLZsPlacedSorted;
	{(_return select 1) pushBack (name _x)} forEach _allLZsPlacedSorted;
};

if (_whatToReturn == "RP") then
{
	private _allRPsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Rp";
	if (count _allRPsPlaced == 0) exitWith {_return};

	private _allRPsPlacedSorted = 
	[
		_allRPsPlaced,
		[],
		{ _x getVariable ["SortOrder", 0]},
		"ASCEND"
	] call BIS_fnc_sortBy;

	{(_return select 0) pushBack _x} forEach _allRPsPlacedSorted;
	{(_return select 1) pushBack (name _x)} forEach _allRPsPlacedSorted;
};

_return;