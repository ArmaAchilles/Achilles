////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/6/17
//	VERSION: 1.0
//  DESCRIPTION: terminates "Achilles_fnc_switchUnit_start".
//
//	ARGUMENTS:
//	nothing
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[] call Achilles_fnc_switchUnit_exit;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _unit = bis_fnc_moduleRemoteControl_unit;
if (isNull _unit) exitWith {bis_fnc_moduleRemoteControl_unit = nil};
private _playerUnit = (_unit getVariable "Achilles_var_switchUnit_data") select 1;
if (isNull _playerUnit) exitWith {_unit setVariable ["Achilles_var_switchUnit_data", nil, true]};
private _unitPos = getposatl _unit;
private _camPos = [_unitPos,10,direction _unit + 180] call bis_fnc_relpos;
_camPos set [2,(_unitPos select 2) + (getterrainheightasl _unitPos) - (getterrainheightasl _camPos) + 10];
(getassignedcuratorlogic _playerUnit) setvariable ["bis_fnc_modulecuratorsetcamera_params",[_camPos,_unit]];
_unit removeEventHandler ["HandleDamage", _unit getVariable "Achilles_var_switchUnit_damageEHID"];
_playerUnit removeEventHandler ["HandleDamage", _playerUnit getVariable "Achilles_var_switchUnit_damageEHID"];
selectPlayer _playerUnit;
_playerUnit enableAI "ALL";
openCuratorInterface;
_unit setVariable ["Achilles_var_switchUnit_data", nil, true];
bis_fnc_moduleRemoteControl_unit = nil;