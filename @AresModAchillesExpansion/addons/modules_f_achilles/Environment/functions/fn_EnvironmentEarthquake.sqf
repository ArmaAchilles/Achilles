#include "\achilles\modules_f_ares\module_header.h"

private ['_radius','_dialogResult','_epicenter','_units'];
_epicenter = position _logic;

_dialogResult =
[
	localize "STR_AMAE_EARTHQUAKE",
	[
		[localize "STR_AMAE_INTENSITY",
		[
			localize "STR_AMAE_VERY_WEAK",
			localize "STR_AMAE_WEAK",
			localize "STR_AMAE_MEDIUM",
			localize "STR_AMAE_STRONG"
		]],
		[localize "STR_AMAE_RANGE","","100"],
		[localize "STR_AMAE_DAMAGE_BUILDINGS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_radius = parseNumber (_dialogResult select 1);
_units = (_epicenter nearEntities ['Man',_radius]) select {_x in allPlayers};
if (!(player in _units)) then {_units pushBack player};
[(_dialogResult select 0) + 1] remoteExec ['BIS_fnc_earthquake',_units,false];
sleep ((random 3) + 5);
// if destroy buildings is allowed
if (_dialogResult select 2 == 0) then
{
	private _buildings = nearestObjects [_epicenter, ["Building"], _radius, true];
	// extend of destruction is exponential: 50% (strong), 18% (medium), 7% (weak), 2% (very weak)
	private _extend_count = round ((count _buildings) * (exp ((_dialogResult select 0) - 3)) / 2);
	for "_i" from 1 to _extend_count do
	{
		private _building = selectRandom _buildings;
		_building setDamage 1;
		_buildings = _buildings - [_building];
	};
};

#include "\achilles\modules_f_ares\module_footer.h"
