#include "\achilles\modules_f_ares\module_header.hpp"

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
	_unitCount = count (units _groupUnderCursor);
	if (_unitCount >= 8) then {
		[(getPos _logic), (units _groupUnderCursor), 150, true, true] call Ares_fnc_ZenOccupyHouse;
	} else {
		[(getPos _logic), (units _groupUnderCursor), 150, true, false] call Ares_fnc_ZenOccupyHouse;
	}
	[objnull, "Garrisoned nearest building."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
