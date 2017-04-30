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
		[localize "STR_MAKE_INVINCIBLE", [localize "STR_TRUE",localize "STR_FALSE"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_makeInvincible = if(_dialogResult select 0 == 0) then {true} else {false};

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};;

if (_makeInvincible) then
{
	{
		_object = _x;
		if (local _object) then
		{
			_object removeAllEventHandlers "handleDamage";
			_object addEventHandler ["handleDamage",{false}];
		} else
		{
			[_object,"handleDamage"] remoteExecCall ["removeAllEventHandlers",_object];
			[_object, ["handleDamage",{false}]] remoteExecCall ["addEventHandler",_object];
		};
	} forEach _objects;
	
} else
{
	{
		_object = _x;
		if (local _object) then
		{
			_object removeAllEventHandlers "handleDamage";
		} else
		{
			[_object,"handleDamage"] remoteExecCall ["removeAllEventHandlers",_object];
		};
	} forEach _objects;
};

#include "\achilles\modules_f_ares\module_footer.hpp"