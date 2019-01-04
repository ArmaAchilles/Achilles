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
#define ALL_ADD_MODE_IDCS		[IDC_RSCDISPLAYCURATOR_MODEUNITS, IDC_RSCDISPLAYCURATOR_MODEGROUPS, IDC_RSCDISPLAYCURATOR_MODEMODULES, IDC_RSCDISPLAYCURATOR_MODEMARKERS, IDC_RSCDISPLAYCURATOR_MODERECENT]
#define ADD_MODE_TO_SIDE_IDCS	[[IDC_RSCDISPLAYCURATOR_SIDEOPFOR, IDC_RSCDISPLAYCURATOR_SIDEBLUFOR, IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT, IDC_RSCDISPLAYCURATOR_SIDECIVILIAN, IDC_RSCDISPLAYCURATOR_SIDEEMPTY], [IDC_RSCDISPLAYCURATOR_SIDEOPFOR, IDC_RSCDISPLAYCURATOR_SIDEBLUFOR, IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT, IDC_RSCDISPLAYCURATOR_SIDEEMPTY], [IDC_RSCDISPLAYCURATOR_SIDEEMPTY], [IDC_RSCDISPLAYCURATOR_SIDEEMPTY], []]
#define ALL_ADD_SIDE_IDCS		[IDC_RSCDISPLAYCURATOR_SIDEOPFOR, IDC_RSCDISPLAYCURATOR_SIDEBLUFOR, IDC_RSCDISPLAYCURATOR_SIDEINDEPENDENT, IDC_RSCDISPLAYCURATOR_SIDECIVILIAN, IDC_RSCDISPLAYCURATOR_SIDEEMPTY]

// execute vanilla display curator function
["onLoad",_this,"RscDisplayCurator","CuratorDisplays"] call (uinamespace getvariable "BIS_fnc_initDisplay");

// custom stacked curator display event handler
["Achilles_onLoadCuratorInterface", _this, player] call CBA_fnc_targetEvent;

params ["_display"];
private _moduleTreeCtrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

if (isNil "Achilles_curator_init_done") then
{
	// key event handler for remote controlled unit
	private _mainDisplay = findDisplay 46;
	_mainDisplay displayAddEventHandler ["KeyDown", { _this call Achilles_fnc_handleRemoteKeyPressed; }];
	
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
	[_moduleTreeCtrl] call Achilles_fnc_onCuratorStart;
	
	// display advanced hints
	private _hasHintBeenShown = profileNamespace getVariable ["Achilles_var_advHint_showIntro", false];
	if (!_hasHintBeenShown) then
	{
		[["Ares", "AresFieldManual"],15,"",35,"",true] call BIS_fnc_advHint;
		profileNamespace setVariable ["Achilles_var_advHint_showIntro", true];
	};
	
	Achilles_curator_init_done = true;
};

// Add mouse click event handlers
_display displayAddEventHandler ["KeyDown",{_this call Achilles_fnc_handleCuratorKeyPressed;}];
(_display displayCtrl IDC_RSCDISPLAYCURATOR_MOUSEAREA) ctrlAddEventHandler ["MouseButtonDblClick",{_this call Achilles_fnc_handleMouseDoubleClicked;}];
(_display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP) ctrlAddEventHandler ["MouseButtonDblClick",{_this call Achilles_fnc_handleMouseDoubleClicked;}];

// Fixes the loss of sides in the module tree caused by an ongoing search
{
	private _ctrl = _display displayCtrl _x;
	_ctrl ctrlAddEventHandler ["ButtonClick",
	{
		_this spawn
		{
			disableSerialization;
			params ["_ctrl"];
			private _display = ctrlParent _ctrl;
			(missionNamespace getVariable ["RscDisplayCurator_sections", [0,0]]) params ["_curMode"];
			uiSleep 0.001;
			{
				(_display displayCtrl _x) ctrlShow true;
			} forEach (ADD_MODE_TO_SIDE_IDCS select _curMode);
		};
	}];
} forEach (ALL_ADD_MODE_IDCS + ALL_ADD_SIDE_IDCS);
(missionNamespace getVariable ["RscDisplayCurator_sections", [0,0]]) params ["_curMode"];
{
	(_display displayCtrl _x) ctrlShow true;
} forEach (ADD_MODE_TO_SIDE_IDCS select _curMode);

// Handle DZN search patch
(_display displayCtrl 283) ctrlShow !Achilles_var_moduleTreeSearchPatch;
(_display displayCtrl 284) ctrlShow Achilles_var_moduleTreeSearchPatch;
if (Achilles_var_moduleTreeSearchPatch) then
{
	(_display displayCtrl 285) ctrlAddEventHandler ["ButtonClick", {(((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl 283) ctrlSetText (ctrlText ((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl 284)))}];
};

// Add custom Zeus logo when pressing backspace
private _zeusLogo = _display displayCtrl 15717;
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
[_moduleTreeCtrl] spawn
{
	disableSerialization;
	params ["_moduleTreeCtrl"];
	sleep 0.001;
	// For Zeus Game Master missions: Wait until respawn was placed
	if (!(missionNamespace getVariable ["BIS_moduleMPTypeGameMaster_init", false]) && {count allMissionObjects "ModuleMPTypeGameMaster_F" > 0}) then
	{
		waitUntil {sleep 0.1; _moduleTreeCtrl tvCount [] > 1 || isNull findDisplay IDD_RSCDISPLAYCURATOR};
	};
	if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};
	
	// wait for the next frame
	sleep 0.001;
	[Achilles_fnc_onModuleTreeLoad, []] call CBA_fnc_directCall;
};
