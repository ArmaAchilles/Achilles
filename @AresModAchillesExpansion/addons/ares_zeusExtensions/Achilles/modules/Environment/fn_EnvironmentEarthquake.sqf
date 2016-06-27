#include "\ares_zeusExtensions\Ares\module_header.hpp"

private ['_radius','_dialogResult','_epicenter','_units'];
_epicenter = position _logic;

_dialogResult =
[
	localize "STR_EARTHQUAKE",
	[
		[localize "STR_INTENSITY",
		[
			localize "STR_VERY_WEEK",
			localize "STR_WEEK",
			localize "STR_MEDIUM",
			localize "STR_STRONG"
		]],
		[localize "STR_RANGE",
		[
			"500 m",
			"1 km",
			"2 km",
			"3 km",
			"5 km"
		]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

switch (_dialogResult select 1) do
{
	case 0: {_radius = 500;};
	case 1: {_radius = 1000;};
	case 2: {_radius = 2000;};
	case 3: {_radius = 3000;};
	case 4: {_radius = 5000;};
};
_units = [{_this in allPlayers},(_epicenter nearEntities ['Man',_radius])] call Achilles_fnc_filter;
if (not (player in _units)) then {_units pushBack player};
[(_dialogResult select 0) + 1] remoteExec ['BIS_fnc_earthquake',_units,false];
sleep ((random 3) + 5);
[_epicenter, _radius, (random 1000), []] call BIS_fnc_destroyCity;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
