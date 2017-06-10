////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/10/17
//	VERSION: 1.0
//  DESCRIPTION: Adds an event handler to the curator interface
//
//	ARGUMENTS:
//	_this select 0:		STRING	- event handler type
//	_this select 1:		CODE	- code executed in unscheduled environment when the event handler is triggered (available params: _this select 0: curator display)
//
//	RETURNS:
//	_this				SCALAR	- positive scalar id of the event handler; -1 if it failed
//
//	Example:
//	["onLoad", {systemChat "Hello World!"}] call Achilles_fnc_addCuratorInterfaceEventHandler;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_type", "_code"];
private _curator = getAssignedCuratorLogic player;
private _id = -1;
if (isNull _curator) exitWith {_id};

switch (toLower _type) do
{
	case "onload":
	{
		private _code_list = _curator getVariable ["Achilles_var_onLoadCuratorInterface", []];
		_id = count _code_list;
		_code_list pushBack _code;
		_curator setVariable ["Achilles_var_onLoadCuratorInterface", _code_list];
	};
	case "onunload":
	{
		private _code_list = _curator getVariable ["Achilles_var_onUnloadCuratorInterface", []];
		_id = count _code_list;
		_code_list pushBack _code;
		_curator setVariable ["Achilles_var_onUnloadCuratorInterface", _code_list];
	};
};
_id;