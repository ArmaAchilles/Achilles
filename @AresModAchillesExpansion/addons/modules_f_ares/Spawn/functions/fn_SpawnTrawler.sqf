#include "\achilles\modules_f_ares\module_header.hpp"

private _model = "C_Boat_Civil_04_F" createVehicle (position _logic);
[[_model]] call Ares_fnc_AddUnitsToCurator;

#include "\achilles\modules_f_ares\module_footer.hpp"
