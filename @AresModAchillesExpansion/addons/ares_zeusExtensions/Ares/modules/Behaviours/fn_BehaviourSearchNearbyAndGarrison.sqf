#include "\ares_zeusExtensions\Ares\module_header.hpp"

_groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;

_codeBlock = compile preprocessFileLineNumbers '\ares_zeusExtensions\Ares\functions\fn_SearchBuilding.sqf';
[_codeBlock, [_groupUnderCursor, 50, "NEAREST", getPos _logic, true, true, true, false]] call Ares_fnc_BroadcastCode;
[objnull, "Units will search and then garrison nearby building."] call bis_fnc_showCuratorFeedbackMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
