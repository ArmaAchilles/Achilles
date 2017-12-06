////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/13/16
//	VERSION: 1.0
//  DESCRIPTION: Function for the module "change altitude"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

private _dialogResult =
[
	localize "STR_AMAE_CHANGE_ALTITUDE",
	[
		[(localize "STR_AMAE_Altitude_ASL_ATL") + " [m]", "","0"];
		[(localize "STR_AMAE_ALT_CHANGE_WARNING")];
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _height = parseNumber (_dialogResult select 0);

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
{
	[_x,_height] spawn
	{
		params ["_object","_height"];
		if (_object isKindOf "Air") exitWith
		{
			if (local _object) then {_object flyInHeight _height} else {[_object,_height] remoteExec ["flyInHeight",_object]};
		};
		if (_object isKindOf "Ship") exitWith
		{
			if (local _object) then {_object swimInDepth _height} else {[_object,_height] remoteExec ["swimInDepth",_object]};
        };
	};
} forEach _objects;


#include "\achilles\modules_f_ares\module_footer.hpp"
