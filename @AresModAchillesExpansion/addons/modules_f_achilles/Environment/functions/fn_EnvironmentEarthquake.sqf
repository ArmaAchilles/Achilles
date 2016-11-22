#include "\achilles\modules_f_ares\module_header.hpp"

private ['_radius','_dialogResult','_epicenter','_units'];
_epicenter = position _logic;

_dialogResult =
[
	localize "STR_EARTHQUAKE",
	[
		[localize "STR_INTENSITY",
		[
			localize "STR_VERY_WEAK",
			localize "STR_WEAK",
			localize "STR_MEDIUM",
			localize "STR_STRONG"
		]],
		[format ["%1 [m]", localize "STR_RANGE"],"","100"],
		[localize "STR_DESTROY_BUILDINGS", [localize "STR_YES", localize "STR_NO"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_radius = parseNumber (_dialogResult select 1);
_units = (_epicenter nearEntities ['Man',_radius]) select {_x in allPlayers};
if (not (player in _units)) then {_units pushBack player};
[(_dialogResult select 0) + 1] remoteExec ['BIS_fnc_earthquake',_units,false];
sleep ((random 3) + 5);
// if destroy buildings is allowed
if (_dialogResult select 2 == 0) then
{
	_buildings = nearestObjects [_epicenter, ["Building"], _radius];
	// extend of destruction is exponential: 50% (strong), 18% (medium), 7% (weak), 2% (very weak)
	_extend_count = round ((count _buildings) * (exp ((_dialogResult select 0) - 3)) / 2);
	for "_i" from 1 to _extend_count do
	{
		_building = _buildings select (floor random count _buildings);
		_building setDamage 1;
		_buildings = _buildings - [_building];
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
