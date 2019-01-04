#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _model = "Submarine_01_F" createVehicle (position _logic);
[[_model]] call Ares_fnc_AddUnitsToCurator;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
