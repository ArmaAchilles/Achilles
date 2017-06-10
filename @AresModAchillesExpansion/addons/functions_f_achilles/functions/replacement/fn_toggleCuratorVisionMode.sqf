/*
	Author: Karel Moricky

	Description:
	Toggle curator vision mode

	Parameter(s):
		0: OBJECT - curator
		1 (Optional): NUMBER - change index (default: 1)

	Returns:
	BOOL
*/

private ["_curator","_add","_modes","_modesCount","_index","_mode"];
_curator = _this param [0,objnull,[objnull]];
_add = _this param [1,1,[0]];
_modes = _curator call bis_fnc_curatorVisionModes;
_modesCount = count _modes;

_index = _curator getvariable ["bis_fnc_curatorVisionModes_current",0];
_index = (_index + _add) % _modesCount;
if (_index < 0) then {_index = _modesCount + _index;};
_mode = _modes select _index;
_curator setvariable ["bis_fnc_curatorVisionModes_current",_index];

if !(isnull curatorcamera) then {
	switch _mode do {
		//--- NVG
		case -2:
		{
			camusenvg true;
			false setCamUseTi 0;
		};
		//--- Normal
		case -1: {
			camusenvg false;
			false setCamUseTi 0;
		};
		//--- TI
		default {
			camusenvg false;
			true setCamUseTi _mode;
		};
	};
	
	if(_mode == -2) then
	{
		if (isNil "Achilles_var_NVGBrightnessEffect") then
		{
			
			["onLoad", 
			{
				private _curator = getAssignedCuratorLogic player;
				private _modes = _curator call bis_fnc_curatorVisionModes;
				private _index = _curator getvariable ["bis_fnc_curatorVisionModes_current",0];
				if (_modes select _index == -2) then
				{
					Achilles_var_NVGBrightnessEffect ppEffectEnable true;
				};
			}] call Achilles_fnc_addCuratorInterfaceEventHandler;
			["onUnload", {Achilles_var_NVGBrightnessEffect ppEffectEnable false}] call Achilles_fnc_addCuratorInterfaceEventHandler;
		};
		
		//--- NVG => enable brightness adjustment
		Achilles_var_NVGBrightnessEffect ppEffectForceInNVG true;
		Achilles_var_NVGBrightnessEffect ppEffectEnable true;
		private _brightness = player getVariable ["ace_nightvision_NVGBrightness", 0];
		Achilles_var_NVGBrightnessEffect ppEffectAdjust [1, (_brightness + 1), 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 1]];
		Achilles_var_NVGBrightnessEffect ppEffectCommit 0;
	} else
	{
		Achilles_var_NVGBrightnessEffect ppEffectEnable false;
	};
	
	([] call bis_fnc_rsclayer) cutrsc ["RscCuratorVisionModes","plain"];
	playsound ["RscDisplayCurator_visionMode",true];
};
_mode