#include "\achilles\modules_f_ares\module_header.hpp"

//Broadcast search building function
if (isNil "Achilles_var_zen_occupy_house_init_done") then
{
	publicVariable "Ares_fnc_ZenOccupyHouse";
	Achilles_var_zen_occupy_house_init_done = true;
};

private _groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;
if (isNull _groupUnderCursor) exitWith {};

private	_doesGroupContainAnyPlayer = !(((units _groupUnderCursor) select {isPlayer _x}) isEqualTo []);

if (_doesGroupContainAnyPlayer) then
{
	// error message
	playSound "FD_Start_F";
	[localize "STR_AMAE_CANNOT_BE_APPLIED_ON_GROUPS_WITH_PLAYERS"] call Ares_fnc_showZeusMessage;
}
else
{
	private _dialogResult =
	[
		localize "STR_AMAE_GARRISON_INSTANT",
		[
			["TEXT", [localize "STR_AMAE_RADIUS", "[m]"] joinString " ", [], "150"],
			["COMBOBOX", localize "STR_AMAE_INSIDE_ONLY", [localize "STR_AMAE_FALSE", localize "STR_AMAE_TRUE"], 1],
			["COMBOBOX", localize "STR_AMAE_FILL_EVENLY", [localize "STR_AMAE_FALSE", localize "STR_AMAE_TRUE"], 0]
		]
	] call Achilles_fnc_showChooseDialog;
	if (_dialogResult isEqualTo []) exitWith {};
	private _radius = parseNumber (_dialogResult param[0]);
	private _insideOnly = (_dialogResult param[1] == 1);
	private _fillEvenly = (_dialogResult param[1] == 1);
	
	if (local _groupUnderCursor) then
	{
		[(getPos _logic), (units _groupUnderCursor), _radius, _insideOnly, _fillEvenly] call Ares_fnc_ZenOccupyHouse;
	} else
	{
		[(getPos _logic), (units _groupUnderCursor), _radius, _insideOnly, _fillEvenly] remoteExec ["Ares_fnc_ZenOccupyHouse", leader _groupUnderCursor];
	};
	[localize "STR_AMAE_GARRISONED_NEAREST_BUILDINGS"] call Ares_fnc_showZeusMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
