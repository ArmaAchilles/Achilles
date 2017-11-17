////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: by Anton Struyk, modified by Kex
//	DATE: 1/4/17
//	VERSION: 2.0
//  DESCRIPTION: Function for module "hide zeus"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult = 
[
	localize "STR_HIDE_ZEUS",
	[
		[
			localize "STR_HIDE_ZEUS", [localize "STR_YES", localize "STR_NO"]
		]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

private _invisible = (_dialogResult select 0) == 0;
private _display_text = [localize "STR_ZEUS_IS_NOW_VISIBLE", localize "STR_ZEUS_IS_NOW_HIDDEN"] select _invisible;

if (_invisible and not (isObjectHidden player)) then 
{
	[player, true] remoteExec ["hideObjectGlobal",2];
	player allowDamage false;
	player setCaptive true;
	(getAssignedCuratorLogic player) setVariable ["showNotification", true];
}
else
{
	if (not _invisible and (isObjectHidden player)) then
	{
		[player, false] remoteExec ["hideObjectGlobal",2];
		player allowDamage true;
		player setCaptive false;
		(getAssignedCuratorLogic player) setVariable ["showNotification", false];
	};
};

[_display_text] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
