#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	localize "STR_AMAE_HINT",
	[
		[
			localize "STR_AMAE_HINTTYPE", [ "Hint",  "HintSilent", "HintCadet"]
		],
		[
			localize "STR_AMAE_MESSAGE", "MESSAGE"
		]	
	]
] call Ares_fnc_ShowChooseDialog;

if ((_dialogResult select 0) isEqualTo []) exitWith {};

switch (_dialogResult select 0) do 
{
	case 0: 
	{
		parseText (_dialogResult select 1) remoteExec ["hint", 0];
	};
	case 1: 
	{
		parseText (_dialogResult select 1) remoteExec ["hintSilent", 0];
	};
	case 2: 
	{
		 parseText (_dialogResult select 1) remoteExec ["hintCadet", 0];
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
