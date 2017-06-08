#include "\achilles\modules_f_ares\module_header.hpp"

private _unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
[_unit] call Achilles_fnc_switchUnit_start;

#include "\achilles\modules_f_ares\module_footer.hpp"
