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
#define IDD_MESSAGE				999
#define IDC_TITLE				235100
#define IDC_TEXT_WARNING		235102
#define IDC_CONFIRM_WARNING		235106
#define IDC_CANCLE_WARNING		235107

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
		
		// send warning to player if both mods are running
		if (isClass (configfile >> "CfgPatches" >> "Ares")) then 
		{
			createDialog "RscDisplayCommonMessage";
			_dialog = findDisplay IDD_MESSAGE;
			(_dialog displayCtrl IDC_TITLE) ctrlSetText "Warning: Please unload Ares Mod!";
			(_dialog displayCtrl IDC_TEXT_WARNING) ctrlSetText "Ares Mod - Achilles Expansion may not work properly!";
			(_dialog displayCtrl IDC_CONFIRM_WARNING) ctrlAddEventHandler ["ButtonClick","closeDialog 1;"];
			(_dialog displayCtrl IDC_CANCLE_WARNING) ctrlAddEventHandler ["ButtonClick", "closeDialog 2;"];
		};
		
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
	(_display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP) ctrlAddEventHandler ["MouseButtonDblClick",{_this call Achilles_fnc_HandleMouseDoubleClicked;}];

	_zeusLogo = (findDisplay 312) displayCtrl 15717;
	switch (Achilles_var_iconSelection) do 
	{
		case "Achilles_var_iconSelection_Ares": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\ZeusEyeAres.paa"};
		case "Achilles_var_iconSelection_Achilles": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\Achilles_Icon_005.paa"};
		case "Achilles_var_iconSelection_Enyo": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\icons\icon_enyo_large.paa"};
		default {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\ZeusEyeAres.paa"};
	};
	_zeusLogo ctrlCommit 0;
	
	// handle module tree loading
	[true] call Achilles_fnc_OnModuleTreeLoad;
};