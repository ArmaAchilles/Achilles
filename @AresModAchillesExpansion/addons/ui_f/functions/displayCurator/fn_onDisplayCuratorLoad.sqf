////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on Anton Struyk's version)
//	DATE: 7/18/16
//	VERSION: 1.0
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

_this spawn
{
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
		
		// execute init
		[] call Achilles_fnc_onCuratorStart;
		
		// wait until zeus has truly entered the interface
		waitUntil {not isNull (findDisplay 312)};
		
		// Wait until Zeus modules are avaiable (e.g. respawns has to be placed before)
		waitUntil {_tree_ctrl tvText [(_tree_ctrl tvCount []) - 1] == localize "STR_ZEUS"};
		
		// reload interface (trick for integrate ares modules properly)
		cutText ["","BLACK OUT", 0.1,true];
		sleep 0.4;
		(findDisplay 312) closeDisplay 0;

		// reject player if both mods are running (saves players from themselves)
		if (isClass (configfile >> "CfgPatches" >> "Ares")) then {while {true} do {sleep 1; hint "Error: Please unload Ares Mod!"; systemChat "Ares Mod and Ares Mod - Achilles Expansion are standalone add-ons and are NOT compatible with each other!"}};
		
		// wait until init is completed
		//waitUntil {not isNil "Achilles_fnc_serverInitDone"};
		_curator_module = getAssignedCuratorLogic player;
		while {not ("achilles_modules_f_achilles" in curatorAddons _curator_module)} do {sleep 1;};
		Achilles_curator_init_done = true;
		sleep 0.1;
		openCuratorInterface;
		cutText ["","BLACK IN", 0.1, true];
		sleep 0.1;
		
		// display advanced hints
		[["Ares", "AresFieldManual"]] call BIS_fnc_advHint;
	} else
	{
		//wait unit Remote Control is truly terminated (fix connection issues with TFAR)
		if (isClass (configfile >> "CfgPatches" >> "task_force_radio")) then
		{
			waitUntil {sleep 1; (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]) == player};
		};
		
		/*
		//add key event handlers to curator inteface (based on suggestion of Zarkant)
		_mousearea = _display displayCtrl IDC_RSCDISPLAYCURATOR_MOUSEAREA;
		_mousearea ctrlAddEventHandler ["KeyDown",{_this call Achilles_fnc_HandleCuratorKeyPressed;}];
		_mousearea ctrlAddEventHandler ["KeyUp",{_this call Achilles_fnc_HandleCuratorKeyReleased;}];
		*/
		
		_display displayAddEventHandler ["KeyDown",{_this call Achilles_fnc_HandleCuratorKeyPressed;}];
		_display displayAddEventHandler ["KeyUp",{_this call Achilles_fnc_HandleCuratorKeyReleased;}];
		
		// handle module tree loading
		[false] call Achilles_fnc_OnModuleTreeLoad;
	};
};