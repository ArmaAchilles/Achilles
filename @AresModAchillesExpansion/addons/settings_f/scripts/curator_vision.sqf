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
    localize "STR_VISION_MODES_NVG",
    localize "STR_VISION_MODES",
    true
	
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_whitehot",
    "CHECKBOX",
    localize "STR_VISION_MODES_WHITEHOT",
    localize "STR_VISION_MODES",
    true
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhot",
    "CHECKBOX",
    localize "STR_VISION_MODES_BLACKHOT",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_greenhotcold",
    "CHECKBOX",
    localize "STR_VISION_MODES_GREENHOTCOLD",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhotgreencold",
    "CHECKBOX",
    localize "STR_VISION_MODES_BLACKHOTGREENCOLD",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_redhot",
    "CHECKBOX",
    localize "STR_VISION_MODES_REDHOT",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_blackhotredcold",
    "CHECKBOX",
    localize "STR_VISION_MODES_BLACKHOTREDCOLD",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_whitehotredcold",
    "CHECKBOX",
    localize "STR_VISION_MODES_WHITEHOTREDCOLD",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;

[
    "achilles_curator_vision_redgreen",
    "CHECKBOX",
    localize "STR_VISION_MODES_REDGREEN",
    localize "STR_VISION_MODES",
    false
] call cba_settings_fnc_init;
