/*
	Function:
		Achilles_fnc_switchUnit_exit
	
	Authors:
		Kex
	
	Description:
		terminates "Achilles_fnc_switchUnit_start"
	
	Parameters:
		_unitDies	- <BOOLEAN> [false] True if the unit dies after the exit.
	
	Returns:
		nothing
	
	Exampes:
		(begin example)
		[] call Achilles_fnc_switchUnit_exit;
		(end)
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params
[
	["_unitDies", false, [false]]
];

private _unit = bis_fnc_moduleRemoteControl_unit;
if (isNull _unit) exitWith {bis_fnc_moduleRemoteControl_unit = nil};
(_unit getVariable "Achilles_var_switchUnit_data") params ["_","_playerUnit","_damageAllowed", "_face", "_speaker", "_goggles"];
if (isNull _playerUnit) exitWith {_unit setVariable ["Achilles_var_switchUnit_data", nil, true]};
// reset camera positions
private _unitPos = getposatl _unit;
private _camPos = [_unitPos,10,direction _unit + 180] call bis_fnc_relpos;
_camPos set [2,(_unitPos select 2) + (getterrainheightasl _unitPos) - (getterrainheightasl _camPos) + 10];
(getassignedcuratorlogic _playerUnit) setvariable ["bis_fnc_modulecuratorsetcamera_params",[_camPos,_unit]];
_unit removeEventHandler ["HandleDamage", _unit getVariable "Achilles_var_switchUnit_damageEHID"];

// remove actions
private _addActionID = _unit getVariable ["Achilles_var_switchUnit_addAction", nil];
if (!isNil "_addActionID") then {_unit removeAction _addActionID};
_addActionID = _unit getVariable ["Achilles_var_switchUnit_addBreachDoorAction", nil];
if (!isNil "_addActionID") then {[_unit, _addActionID] call BIS_fnc_holdActionRemove};

if(isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	private _eh_id = _unit getVariable ["Achilles_var_switchUnit_ACEdamageEHID", -1];
	if (_eh_id != -1) then 
	{
		["ace_unconscious", _eh_id] call CBA_fnc_removeEventHandler;
		_unit setVariable ["Achilles_var_switchUnit_ACEdamageEHID", nil];
	};
};
selectPlayer _playerUnit;
_playerUnit enableAI "ALL";
_playerUnit allowDamage _damageAllowed;
// open curator interface and reset position on map
openCuratorInterface;
private _curatorMapCtrl = ((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP);
_curatorMapCtrl ctrlMapAnimAdd [0, 0.1, _camPos]; 
ctrlMapAnimCommit _curatorMapCtrl;
[_unit, _face] remoteExecCall ["setFace", 0];
[_unit, _speaker] remoteExecCall ["setSpeaker", 0];
_unit addGoggles _goggles;
_unit setVariable ["Achilles_var_switchUnit_data", nil, true];
bis_fnc_moduleRemoteControl_unit = nil;
if (_unitDies) then {_unit setDamage 1};
