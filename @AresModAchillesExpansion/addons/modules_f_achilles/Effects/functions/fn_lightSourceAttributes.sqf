

params [["_sourceObject",objNull,[objNull]]];

private _light_attributes = _sourceObject getVariable ["LightAttributes", [[1,1,1],[1,1,1,1]]];
private _rgb_color = _light_attributes select 0;
private _attenuation = _light_attributes select 1;

_source = _sourceObject getVariable "source";
Achilles_var_AttributeWindowTargetObject = _source;

_dialogResult = 
[
	localize "STR_LIGHT_SOURCE",
	[
		[localize "STR_RED_LIGHT", "SLIDER", _rgb_color select 0, true],
		[localize "STR_GREEN_LIGHT", "SLIDER", _rgb_color select 1, true],
		[localize "STR_BLUE_LIGHT", "SLIDER", _rgb_color select 2, true],
		[localize "STR_RANGE" + " [m]", "", str (_attenuation select 0), true],
		[localize "STR_CONST_ATTENUATION", "SLIDER", (_attenuation select 1)/100, true],
		[localize "STR_LINEAR_ATTENUATION", "SLIDER", (_attenuation select 2)/100, true],
		[localize "STR_QUADRATIC_ATTENUATION", "SLIDER", (_attenuation select 3)/100, true]
	],
	"Achilles_fnc_RscDisplayAttributes_editLigthSource"
] call Ares_fnc_showChooseDialog;


if(count _dialogResult > 0) then 
{
	_rgb_color = _dialogResult select [0,3];
	_attenuation = _dialogResult select [3,4];
	_attenuation set [0, parseNumber (_attenuation select 0)];
	for "_i" from 1 to 3 do {_attenuation set [_i, 100 * (_attenuation select _i)];};
	_sourceObject setVariable ["LightAttributes", [_rgb_color,_attenuation], true];
};

[[_source,_rgb_color,_attenuation],
{
	params ["_source","_rgb_color","_attenuation"];
	_source setLightBrightness 1.0;
	_source setLightAmbient  _rgb_color;
	_source setLightColor _rgb_color;
	_source setLightAttenuation _attenuation;
}] remoteExec ["spawn",0,_source];

Achilles_var_AttributeWindowTargetObject = nil;