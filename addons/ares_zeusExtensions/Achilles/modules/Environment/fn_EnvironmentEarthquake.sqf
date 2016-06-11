#include "\ares_zeusExtensions\Ares\module_header.hpp"

private ['_radius','_dialogResult','_epicenter','_units'];
_epicenter = position _logic;

_dialogResult =
[
	"Earthquake:",
	[
		["Intensity:",
		[
			"very week",
			"week",
			"medium",
			"strong"
		]],
		["Range:",
		[
			"500 meters",
			"1 kilometer",
			"2 kilometers",
			"3 kilometers",
			"5 kilometers"
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
