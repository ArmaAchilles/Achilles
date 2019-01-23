////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/11/16
//	VERSION: 2.0
//	FILE: Achilles\functions_f_achilles\functions\features\fn_chatter.sqf
//  DESCRIPTION: AI chatter in chat (has to be in scheduled enviornment)
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

params [["_unit", objNull, [objNull]]];

if (isNull _unit) then
{
	private _dialogResult =
	[
		(localize "STR_AMAE_CHATTER") + " (CROSSROAD):",
		[
			[localize "STR_AMAE_SIDE",
			[
				"BLUEFOR",
				"OPFOR",
				localize "STR_AMAE_INDEPENDENT",
				localize "STR_AMAE_CIVILIANS"
			]],
			[localize "STR_AMAE_MESSAGE",""
			]
		],
		"Achilles_fnc_RscDisplayAttributes_Chatter"
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	private _side = switch (_dialogResult select 0) do
	{
		case 0: {west};
		case 1: {east};
		case 2: {resistance};
		case 3: {civilian};
	};
	private _message = _dialogResult select 1;
	[[_side,"HQ"],_message] remoteExec ["sideChat",0];
} else
{
	private _name = if (isNil {_unit getVariable "Achilles_var_switchUnit_data"}) then {name _unit} else {(_unit getVariable "Achilles_var_switchUnit_data") select 0};
	private _dialogResult =
	[
		(localize "STR_AMAE_CHATTER") + format [" (%1):", _name],
		[
			[localize "STR_AMAE_CHANNEL",
			[
				localize "STR_AMAE_GLOBAL",
				localize "STR_AMAE_SIDE",
				localize "STR_AMAE_VEHICLE",
				localize "STR_AMAE_COMMAND",
				localize "STR_AMAE_ZEUS"
			]],
			[localize "STR_AMAE_MESSAGE",""
			]
		],
		"Achilles_fnc_RscDisplayAttributes_Chatter"
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	private _chat_type = switch (_dialogResult select 0) do
	{
		case 0: {'globalChat'};
		case 1: {'sideChat'};
		case 2: {'vehicleChat'};
		case 3: {'commandChat'};
		case 4:	{''};
	};
	private _message = _dialogResult select 1;

	// if zeus channel
	if (_chat_type == "") exitWith {[player,_message] remoteExec ['sideChat',0];};


	_message = "(" + (_name) + " [" + localize "STR_AMAE_AI" + "]) " + _message;

	[_unit,_message] remoteExec [_chat_type,0];
};
