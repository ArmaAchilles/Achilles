////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/20/16
//	VERSION: 2.0
//	FILE: achilles\ui_f\functions\displayCurator\fn_onDisplayCuratorLoad.sqf
//  DESCRIPTION: Called when display curator is loaded
//
//	ARGUMENTS:
//	_this select 0:		display	- curator display
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_curatorDisplay] call Achilles_fnc_onDisplayCuratorLoad;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

// execute vanilla display curator function
["onLoad",_this,"RscDisplayCurator","CuratorDisplays"] call (uinamespace getvariable "BIS_fnc_initDisplay");

disableSerialization;
_display = _this select 0;
_tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	
if (isNil "Achilles_curator_init_done") then
{
	// key event handler for remote controlled unit
	_main_display = findDisplay 46;
	_main_display displayAddEventHandler ["KeyDown", { _this call Achilles_fnc_HandleRemoteKeyPressed; }];
	
	// initialize key variables
	Ares_Ctrl_Key_Pressed = false;
	Ares_Shift_Key_Pressed = false;
	
	// Add curator event handlers
	_curatorModule = getassignedcuratorLogic player;
	_curatorModule addEventHandler ["CuratorObjectPlaced", { _this call Achilles_fnc_HandleCuratorObjectPlaced; }];
	_curatorModule addEventHandler ["CuratorObjectDoubleClicked", { _this call Achilles_fnc_HandleCuratorObjectDoubleClicked; }];

	// reject player if both mods are running (saves players from themselves)
	if (isClass (configfile >> "CfgPatches" >> "Ares")) then 
	{
		[] spawn
		{
			while {true} do 
			{
				sleep 1; 
				hint "Error: Please unload Ares Mod!"; 
				systemChat "Ares Mod and Ares Mod - Achilles Expansion are standalone add-ons and are NOT compatible with each other!"
			};
		};
	};
	
	Achilles_curator_init_done = true;
	
	// display advanced hints
	[["Ares", "AresFieldManual"]] call BIS_fnc_advHint;
};

_display displayAddEventHandler ["KeyDown",{_this call Achilles_fnc_HandleCuratorKeyPressed;}];
_display displayAddEventHandler ["KeyUp",{_this call Achilles_fnc_HandleCuratorKeyReleased;}];

// Load custom modules
if (not isNil "Ares_Custom_Modules") then
{
	[] call Achilles_fnc_OnModuleTreeLoad;
};