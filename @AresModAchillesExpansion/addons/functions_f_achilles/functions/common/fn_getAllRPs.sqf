/*
	Author: CreepPork_LV

	Description:
		Gets all RPs in the misison and sorts them.

	Parameters:
    	_this select 0: BOOL - Show Zeus Message on fail

	Returns:
    	ARRAY - All RPs in the misison (empty array if nothing is found and creates a Zeus message).
*/
private _return = [];
private _showMessage = _this select 0;

private _allRPsPlaced = allMissionObjects "Ares_Module_Reinforcements_Create_Rp";
if (count _allRPsPlaced == 0) exitWith 
{
	if(_showMessage) then {[localize "STR_NO_RP"] call Achilles_fnc_showZeusErrorMessage};
	_return;
};

_return = 
[
	_allRPsPlaced,
	[],
	{ _x getVariable ["SortOrder", 0]},
	"ASCEND"
] call BIS_fnc_sortBy;

_return;