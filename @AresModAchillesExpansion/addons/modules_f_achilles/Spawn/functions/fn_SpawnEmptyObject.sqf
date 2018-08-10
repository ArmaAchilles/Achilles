#include "\achilles\modules_f_ares\module_header.h"

private _centerPos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_SPAWN_EMPTY_OBJECT",
	[
		[localize "STR_AMAE_CATEGORY",[localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_SUBCATEGORY", [localize "STR_AMAE_LOADING_"]],
		[localize "STR_AMAE_OBJECT", [localize "STR_AMAE_LOADING_"]]
	],
	"Achilles_fnc_RscDisplayAttributes_SpawnEmptyObject"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _objectClass = Achilles_var_emptyObject;
private _object = _objectClass createVehicle _centerPos;
[[_object], true] call Ares_fnc_AddUnitsToCurator;

#include "\achilles\modules_f_ares\module_footer.h"
