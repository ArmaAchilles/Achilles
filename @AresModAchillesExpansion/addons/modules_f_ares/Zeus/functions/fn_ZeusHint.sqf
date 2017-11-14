#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	localize "STR_HINT",
	[
		[localize "STR_MESSAGE", "MESSAGE"]
	]
] call Ares_fnc_ShowChooseDialog;

if ((_dialogResult select 0) isEqualTo []) exitWith {};

(parseText (_dialogResult select 0)) remoteExec ["Hint", 0];

#include "\achilles\modules_f_ares\module_footer.hpp"
