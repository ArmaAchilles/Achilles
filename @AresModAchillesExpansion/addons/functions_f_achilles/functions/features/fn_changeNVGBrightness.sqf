
params["_changeInBrightness"];
private _brightness = player getVariable ["ace_nightvision_NVGBrightness", 0];

_brightness = ((round (10 * _brightness + _changeInBrightness) / 10) min 0.5) max -0.5;

player setVariable ["ace_nightvision_NVGBrightness", _brightness, false];

Achilles_var_NVGBrightnessEffect ppEffectAdjust [1, (_brightness + 1), 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 1]];
Achilles_var_NVGBrightnessEffect ppEffectCommit 0;
[format[(localize "STR_BRIGHTNESS") + ": %1", (_brightness * 10)]] call Ares_fnc_ShowZeusMessage;
playsound ["RscDisplayCurator_visionMode",true];