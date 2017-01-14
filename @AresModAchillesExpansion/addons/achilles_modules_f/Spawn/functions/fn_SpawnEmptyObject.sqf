#include "\achilles\modules_f_ares\module_header.hpp"

_centerPos = position _logic;

_dialogResult = 
[
	localize "STR_SPAWN_EMPTY_OBJECT",
	[
		[localize "STR_CATEGORY",[localize "STR_LOADING_"]],
		[localize "STR_SUBCATEGORY", [localize "STR_LOADING_"]],
		[localize "STR_OBJECT", [localize "STR_LOADING_"]]
	],
	"Achilles_fnc_RscDisplayAttributes_SpawnEmptyObject"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_objectClass = Achilles_var_emptyObject;
_object = _objectClass createVehicle _centerPos;
[[_object], true] call Ares_fnc_AddUnitsToCurator;

#include "\achilles\modules_f_ares\module_footer.hpp"