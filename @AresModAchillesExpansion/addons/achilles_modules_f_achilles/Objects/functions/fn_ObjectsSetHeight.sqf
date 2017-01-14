////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/3/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsSetHeight.sqf
//  DESCRIPTION: Function for the module "change height"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

_objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

_dialogResult = 
[
	localize "STR_CHANGE_HEIGHT",
	[
		[(localize "STR_HEIGHT") + " [m]", "","0"]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_height = parseNumber (_dialogResult select 0);

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};;
{
	[_x,_height] spawn 
	{
		_object = _this select 0;
		_height = _this select 1;
		_pos = getPosWorld _object;
		_pos set [2,(_pos select 2) + _height];
		_object setPosWorld _pos;
	};
} forEach _objects;


#include "\achilles\modules_f_ares\module_footer.hpp"