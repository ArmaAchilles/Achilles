#include "\achilles\modules_f_ares\module_header.hpp"

//Broadcast search building function
if (isNil "Achilles_var_zen_occupy_house_init_done") then
{
	publicVariable "Ares_fnc_ZenOccupyHouse";
	Achilles_var_zen_occupy_house_init_done = true;
};

_groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;

_doesGroupContainAnyPlayer = false;
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
	if (local _groupUnderCursor) then
	{
		[(getPos _logic), (units _groupUnderCursor), 150, true, false] call Ares_fnc_ZenOccupyHouse;
	} else
	{
		[(getPos _logic), (units _groupUnderCursor), 150, true, false] remoteExec ["Ares_fnc_ZenOccupyHouse", leader _groupUnderCursor];
	};
	[objnull, "Garrisoned nearest building."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
