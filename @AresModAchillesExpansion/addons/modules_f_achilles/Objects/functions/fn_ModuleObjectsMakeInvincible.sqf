////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/17
//	VERSION: 1.0
//  DESCRIPTION: Function for the module "make invincible"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

_objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

_dialogResult = 
[
	localize "STR_MAKE_INVINCIBLE",
	[
		[localize "STR_MAKE_INVINCIBLE", [localize "STR_TRUE",localize "STR_FALSE"]],
		[localize "STR_INCLUDE_CREW", [localize "STR_TRUE",localize "STR_FALSE"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_allowDamage = if(_dialogResult select 0 == 1) then {true} else {false};
_includeCrew = if(_dialogResult select 1 == 0) then {true} else {false};

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};;

{
	_object = _x;
	if (local _object) then
	{
		_object allowDamage _allowDamage;
		if (_includeCrew) then
		{
			{_x allowDamage _allowDamage} forEach crew _object;
		};
	} else
	{
		[_object,_allowDamage] remoteExecCall ["allowDamage",_object];
		if (_includeCrew) then
		{
			{[_x,_allowDamage] remoteExecCall ["allowDamage",_x]} forEach crew _object;
		};
	};
} forEach _objects;

#include "\achilles\modules_f_ares\module_footer.hpp"