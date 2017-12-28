#include "\achilles\modules_f_ares\module_header.hpp"

private _groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;

//Broadcast search building function
if (isNil "Achilles_var_search_building_init_done") then
{
	publicVariable "Ares_fnc_SearchBuilding";
	Achilles_var_search_building_init_done = true;
};

[localize "STR_AMAE_SEARCH_GARRISONED_NEAREST_BUILDING"] call Ares_fnc_showZeusMessage;

_groupUnderCursor setVariable ["Achilles_var_inGarrison", true, true];

if (local _groupUnderCursor) then
{
    [_groupUnderCursor, 50, "NEAREST", getPos _logic, true, true, true, false] call Ares_fnc_SearchBuilding;
} else
{
    [_groupUnderCursor, 50, "NEAREST", getPos _logic, true, true, true, false] remoteExec ["Ares_fnc_SearchBuilding", leader _groupUnderCursor];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
