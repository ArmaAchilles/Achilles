////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/14/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Buildings\fn_BuildingsDestroy.sqf
//  DESCRIPTION: Function for destroing buildings
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\ares_zeusExtensions\Ares\module_header.hpp"

private ["_buildings","_extend_count"];

_center_pos = position _logic;

_extend = [];
for "_i" from 1 to 10 do
{
	_extend pushBack (str (_i * 10) + "%");
};

_dialogResult = 
[
	localize "STR_DESTROY_BUILDINGS",
	[
		[localize "STR_SELECTION", [localize "STR_NEAREST", localize "STR_RANGE"]],
		[localize "STR_EXTEND",_extend],
		[(localize "STR_RANGE") + " [m]","","100"]
	],
	"Ares_fnc_RscDisplayAttributes_BuildingsDestroy"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

switch (_dialogResult select 0) do
{
	case 0:	
	{
		_buildings = [nearestObject  [_center_pos, "Building"]];
		_extend_count = 1;
	};
	case 1: 
	{
		_buildings = nearestObjects [_center_pos, ["Building"], parseNumber (_dialogResult select 2)];
		_extend_count = round ((count _buildings) * ((_dialogResult select 1) + 1) / 10);
	};
};

for "_i" from 1 to _extend_count do
{
	_building = _buildings select (floor random count _buildings);
	_building setDamage 1;
	_buildings = _buildings - [_building];
};


#include "\ares_zeusExtensions\Ares\module_footer.hpp"
