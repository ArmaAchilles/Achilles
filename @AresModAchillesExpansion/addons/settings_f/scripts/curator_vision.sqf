/*
-2 : NVG
-1 : Normal
0  : White Hot
1  : Black Hot
2  : Light Green Hot / Darker Green cold
3  : Black Hot / Darker Green cold
4  : Light Red Hot /Darker Red Cold
5  : Black Hot / Darker Red Cold
6  : White Hot . Darker Red Col
7  : Thermal (Shade of Red and Green, Bodies are white)
*/
[
    "achilles_curator_vision_nvg",
    "CHECKBOX",
    "Enable NVG",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_whitehot",
    "CHECKBOX",
    "Enable Thermal - White Hot",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhot",
    "CHECKBOX",
    "Enable Thermal - Black Hot",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_greenhotcold",
    "CHECKBOX",
    "Enable Thermal - Green Hot / Green Cold",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhotgreencold",
    "CHECKBOX",
    "Enable Thermal - Black Hot / Green Cold",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_redhot",
    "CHECKBOX",
    "Enable Thermal - Red Hot",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhotredcold",
    "CHECKBOX",
    "Enable Thermal - Black Hot / Red Cold",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_whitehotredcold",
    "CHECKBOX",
    "Enable Thermal - White Hot / Red Cold",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_redgreen",
    "CHECKBOX",
    "Enable Thermal - Red&Green / White Hot",
    "Curator Vision Modes",
    true
] call cba_settings_fnc_init;
