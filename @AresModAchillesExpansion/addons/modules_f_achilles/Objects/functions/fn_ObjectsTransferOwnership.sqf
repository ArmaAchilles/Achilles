////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 8/26/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsTransferOwnership.sqf
//  DESCRIPTION: Function for the module "transfer ownership"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.h"

private _objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];
private _options = [localize "STR_AMAE_SERVER", localize "STR_AMAE_ZEUS"];

private _dialogResult =
[
	localize "STR_AMAE_TRANSFER_OWNERSHIP",
	[
		[
			localize "STR_AMAE_TRANSFER_TO", _options
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
private _owner = _dialogResult select 0;

if (isNull (_objects select 0)) then { _objects = [localize "STR_AMAE_OBJECTS"] call Achilles_fnc_SelectUnits };
if (isNil "_objects") exitWith {};
if (_objects isEqualTo []) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

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
	// save the unit loadout
	{
		{
			if (alive _x) then
			{
				_x setVariable ["Achilles_var_tmpLoadout", getUnitLoadout _x, true];
			};
		} forEach units _x;
	} forEach _group_list;
	[
		[_object_list,_group_list],
		{
			params ["_object_list", "_group_list"];
			// change ownership
			{_x setOwner 2} forEach _object_list;
			{_x setGroupOwner 2} forEach _group_list;
			// reset the unit loadout as soon as they have become local
			waitUntil {sleep 1; ({not local _x} count _group_list == 0) or {({not isNull _x} count _group_list == 0) or {{{alive _x} count units _x > 0} count _group_list == 0}}};
			{
				{
					private _loadout = _x getVariable ["Achilles_var_tmpLoadout", []];
					if !(_loadout isEqualTo []) then
					{
						_x setUnitLoadout _loadout;
					};
					_x setVariable ["Achilles_var_tmpLoadout", nil, true];
				} forEach units _x;
			} forEach _group_list;
		}, 2
	] call Achilles_fnc_spawn;
}
else
{
	// transfer ownership to Zeus
	[
		[clientOwner,_object_list,_group_list],
		{
			params ["_zeusOwnerId", "_object_list", "_group_list"];
			// save the unit loadout
			{
				{
					if (alive _x) then
					{
						_x setVariable ["Achilles_var_tmpLoadout", getUnitLoadout _x, true];
					};
				} forEach units _x;
			} forEach _group_list;
			// change ownership
			{_x setOwner _zeusOwnerId} forEach _object_list;
			{_x setGroupOwner _zeusOwnerId} forEach _group_list;
		}, 2
	] call Achilles_fnc_spawn;
	// reset the unit loadout as soon as they have become local
	waitUntil {sleep 1; ({not local _x} count _group_list == 0) or {({not isNull _x} count _group_list == 0) or {{{alive _x} count units _x > 0} count _group_list == 0}}};
	{
		{
			private _loadout = _x getVariable ["Achilles_var_tmpLoadout", []];
			if !(_loadout isEqualTo []) then
			{
				_x setUnitLoadout _loadout;
			};
			_x setVariable ["Achilles_var_tmpLoadout", nil, true];
		} forEach units _x;
	} forEach _group_list;
};
[localize "STR_AMAE_TRANSFER_TO" + " " + (_options select _owner)] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.h"
