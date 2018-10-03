////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/3/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsSetHeight.sqf
//  DESCRIPTION: Function for the module "change height"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

private _dialogResult =
[
	localize "STR_AMAE_CHANGE_HEIGHT",
	[
		[(localize "STR_AMAE_HEIGHT") + " [m]", "","0"]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _height = parseNumber (_dialogResult select 0);

if (isNull (_objects select 0)) then { _objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits };
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};;
{
	[_x,_height] spawn
	{
		private _object = _this select 0;
		_height = _this select 1;
		private _pos = getPosWorld _object;
		_pos set [2,(_pos select 2) + _height];
		_object setPosWorld _pos;
	};
} forEach _objects;


#include "\achilles\modules_f_ares\module_footer.inc.sqf"
