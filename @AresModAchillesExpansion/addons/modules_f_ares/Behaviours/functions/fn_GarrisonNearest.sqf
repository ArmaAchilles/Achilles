#include "\achilles\modules_f_ares\module_header.hpp"

//Broadcast search building function
if (isNil "Achilles_var_zen_occupy_house_init_done") then
{
	publicVariable "Ares_fnc_ZenOccupyHouse";
	Achilles_var_zen_occupy_house_init_done = true;
};

private _groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;

private _doesGroupContainAnyPlayer = false;
{
	if (isPlayer _x) exitWith { _doesGroupContainAnyPlayer = true; };
} forEach (units _groupUnderCursor);

if (_doesGroupContainAnyPlayer) then
{
	// error message
	playSound "FD_Start_F";
	[objnull, "Cannot garrison groups containing playable units."] call bis_fnc_showCuratorFeedbackMessage;
}
else
{
	private _unitCount = count (units _groupUnderCursor);
	private _fillEvenly = if (_unitCount >= 8) then {true} else {false};
	
	if (local _groupUnderCursor) then
	{
		[(getPos _logic), (units _groupUnderCursor), 150, true, _fillEvenly] call Ares_fnc_ZenOccupyHouse;
	} else
	{
		[(getPos _logic), (units _groupUnderCursor), 150, true, _fillEvenly] remoteExec ["Ares_fnc_ZenOccupyHouse", leader _groupUnderCursor];
	};
	[objnull, "Garrisoned nearest building."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
