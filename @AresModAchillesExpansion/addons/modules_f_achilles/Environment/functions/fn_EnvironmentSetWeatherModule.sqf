#include "\achilles\modules_f_ares\module_header.inc.sqf"
#define SHARP_DECAY_VALUE 1
#define SMOOTH_DECAY_VALUE 0.01

private _dialogResult =
[
	localize "STR_AMAE_ADVANCED_WEATHER_CHANGE",
	[
		["COMBOBOX", localize "STR_AMAE_TRANSITION", [localize "STR_AMAE_IMMEDIATE",localize "STR_AMAE_SMOOTH"]],
		["SLIDER", localize "STR_AMAE_OVERCAST", [], overcast, true],
		["SLIDER", localize "STR_AMAE_RAIN_", [], rain, true],
		["SLIDER", localize "STR_AMAE_LIGHTNINGS_", [], lightnings, true],
		["SLIDER", localize "STR_AMAE_RAINBOW_", [], rainbow, true],
		["SLIDER", [localize "STR_AMAE_WIND_SPEED",localize "STR_AMAE_KILOMETERS_PER_HOUR"] joinString " ", [[0.04,110], [5,10]], 3.6 * vectorMagnitude wind, true],
		["COMBOBOX", localize "STR_AMAE_WIND_DIRECTION",["N","NE","E","SE","S","SW","W","NW"], if (windDir > 180) then {round ((windDir - 180) / 45)} else {round ((windDir + 180) / 45)}, true],
		["SLIDER", localize "STR_AMAE_WAVES", [], waves, true],
		["SLIDER", localize "STR_AMAE_FOG_SETTING", [], fogParams select 0, true],
		["SLIDER", localize "STR_AMAE_FOG_DECAY", [[SMOOTH_DECAY_VALUE, SHARP_DECAY_VALUE]], fogParams select 1, true],
		["TEXT", [localize "STR_AMAE_Fog_Altitude_ASL",localize "STR_AMAE_METERS"] joinString " ", [], str (fogParams select 2), true]
	]
] call Achilles_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_rendered", "_cloudSetting", "_rainSetting", "_lightningSetting", "_rainbowSetting", "_windForce", "_windDirection", "_wavesSetting", "_fogSetting", "_fogDecaySetting", "_fogBaseSetting"];
_windDirection = _windDirection * 45;
_windForce = _windForce / 3.6;
private _windSetting = [-_windForce * sin _windDirection,-_windForce * cos _windDirection, true];
_fogBaseSetting = parseNumber _fogBaseSetting;

Ares_var_Weather_Settings = [_rendered,_cloudSetting, _rainSetting, _rainbowSetting, _lightningSetting, _windSetting, _wavesSetting, [_fogSetting, _fogDecaySetting, _fogBaseSetting]];
publicVariable "Ares_var_Weather_Settings";

if (isNil "Ares_fnc_Weather_Function") then
{
	Ares_fnc_Weather_Function =
	{
		sleep 1;
		while {true} do
		{
			private _settings = Ares_var_Weather_Settings;
			private _delay = if ((_settings select 0) == 0) then {0} else {30};
			0 setOvercast (_settings select 1);
			_delay setRain (_settings select 2);
			0 setLightnings (_settings select 4);
			sleep 1;
		};
	};
	publicVariable "Ares_fnc_Weather_Function";
	remoteExec ["Ares_fnc_Weather_Function",0,true];
	Ares_fnc_Change_Weather_Function =
	{
		private _settings = Ares_var_Weather_Settings;
		private _delay = [30, 0] select ((_settings select 0) == 0);
		0 setOvercast (_settings select 1);
		_delay setRain (_settings select 2);
		0 setLightnings (_settings select 4);
		_delay setFog (_settings select 7);

		0 setRainbow (_settings select 3);
		setWind (_settings select 5);
		_delay setWaves (_settings select 6);

		if ((_settings select 0) == 0) then {forceWeatherChange;};
	};
	publicVariable "Ares_fnc_Change_Weather_Function";
};

remoteExec ["Ares_fnc_Change_Weather_Function",0];

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
