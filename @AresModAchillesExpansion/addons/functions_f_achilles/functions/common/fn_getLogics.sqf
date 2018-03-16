/*
	Author: CreepPork_LV, Kex

	Description:
		Searches all position logics of a specific type.
		Returns the name and logic sorted by name.

	Parameters:
    	STRING - (Default: "All" ) Type of the logic (e.g. "Ares_Module_Reinforcements_Create_Lz").

	Returns:
    	ARRAY - Multidimensional:
		[
			_this select 0: - ARRAY - Array of the name of all logics
			_this select 1: - ARRAY - Array of all logics
		]
*/

params [["_type","All",[""]]];

private _return = [[], []];

private _selectedLogics = allMissionObjects _type;

if (!(_selectedLogics isEqualTo [])) then
{
	private _selectedLogicsSorted =
	[
		_selectedLogics,
		[],
		{ _x getVariable ["SortOrder", 0]}
	] call BIS_fnc_sortBy;
	
	_return params ["_names", "_logics"];
	{
		_names pushBack (name _x);
		_logics pushBack _x;
	} forEach _selectedLogicsSorted;
};

_return;
