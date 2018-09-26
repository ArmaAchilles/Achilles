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
_dialogResult params ["_selection"];
private _ownerID = [2, clientOwner] select _selection;

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

[_object_list, _group_list, _ownerID] call Achilles_fnc_transferOwnership;
[format ["%1 %2", localize "STR_AMAE_TRANSFER_TO", _options select _selection]] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.h"
