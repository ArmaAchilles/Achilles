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
	
	private _effect = missionNamespace getVariable "Achilles_var_NVGBrightnessEffect";
	if(_mode == -2) then
	{
		if (isNil "_effect") then
		{
			_effect = ppEffectCreate ["ColorCorrections", 312312];
			missionNamespace setVariable ["Achilles_var_NVGBrightnessEffect", _effect];
			["onLoad", 
			{
				private _curator = getAssignedCuratorLogic player;
				private _modes = _curator call bis_fnc_curatorVisionModes;
				private _index = _curator getvariable ["bis_fnc_curatorVisionModes_current",0];
				if (_modes select _index == -2) then
				{
					(missionNamespace getVariable "Achilles_var_NVGBrightnessEffect") ppEffectEnable true;
				};
			}] call Achilles_fnc_addCuratorInterfaceEventHandler;
			["onUnload", {(missionNamespace getVariable "Achilles_var_NVGBrightnessEffect") ppEffectEnable false}] call Achilles_fnc_addCuratorInterfaceEventHandler;
		};
		
		//--- NVG => enable brightness adjustment
		_effect ppEffectForceInNVG true;
		_effect ppEffectEnable true;
		private _brightness = player getVariable ["ace_nightvision_NVGBrightness", 0];
		_effect ppEffectAdjust [1, (_brightness + 1), 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 1]];
		_effect ppEffectCommit 0;
		
	} else
	{
		if (not isNil "_effect") then
		{
			_effect ppEffectEnable false;
		};
	};
	
	([] call bis_fnc_rsclayer) cutrsc ["RscCuratorVisionModes","plain"];
	playsound ["RscDisplayCurator_visionMode",true];
};
_mode