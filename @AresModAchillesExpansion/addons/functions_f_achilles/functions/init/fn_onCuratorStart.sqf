////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/26/17
//	VERSION: 5.0
//  DESCRIPTION: Initalization function; this function is called when the curator display is loaded for the first time
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private _tree_ctrl = param [0,controlNull,[controlNull]];

private _display_reload = false;

// broadcast safe spawn
publicVariable "Achilles_fnc_spawn_remote";

// trick to unlock ares/achilles modules for Zeus if mission was not set up properly
if (not ("achilles_modules_f_achilles" in (curatorAddons getAssignedCuratorLogic player))) then
{
	private _logic = (createGroup sideLogic) createUnit ["Achilles_Module_Base", getPos player, [], 0, "NONE"];
	_logic = (createGroup sideLogic) createUnit ["Ares_Module_Base", getPos player, [], 0, "NONE"];
	
	// wait until zeus has truly entered the interface
	waitUntil {sleep 1; not isNull (findDisplay 312)};
	
	// Wait until Zeus modules are avaiable (e.g. respawns has to be placed before)
	if (count allMissionObjects "ModuleMPTypeGameMaster_F" > 0) then
	{
		waitUntil {sleep 1; missionnamespace getvariable ["BIS_moduleMPTypeGameMaster_init", false]};
	};
	
	[[getAssignedCuratorLogic player],
	{
		private _curatorModule = _this select 0;
		_curatorModule addCuratorAddons ["achilles_modules_f_achilles","achilles_modules_f_ares"];
	}, 2] call Achilles_fnc_spawn;
	
	// reload interface
	waitUntil {sleep 1; "achilles_modules_f_achilles" in (curatorAddons getAssignedCuratorLogic player)};
	cutText ["","BLACK OUT", 0.1,true];
	uiSleep 0.1;
	(findDisplay 312) closeDisplay 0;
	uiSleep 0.1;
	openCuratorInterface;
	cutText ["","BLACK IN", 0.1, true];
	_display_reload = true;
};

//prevent drawing mines
if (not (missionnamespace getvariable ["bis_fnc_drawMinefields_active",false])) then
{
	missionnamespace setvariable ["bis_fnc_drawMinefields_active",true,true];
};

// Initialize settings variables
Achilles_var_reloadDisplay = nil; 
Achilles_var_reloadVisionModes = nil;

// Enable the selected VisionModes for Zeus
[] call Achilles_fnc_setCuratorVisionModes;

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
		private _handled = false;
		
		// if player was a promoted Zeus
		private _module =  _unit getVariable ["Achilles_var_promoZeusModule", objNull];
		if (not isNull _module) then {(group _module) deleteGroupWhenEmpty true; deleteVehicle _module};
			
		if (not isNil {_unit getVariable "Achilles_var_switchUnit_data"}) then
		{
			// if unit was controlled by Zeus with "select player"
			private _playerUnit = (_unit getVariable "Achilles_var_switchUnit_data") select 1;
			deleteVehicle _playerUnit;
			_unit setVariable ["Achilles_var_switchUnit_data", nil, true];
			_handled = true;
		};
		_handled;
	}]
}, 2] call Achilles_fnc_spawn;

// reset map position
private _camPos = position curatorCamera;
private _curatorMapCtrl = ((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP);
_curatorMapCtrl ctrlMapAnimAdd [0, 0.1, _camPos]; 
ctrlMapAnimCommit _curatorMapCtrl;

// Unlock all available attributes
_curatorModule setVariable ["BIS_fnc_curatorAttributesplayer",["%ALL"]];
_curatorModule setVariable ["BIS_fnc_curatorAttributesobject",["%ALL"]];
_curatorModule setVariable ["BIS_fnc_curatorAttributesgroup",["%ALL"]];
_curatorModule setVariable ["BIS_fnc_curatorAttributeswaypoint",["%ALL"]];
_curatorModule setVariable ["BIS_fnc_curatorAttributesmarker",["%ALL"]];

_display_reload;
