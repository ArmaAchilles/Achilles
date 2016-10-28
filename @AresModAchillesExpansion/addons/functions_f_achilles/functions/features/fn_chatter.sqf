////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/5/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_chatter.sqf
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
		"Chatter (CROSSROAD):",
		[
			["Side:",
			[
				"west",
				"east",
				"independent",
				"civilian"
			]],
			["Message:",""
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
		format ["Chatter (%1):", name _unit],
		[
			["Channel:",
			[
				"global",
				"side",
				"vehicle chat",
				"command chat"
			]],
			["Message:",""
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
	};
	_message = _dialogResult select 1;
	if (!isPlayer _unit) then
	{
		_message = "(" + (name _unit) + " [AI]) " + _message; 
	};
	[_unit,_message] remoteExec [_chat_type,0];
};
