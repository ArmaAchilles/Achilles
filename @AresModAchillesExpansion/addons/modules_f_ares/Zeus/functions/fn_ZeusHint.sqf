#include "\achilles\modules_f_ares\module_header.hpp"

_dialogResult = 
[
	localize "STR_HINT",
	[
		[localize "STR_MESSAGE", "MESSAGE"]
	]
] call Ares_fnc_ShowChooseDialog;

if (count (_dialogResult select 0) == 0) exitWith {};

(_dialogResult select 0) remoteExec ["Hint", 0];

#include "\achilles\modules_f_ares\module_footer.hpp"
