#include "\achilles\modules_f_ares\module_header.hpp"

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
[Achilles_fnc_switchUnit_start, [_unit]] call CBA_fnc_directCall;

#include "\achilles\modules_f_ares\module_footer.hpp"
