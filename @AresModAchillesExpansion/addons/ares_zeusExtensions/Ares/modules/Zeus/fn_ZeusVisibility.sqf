#include "\ares_zeusExtensions\Ares\module_header.hpp"

_dialogResult = 
[
	localize "STR_HIDE_ZEUS",
	[
		[
			localize "STR_HIDE_ZEUS", [localize "STR_TRUE", localize "STR_False"]
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_invisible = if ((_dialogResult select 0) == 0) then {true} else {false};
_display_text = if ((_dialogResult select 0) == 0) then {localize "STR_ZEUS_IS_NOW_HIDDEN"} else {localize "STR_ZEUS_IS_NOW_VISIBLE"};

[player, _invisible] call Ares_fnc_MakePlayerInvisible;
[_display_text] call Ares_fnc_ShowZeusMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
