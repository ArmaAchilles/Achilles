////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/26/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsTransferOwnership.sqf
//  DESCRIPTION: Function for the module "transfer ownership"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];
private _options = [localize "STR_SERVER", localize "STR_ZEUS"];

private _dialogResult =
[
	localize "STR_TRANSFER_OWNERSHIP",
	[
		[
			localize "STR_TRANSFER_TO", _options
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _owner = _dialogResult select 0;

if (isNull (_objects select 0)) then { _objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits };
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

private _object_list = [];
private _group_list = [];
{
	if (_x isKindOf "Man") then
	{
		private _group = group _x;
		if (!(_group in _group_list)) then
		{
			_group_list pushBack _group;
		};
	} else
	{
		_object_list pushBack _x;
	};
} forEach _objects;

if (_owner == 0) then
{
	// transfer ownership to server
	[[_object_list,_group_list],{ {_x setOwner 2} forEach (_this select 0); {_x setGroupOwner 2} forEach (_this select 1)},2] call Achilles_fnc_spawn;
} else
{
	// transfer ownership to zeus
	[[player,_object_list,_group_list],{_owner = owner (_this select 0); {_x setOwner _owner} forEach (_this select 1); {_x setGroupOwner _owner} forEach (_this select 2)},2] call Achilles_fnc_spawn;
};
[localize "STR_TRANSFER_TO" + " " + (_options select _owner)] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
