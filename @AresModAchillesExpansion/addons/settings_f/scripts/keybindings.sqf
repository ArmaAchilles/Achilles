/**
 **/
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
 
[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_keyEject", 
	localize "STR_AMAE_KEY_EJECT_PASSENGERS", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			if (isNil "Achilles_var_eject_init_done") then
			{
				publicVariable "Achilles_fnc_chute";
				publicVariableServer "Achilles_fnc_eject_passengers";
				Achilles_var_eject_init_done = true;
			};
			[curatorSelected select 0] remoteExecCall ["Achilles_fnc_eject_passengers",2];
			true
		};
		false
	}, 
	"", 
	[DIK_V, [false, false, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_keyGroup", 
	localize "STR_AMAE_KEY_GROUP", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			[curatorSelected select 0,true] call Achilles_fnc_ACS_toggleGrouping;
			//[curatorSelected select 0] call Achilles_fnc_groupObjects;
			true;
		};
		false;
	},
	"", 
	[DIK_G, [false, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_keyUnGroup", 
	localize "STR_AMAE_KEY_UNGROUP", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			[curatorSelected select 0,false] call Achilles_fnc_ACS_toggleGrouping;
			//[curatorSelected select 0] call Achilles_fnc_ungroupObjects;
			true;
		};
		false;
	}, 
	"", 
	[DIK_G, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_deepCopy", 
	localize "STR_AMAE_KEY_DEEP_COPY", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			curatorSelected call Achilles_fnc_CopyObjectsToClipboard;
			true;
		};
		false;
	}, 
	"", 
	[DIK_C, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_deepPaste", 
	localize "STR_AMAE_KEY_DEEP_PASTE", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			[] call Achilles_fnc_PasteObjectsFromClipboard;
			true;
		};
		false;
	},
	"", 
	[DIK_V, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_countermeasure", 
	localize "STR_AMAE_KEY_COUNTERMEASURE", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) exitWith
		{
			private _vehicles = curatorSelected select 0;
			if (isNil "_vehicles" || missionNamespace getVariable ['RscDisplayCurator_search', false]) exitWith {};
			{
				[vehicle _x] call Achilles_fnc_LaunchCM;
			} forEach _vehicles;
			true;
		};
		false;
	}, 
	"", 
	[DIK_C, [false, false, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_increaseNVGBrightness", 
	localize "STR_AMAE_KEY_INCREASENVGBRIGHTNESS", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR && {ppEffectEnabled (missionNamespace getVariable ["Achilles_var_NVGBrightnessEffect",-1])}) exitWith
		{
			[+1] call Achilles_fnc_changeNVGBrightness;
			true;
		};
		false;
	}, 
	"", 
	[DIK_PGUP, [false, false, true]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_decreaseNVGBrightness", 
	localize "STR_AMAE_KEY_DECREASEVGBRIGHTNESS", 
	{
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR and {ppEffectEnabled (missionNamespace getVariable ["Achilles_var_NVGBrightnessEffect",-1])}) exitWith
		{
			[-1] call Achilles_fnc_changeNVGBrightness;
			true;
		};
		false;
	}, 
	"", 
	[DIK_PGDN, [false, false, true]]
] call CBA_fnc_addKeybind;

[
	localize "STR_AMAE_ACHILLES",
	"Achilles_id_toggleIncludeCrew",
	localize "STR_AMAE_KEY_TOGGLEINCLUDECREW",
	{
		if (isNil "Achilles_var_toggleCrewOnSpawn") then
		{
			missionNamespace setVariable ["Achilles_var_toggleCrewOnSpawn", true];
			((findDisplay 312) displayCtrl 2801) cbSetChecked false;
		}
		else
		{
			missionNamespace setVariable ["Achilles_var_toggleCrewOnSpawn", nil];
			((findDisplay 312) displayCtrl 2801) cbSetChecked true;
		};
	},
	{
		if (isNil "Achilles_var_toggleCrewOnSpawn") then
		{
			missionNamespace setVariable ["Achilles_var_toggleCrewOnSpawn", true];
			((findDisplay 312) displayCtrl 2801) cbSetChecked false;
		}
		else
		{
			missionNamespace setVariable ["Achilles_var_toggleCrewOnSpawn", nil];
			((findDisplay 312) displayCtrl 2801) cbSetChecked true;
		};
	},
	[0x0, [false, false, false]]
] call CBA_fnc_addKeybind;
