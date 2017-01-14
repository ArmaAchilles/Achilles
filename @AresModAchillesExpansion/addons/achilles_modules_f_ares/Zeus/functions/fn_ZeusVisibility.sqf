////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: by Anton Struyk, modified by Kex
//	DATE: 1/4/17
//	VERSION: 2.0
//  DESCRIPTION: Function for module "hide zeus"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

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

if (_invisible and not (isObjectHidden player)) then 
{
	[player, true] remoteExec ["hideObjectGlobal",2];
	player allowDamage false;
	player setCaptive true;
} else
{
	if (not _invisible and (isObjectHidden player)) then
	{
		[player, false] remoteExec ["hideObjectGlobal",2];
		player allowDamage true;
		player setCaptive false;		
	};
};

[_display_text] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
