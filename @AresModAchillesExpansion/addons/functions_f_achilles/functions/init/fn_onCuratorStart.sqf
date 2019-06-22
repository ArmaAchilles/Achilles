////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/26/17
//	VERSION: 5.0
//  DESCRIPTION: Initalization function; this function is called when the curator display is loaded for the first time
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params [["_tree_ctrl", controlNull, [controlNull]]];

// broadcast safe spawn
publicVariable "Achilles_fnc_spawn";
publicVariable "Achilles_fnc_spawn_remote";

//prevent drawing mines
if (!(missionnamespace getvariable ["bis_fnc_drawMinefields_active",false])) then
{
	missionnamespace setvariable ["bis_fnc_drawMinefields_active", true, true];
};

// Initialize settings variables
Achilles_var_reloadDisplay = nil;
Achilles_var_reloadVisionModes = nil;

// Enable the selected VisionModes for Zeus
call Achilles_fnc_setCuratorVisionModes;

// Add curator event handlers
private _curatorModule = getassignedcuratorLogic player;
_curatorModule addEventHandler ["CuratorObjectPlaced", { _this call Achilles_fnc_HandleCuratorObjectPlaced; }];
_curatorModule addEventHandler ["CuratorGroupPlaced", { _this call Achilles_fnc_HandleCuratorGroupPlaced; }];
_curatorModule addEventHandler ["CuratorObjectEdited", {_this call Achilles_fnc_HandleCuratorObjectEdited; }];
_curatorModule addEventHandler ["CuratorObjectDeleted", {_this call Achilles_fnc_HandleCuratorObjectDeleted; }];
_curatorModule addEventHandler ["CuratorWaypointPlaced", {_this call Achilles_fnc_HandleCuratorWpPlaced; }];

// Handle Disconnect
[[],
{
	addMissionEventHandler ["HandleDisconnect",{
		params ["_unit"];

		// if player was a promoted Zeus
		private _module =  _unit getVariable ["Achilles_var_promoZeusModule", objNull];
		if (!isNull _module) then {(group _module) deleteGroupWhenEmpty true; deleteVehicle _module};

		if (!isNil {_unit getVariable "Achilles_var_switchUnit_data"}) exitWith
		{
			// if unit was controlled by Zeus with "select player"
			private _playerUnit = (_unit getVariable "Achilles_var_switchUnit_data") select 1;
			deleteVehicle _playerUnit;
			_unit setVariable ["Achilles_var_switchUnit_data", nil, true];
			true
		};
		false
	}]
}, 2] call Achilles_fnc_spawn;

// reset map position
private _camPos = position curatorCamera;
private _curatorMapCtrl = ((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP);
_curatorMapCtrl ctrlMapAnimAdd [0, 0.1, _camPos];
ctrlMapAnimCommit _curatorMapCtrl;

// Unlock all available attributes
// _curatorModule setVariable ["BIS_fnc_curatorAttributesplayer",["%ALL"]];
// _curatorModule setVariable ["BIS_fnc_curatorAttributesobject",["%ALL"]];
// _curatorModule setVariable ["BIS_fnc_curatorAttributesgroup",["%ALL"]];
// _curatorModule setVariable ["BIS_fnc_curatorAttributeswaypoint",["%ALL"]];
// _curatorModule setVariable ["BIS_fnc_curatorAttributesmarker",["%ALL"]];
