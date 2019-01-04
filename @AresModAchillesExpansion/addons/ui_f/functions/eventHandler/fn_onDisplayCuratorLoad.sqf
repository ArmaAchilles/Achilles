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
#define ALL_ADD_CREATE_IDCS	[IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV, IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV, IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY]
#define ALL_ADD_MODE_IDCS		[IDC_RSCDISPLAYCURATOR_MODEUNITS, IDC_RSCDISPLAYCURATOR_MODEGROUPS, IDC_RSCDISPLAYCURATOR_MODEMODULES, IDC_RSCDISPLAYCURATOR_MODEMARKERS, IDC_RSCDISPLAYCURATOR_MODERECENT]
#define ALL_ADD_SIDE_IDCS		[IDC_RSCDISPLAYCURATOR_SIDEOPFOR, IDC_RSCDISPLAYCURATOR_SIDEBLUFOR, IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT, IDC_RSCDISPLAYCURATOR_SIDECIVILIAN, IDC_RSCDISPLAYCURATOR_SIDEEMPTY]

// execute vanilla display curator function
["onLoad",_this,"RscDisplayCurator","CuratorDisplays"] call (uinamespace getvariable "BIS_fnc_initDisplay");

// custom stacked curator display event handler
["Achilles_onLoadCuratorInterface", _this, player] call CBA_fnc_targetEvent;

_this spawn
{
	disableSerialization;
	private _display_reload = false;
	private _display = _this select 0;
	private _tree_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
		
	if (isNil "Achilles_curator_init_done") then
	{
		// key event handler for remote controlled unit
		private _main_display = findDisplay 46;
		_main_display displayAddEventHandler ["KeyDown", { _this call Achilles_fnc_HandleRemoteKeyPressed; }];
		
		// send warning to player if both mods are running
		if (isClass (configfile >> "CfgPatches" >> "Ares")) then 
		{
			createDialog "RscDisplayCommonMessage";
			private _dialog = findDisplay IDD_MESSAGE;
			(_dialog displayCtrl IDC_TITLE) ctrlSetText "Warning: Please unload Ares Mod!";
			(_dialog displayCtrl IDC_TEXT_WARNING) ctrlSetText "Achilles may not work properly!";
			(_dialog displayCtrl IDC_CONFIRM_WARNING) ctrlAddEventHandler ["ButtonClick","closeDialog 1;"];
			(_dialog displayCtrl IDC_CANCLE_WARNING) ctrlAddEventHandler ["ButtonClick", "closeDialog 2;"];
		};
		
		// execute init
		_display_reload = [_tree_ctrl] call Achilles_fnc_onCuratorStart;
		
		Achilles_curator_init_done = true;
		
		// display advanced hints
		private _hasHintBeenShown = profileNamespace getVariable ["Achilles_var_advHint_showIntro", false];
		if (!_hasHintBeenShown) then
		{
			[["Ares", "AresFieldManual"],15,"",35,"",true] call BIS_fnc_advHint;
			profileNamespace setVariable ["Achilles_var_advHint_showIntro", true];
		};
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
	
	// Fixes the loss of sides in the module tree caused by an ongoing search
	{
		private _ctrl = _display displayCtrl _x;
		_ctrl ctrlAddEventHandler ["ButtonClick",
		{
			params ["_ctrlMode"];
			private _display = ctrlParent _ctrlMode;
			private	_ctrlSearch = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
			private _searchText = ctrlText _ctrlSearch;
			(missionNamespace getVariable ["RscDisplayCurator_sections", [0,0]]) params ["_","_curSide"];
			private _curMode = ALL_ADD_MODE_IDCS find ctrlIDC _ctrlMode;
			if (_searchText != "") then
			{
				private _ctrlCreateList = ALL_ADD_CREATE_IDCS apply {_display displayCtrl _x};
				if (_curMode <= 1) then
				{
					_ctrlCreateList deleteAt (5 * _curMode + _curSide);
				};
				[_ctrlCreateList,_ctrlSearch,_searchText] spawn
				{
					disableSerialization;
					params ["_ctrlCreateList","_ctrlSearch","_searchText"];
					{_x ctrlSetFade 0.99; _x ctrlShow true; _x ctrlCommit 0} forEach _ctrlCreateList;
					waitUntil {{not ctrlShown _x} count _ctrlCreateList == 0};
					_ctrlSearch ctrlSetText "";
					uiSleep 0.05;
					{_x ctrlShow false; _x ctrlSetFade 0; _x ctrlCommit 0} forEach _ctrlCreateList;
					waitUntil {{ctrlShown _x} count _ctrlCreateList == 0};
					_ctrlSearch ctrlSetText _searchText;
				};
			};
		}];
	} forEach ALL_ADD_MODE_IDCS;
	{
		private _ctrl = _display displayCtrl _x;
		_ctrl ctrlAddEventHandler ["ButtonClick",
		{
			params ["_ctrlSide"];
			private _display = ctrlParent _ctrlSide;
			private	_ctrlSearch = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
			private _searchText = ctrlText _ctrlSearch;
			(missionNamespace getVariable ["RscDisplayCurator_sections", [0,0]]) params ["_curMode"];
			private _curSide = ALL_ADD_SIDE_IDCS find ctrlIDC _ctrlSide;
			if (_searchText != "") then
			{
				private _ctrlCreateList = ALL_ADD_CREATE_IDCS apply {_display displayCtrl _x};
				if (_curMode <= 1) then
				{
					_ctrlCreateList deleteAt (5 * _curMode + _curSide);
				};
				[_ctrlCreateList,_ctrlSearch,_searchText] spawn
				{
					disableSerialization;
					params ["_ctrlCreateList","_ctrlSearch","_searchText"];
					{_x ctrlSetFade 0.99; _x ctrlShow true; _x ctrlCommit 0} forEach _ctrlCreateList;
					waitUntil {{not ctrlShown _x} count _ctrlCreateList == 0};
					_ctrlSearch ctrlSetText "";
					uiSleep 0.05;
					{_x ctrlShow false; _x ctrlSetFade 0; _x ctrlCommit 0} forEach _ctrlCreateList;
					waitUntil {{ctrlShown _x} count _ctrlCreateList == 0};
					_ctrlSearch ctrlSetText _searchText;
				};
			};
		}];
	} forEach ALL_ADD_SIDE_IDCS;
	
	// Add custom Zeus logo when pressing backspace
	private _zeusLogo = (findDisplay 312) displayCtrl 15717;
	private _addLogo = true;
	switch (Achilles_var_iconSelection) do 
	{
		case "Achilles_var_iconSelection_Ares": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\ZeusEyeAres.paa"};
		case "Achilles_var_iconSelection_Achilles": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\Achilles_Icon_005.paa"};
		case "Achilles_var_iconSelection_Enyo": {_zeusLogo ctrlSetText "\achilles\data_f_achilles\icons\icon_enyo_large.paa"};
		case "Achilles_var_iconSelection_Default": {_addLogo = false};
		default {_zeusLogo ctrlSetText "\achilles\data_f_achilles\pictures\ZeusEyeAres.paa"};
	};
	if (_addLogo) then {_zeusLogo ctrlCommit 0};
	
	// handle module tree loading
	[true] call Achilles_fnc_OnModuleTreeLoad;
};
