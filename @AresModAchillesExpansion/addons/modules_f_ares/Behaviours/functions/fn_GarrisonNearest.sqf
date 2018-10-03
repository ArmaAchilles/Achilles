#include "\achilles\modules_f_ares\module_header.inc.sqf"

//Broadcast search building function
if (isNil "Achilles_var_occupy_house_init_done") then
{
	publicVariable "Achilles_fnc_instantBuildingGarrison";
	Achilles_var_occupy_house_init_done = true;
};

private _groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;
if (isNull _groupUnderCursor) exitWith {};

private	_doesGroupContainAnyPlayer = !(((units _groupUnderCursor) select {isPlayer _x}) isEqualTo []);

if (_doesGroupContainAnyPlayer) then
{
	[localize "STR_AMAE_CANNOT_BE_APPLIED_ON_GROUPS_WITH_PLAYERS"] call Achilles_fnc_showZeusErrorMessage;
}
else
{
	private _dialogResult =
	[
		localize "STR_AMAE_GARRISON_INSTANT",
		[
			["TEXT", localize "STR_AMAE_RADIUS", [], "150"],
			["COMBOBOX", localize "STR_AMAE_INSIDE_ONLY", [localize "STR_AMAE_NO", localize "STR_AMAE_YES"]],
			["COMBOBOX", localize "STR_AMAE_FILL_EVENLY", [localize "STR_AMAE_NO", localize "STR_AMAE_YES"]]
		]
	] call Achilles_fnc_showChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	_dialogResult params ["_radius", "_insideOnly", "_fillEvenly"];

	_radius = parseNumber _radius;
	_insideOnly = _insideOnly == 1;
	_fillEvenly = _fillEvenly == 1;

	_groupUnderCursor setVariable ["Achilles_var_inGarrison", true, true];
	
	if (local _groupUnderCursor) then
	{
		[(getPos _logic), (units _groupUnderCursor), _radius, _insideOnly, _fillEvenly] call Achilles_fnc_instantBuildingGarrison;
	}
	else
	{
		[(getPos _logic), (units _groupUnderCursor), _radius, _insideOnly, _fillEvenly] remoteExecCall ["Achilles_fnc_instantBuildingGarrison", leader _groupUnderCursor];
	};

	[localize "STR_AMAE_GARRISONED_NEAREST_BUILDINGS"] call Ares_fnc_showZeusMessage;
};

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
