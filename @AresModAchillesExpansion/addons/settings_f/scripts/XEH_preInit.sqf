/**
 * _setting     - Unique setting name. Matches resulting variable name <STRING>
 * _settingType - Type of setting. Can be "CHECKBOX", "LIST", "SLIDER" or "COLOR" <STRING>
 * _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
 * _category    - Category for the settings menu <STRING>
 * _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
 * _isGlobal    - true: all clients share the same state of the setting (optional, default: false) <ARRAY>
 * _script      - Script to execute when setting is changed or forced. (optional) <CODE>
 *
 * ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1,1,0], false, {diag_log text format ["Color Setting Changed: %1", _this];}] call cba_settings_fnc_init;
*/

#include "user_interface.sqf"
#include "curator_vision.sqf"
#include "available_factions.sqf"
#include "available_modules.sqf"
#include "keybindings.sqf"
#include "debugMessages.sqf"
#include "moduleDefaults.sqf"