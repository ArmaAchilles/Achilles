#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	localize "STR_AMAE_HINT",
	[
		[
			localize "STR_AMAE_HINT_TYPE", [localize "STR_AMAE_HINT",  localize "STR_AMAE_HINT_SILENT", localize "STR_AMAE_HINT_CADET"]
		],
		[
			localize "STR_AMAE_MESSAGE", "MESSAGE"
		]	
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_hintType", "_message"];

switch (_hintType) do 
{
	case 0: 
	{
		[parseText _message] remoteExecCall ["hint", 0];
	};
	case 1: 
	{
		[parseText _message] remoteExecCall ["hintSilent", 0];
	};
	case 2: 
	{
		[parseText _message] remoteExecCall ["hintCadet", 0];
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
