////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/11/16
//	VERSION: 2.0
//	FILE: achilles\functions_f\functions\features\fn_chatter.sqf
//  DESCRIPTION: AI chatter in chat
//
//	ARGUMENTS:
//	_this select 0:				OBJECT	- unit that chatter; if ObjNull then HQ chatters
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit] call Achilles_fnc_chatter;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_chat_type","_side"];

_unit = param [0,ObjNull,[ObjNull]];

if (isNull _unit) then
{
	_dialogResult =
	[
		(localize "STR_CHATTER") + " (CROSSROAD):",
		[
			[localize "STR_SIDE",
			[
				"BLUEFOR",
				"OPFOR",
				localize "STR_INDEPENDENT",
				localize "STR_CIVILIANS"
			]],
			[localize "STR_MESSAGE",""
			]
		],
		"Achilles_fnc_RscDisplayAttributes_Chatter"
	] call Ares_fnc_ShowChooseDialog;

	if (count _dialogResult == 0) exitWith {};
	
	switch (_dialogResult select 0) do
	{
		case 0: {_side = west;};
		case 1: {_side = east;};
		case 2: {_side = resistance;};
		case 3: {_side = civilian;};
	};
	_message = _dialogResult select 1;
	[[_side,"HQ"],_message] remoteExec ["sideChat",0];
} else
{
	_dialogResult =
	[
		(localize "STR_CHATTER") + format [" (%1):", name _unit],
		[
			[localize "STR_CHANNEL",
			[
				localize "STR_GLOBAL",
				localize "STR_SIDE",
				localize "STR_VEHICLE",
				localize "STR_COMMAND",
				localize "STR_ZEUS"
			]],
			[localize "STR_MESSAGE",""
			]
		],
		"Achilles_fnc_RscDisplayAttributes_Chatter"
	] call Ares_fnc_ShowChooseDialog;

	if (count _dialogResult == 0) exitWith {};

	_chat_type = switch (_dialogResult select 0) do
	{
		case 0: {'globalChat'};
		case 1: {'sideChat'};
		case 2: {'vehicleChat'};
		case 3: {'commandChat'};
		case 4:	{''};
	};
	_message = _dialogResult select 1;
	
	// if zeus channel
	if (_chat_type == "") exitWith {[player,_message] remoteExec ['sideChat',0];};
	
	if (!isPlayer _unit) then
	{
		_message = "(" + (name _unit) + " [" + localize "STR_AI" + "]) " + _message; 
	};
	[_unit,_message] remoteExec [_chat_type,0];
};
