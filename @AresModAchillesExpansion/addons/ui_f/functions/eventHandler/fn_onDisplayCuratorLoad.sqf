////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/26/17
//	VERSION: 6.0
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

// custom stacked curator display event handler
["Achilles_onLoadCuratorInterface", _this, player] call CBA_fnc_targetEvent;

_this spawn
{
	disableSerialization;
	private _display_reload = false;
	_display = _this select 0;
	_tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
		
	if (isNil "Achilles_curator_init_done") then
	{
		// key event handler for remote controlled unit
		_main_display = findDisplay 46;
		_main_display displayAddEventHandler ["KeyDown", { _this call Achilles_fnc_HandleRemoteKeyPressed; }];
		
		// reject player if both mods are running (protect players from themselves)
		if (isClass (configfile >> "CfgPatches" >> "Ares")) then {while {true} do {sleep 1; hint "Error: Please unload Ares Mod!"; systemChat "Ares Mod and Ares Mod - Achilles Expansion are standalone add-ons and are NOT compatible with each other!"}};
		
		// execute init
		_display_reload = [_tree_ctrl] call Achilles_fnc_onCuratorStart;
		
		Achilles_curator_init_done = true;
		
		// display advanced hints
		[["Ares", "AresFieldManual"],15,"",35,"",true] call BIS_fnc_advHint;
	};
	// prevent unessecary double execution of functions below
	if (_display_reload) exitWith {};
	
	//wait unit Remote Control is truly terminated (fix connection issues with TFAR)
	if (isClass (configfile >> "CfgPatches" >> "task_force_radio")) then
	{
		waitUntil {sleep 1; (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]) == player};
	};
	
	_display displayAddEventHandler ["KeyDown",{_this call Achilles_fnc_HandleCuratorKeyPressed;}];
	(_display displayCtrl IDC_RSCDISPLAYCURATOR_MOUSEAREA) ctrlAddEventHandler ["MouseButtonDblClick",{_this call Achilles_fnc_HandleMouseDoubleClicked;}];
	
	// handle module tree loading
	[true] call Achilles_fnc_OnModuleTreeLoad;
};