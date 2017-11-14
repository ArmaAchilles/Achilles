#include "\achilles\modules_f_ares\module_header.hpp"

#define SIDES [sideLogic,east,west,independent,civilian]

private _old_side = side player;
localize "STR_ZEUS_HAS_LEFT_SIDE_CHANNEL" remoteExec ['hint', _old_side];

private _dialogResult =
[
	localize "STR_SWITCH_SIDE_CHANNEL_OF_ZEUS",
	[
		[localize "STR_SIDE", "ALLSIDE"]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

private _side_index = _dialogResult select 0;

[player,_side_index] call Achilles_fnc_SwitchZeusSide;

private _new_side = SIDES select _side_index;

localize "STR_ZEUS_HAS_ENTERED_SIDE_CHAT" remoteExec ['hint', _new_side];

#include "\achilles\modules_f_ares\module_footer.hpp"
