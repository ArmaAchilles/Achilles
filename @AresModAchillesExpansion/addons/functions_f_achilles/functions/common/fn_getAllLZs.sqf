/*
	Author: CreepPork_LV

	Description:
		Gets all LZs in the misison and sorts them.

	Parameters:
    	_this select 0: BOOL - Show Zeus Message on fail

	Returns:
    	ARRAY - All LZs in the misison (empty array if nothing is found and creates a Zeus message).
*/
private _return = [];
private _showMessage = _this select 0;

private _allLZsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Lz";
if (count _allLZsPlaced == 0) exitWith 
{
	if(_showMessage) then {[localize "STR_NO_LZ"] call Achilles_fnc_showZeusErrorMessage};
	_return;
};

_return = 
[
	_allLZsPlaced,
	[],
	{ _x getVariable ["SortOrder", 0]},
	"ASCEND"
] call BIS_fnc_sortBy;

_return;