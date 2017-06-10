/**
 **/
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
 
[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_keyEject", 
	localize "STR_KEY_EJECT_PASSENGERS", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			if (isNil "Achilles_var_eject_init_done") then
			{
				publicVariable "Achilles_fnc_chute";
				publicVariableServer "Achilles_fnc_eject_passengers";
				Achilles_var_eject_init_done = true;
			};
			[curatorSelected select 0] remoteExecCall ["Achilles_fnc_eject_passengers",2];
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_V, [false, false, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_keyGroup", 
	localize "STR_KEY_GROUP", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			[curatorSelected select 0,true] call Achilles_fnc_ACS_toggleGrouping;
			//[curatorSelected select 0] call Achilles_fnc_groupObjects;
			_handled = true;
		};
		_handled;
	},
	"", 
	[DIK_G, [false, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_keyUnGroup", 
	localize "STR_KEY_UNGROUP", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			[curatorSelected select 0,false] call Achilles_fnc_ACS_toggleGrouping;
			//[curatorSelected select 0] call Achilles_fnc_ungroupObjects;
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_G, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_deepCopy", 
	localize "STR_KEY_DEEP_COPY", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			curatorSelected call Achilles_fnc_CopyObjectsToClipboard;
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_C, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_deepPaste", 
	localize "STR_KEY_DEEP_PASTE", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			[] call Achilles_fnc_PasteObjectsFromClipboard;
			_handled = true;
		};
		_handled;
	},
	"", 
	[DIK_V, [true, true, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_countermeasure", 
	localize "STR_KEY_COUNTERMEASURE", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR) then
		{
			_vehicle = vehicle (curatorSelected select 0 select 0);
			if (isNil "_vehicle") exitWith {};
			[_vehicle] call Achilles_fnc_LaunchCM;
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_C, [false, false, false]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_increaseNVGBrightness", 
	localize "STR_KEY_INCREASENVGBRIGHTNESS", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR and {not isNil "Achilles_var_NVGBrightnessEffect"} and {ppEffectEnabled Achilles_var_NVGBrightnessEffect}) then
		{
			[+1] call Achilles_fnc_changeNVGBrightness;
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_PGUP, [false, false, true]]
] call CBA_fnc_addKeybind;

[
	localize "STR_ARES_MOD_ACHILLES_EXPANSION",
	"Achilles_id_decreaseNVGBrightness", 
	localize "STR_KEY_DECREASEVGBRIGHTNESS", 
	{
		_handled = false;
		if (_this select 0 == findDisplay IDD_RSCDISPLAYCURATOR and {not isNil "Achilles_var_NVGBrightnessEffect"} and {ppEffectEnabled Achilles_var_NVGBrightnessEffect}) then
		{
			[-1] call Achilles_fnc_changeNVGBrightness;
			_handled = true;
		};
		_handled;
	}, 
	"", 
	[DIK_PGDN, [false, false, true]]
] call CBA_fnc_addKeybind;