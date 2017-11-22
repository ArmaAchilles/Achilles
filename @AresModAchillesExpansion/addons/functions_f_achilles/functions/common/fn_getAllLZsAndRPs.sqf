/*
	Author: CreepPork_LV

	Description:
		Gets all LZs and RPs in the misison and sorts them.

	Parameters:
    	None

	Returns:
    	ARRAY - Multidimensional:
		[
			LZs
			[
				_this select 0: - ARRAY - All LZ objects
				_this select 1: - ARRAY - All LZ objects with names (LZ Alpha)
			],
			RPs
			[
				_this select 0: - ARRAY - All RP objects
				_this select 1: - ARRAY - All RP objects with names (RP Alpha)
			]
		]
*/

private _return = [];

private _allLZsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Lz";
private _allRPsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Rp";
if (_allLZsPlaced isEqualTo [] && _allRPsPlaced isEqualTo []) exitWith {[]};

// LZs
if (!(_allLZsPlaced isEqualTo [])) then
{
	private _allLZsPlacedSorted =
	[
		_allLZsPlaced,
		[],
		{ _x getVariable ["SortOrder", 0]},
		"ASCEND"
	] call BIS_fnc_sortBy;

    _return pushBack [_allLZsPlacedSorted, _allLZsPlacedSorted apply {name _x}];
};

// RPs
if (!(_allRPsPlaced isEqualTo [])) then
{
	private _allRPsPlacedSorted =
	[
		_allRPsPlaced,
		[],
		{ _x getVariable ["SortOrder", 0]},
		"ASCEND"
	] call BIS_fnc_sortBy;

    _return pushBack [_allRPsPlacedSorted, _allRPsPlacedSorted apply {name _x}];
};

_return
