////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/6/17
//	VERSION: 1.0
//  DESCRIPTION: application of "selectPlayer" script command.
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- Unit to switch to.
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit] call Achilles_fnc_switchUnit_start;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _error = "";
private _unit = effectiveCommander (param [0]);
if (not (side group _unit in [east,west,resistance,civilian])) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorEmpty";};
if (isplayer _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer";};
if (not alive _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed";};
if (isnull _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorNull";};
if (isuavconnected vehicle _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};

if (_error != "") exitWith {[_error] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

private _playerUnit = player;
_unit setVariable ["Achilles_var_switchUnit_data",[name _unit, _playerUnit], true];
bis_fnc_moduleRemoteControl_unit = _unit;

selectPlayer _unit;
_playerUnit disableAI "ALL";
_playerUnit enableAI "ANIM";

private _eh_id = _unit addEventHandler ["HandleDamage", 
{
	params ["_unit", "_selection", "_handler"];
	
	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"]) then 
		{
			[] call Achilles_fnc_switchUnit_exit;
			_unit setDamage 1;
		};
		_handler = 0.999;
	};
	_handler;
}];
_unit setVariable ["Achilles_var_switchUnit_damageEHID", _eh_id];

_eh_id = _playerUnit addEventHandler ["HandleDamage", 
{
	params ["_playerUnit", "_selection", "_handler"];
	
	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"]) then 
		{
			[] call Achilles_fnc_switchUnit_exit;
			_playerUnit setDamage 1;
		};
		_handler = 0.999;
	};
	_handler;
}];
_playerUnit setVariable ["Achilles_var_switchUnit_damageEHID", _eh_id];