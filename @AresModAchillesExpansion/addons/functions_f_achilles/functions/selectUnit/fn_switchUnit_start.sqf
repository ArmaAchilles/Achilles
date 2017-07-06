////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/19/17
//	VERSION: 3.0
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
if (isPlayer _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer";};
if (not alive _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed";};
if (isClass (configfile >> "CfgPatches" >> "ace_medical") and {_unit getVariable ["ACE_isUnconscious", false]}) then {_error = localize "STR_ERROR_UNIT_IS_UNCONSCIOUS";};
if (isNull _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorNull";};
if (isUAVConnected vehicle _unit) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};
if (unitIsUAV vehicle _unit) then {_error = localize "STR_ERROR_VEHICLE_IS_A_DRONE";};

if (_error != "") exitWith {[_error] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"; nil};

private _playerUnit = player;
private _damage_allowed = isDamageAllowed _playerUnit;
_unit setVariable ["Achilles_var_switchUnit_data",[name _unit, _playerUnit, _damage_allowed], true];
bis_fnc_moduleRemoteControl_unit = _unit;

private _face = face _unit;
selectPlayer _unit;
[_unit, _face] remoteExecCall ["setFace", 0];
_playerUnit disableAI "ALL";
_playerUnit enableAI "ANIM";
_playerUnit allowDamage false;

private _eh_id = _unit addEventHandler ["HandleDamage", 
{
	params ["_unit", "_selection", "_handler"];
	
	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"]) then 
		{
			[] call Achilles_fnc_switchUnit_exit;
		};
		_handler = 0.999;
	};
	_handler;
}];
_unit setVariable ["Achilles_var_switchUnit_damageEHID", _eh_id];

if(isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	_eh_id = ["ace_unconscious", {if (_this select 1 and {_this select 0 == player}) then {[] call Achilles_fnc_switchUnit_exit}}] call CBA_fnc_addEventHandler;
	_unit setVariable ["Achilles_var_switchUnit_ACEdamageEHID", _eh_id];
};