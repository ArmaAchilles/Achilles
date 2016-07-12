#include "\ares_zeusExtensions\Ares\module_header.hpp"
#define SHARP_DECAY_VALUE 0.2
#define SMOOTH_DECAY_VALUE 0.002

_altitudes = [0, 5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 100, 125, 150, 200, 300];
_altitudeDisplayValues = [];
{
	_altitudeDisplayValues pushBack (format ["%1 m", _x]);
} forEach _altitudes;

_dialogResult = 
[
	localize "STR_ADVANCED_WEATHER_CHANGE",
	[
		[localize "STR_TRANSITION",[localize "STR_IMMEDIATE",localize "STR_SMOOTH"]],
		[localize "STR_OVERCAST", "SLIDER"],
		[localize "STR_RAIN_", "SLIDER"],
		[localize "STR_LIGHTNINGS_", "SLIDER"],
		[localize "STR_RAINBOW_", [localize "STR_ALLOWED",localize "STR_PROHIBITED"]],
		[localize "STR_WIND_FORCE", "SLIDER"],
		[localize "STR_WIND_DIRECTION",["N","NE","E","SE","S","SW","W","NW"]],
		[localize "STR_WAVES", "SLIDER"],
		[localize "STR_FOG_SETTING", "SLIDER"],
		[localize "STR_FOG_DECAY", "SLIDER"],
		[localize "STR_Fog_Altitude_ASL", _altitudeDisplayValues]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_rendered = _dialogResult select 0;
_cloudSetting = _dialogResult select 1;
_rainSetting = _dialogResult select 2;
_lightningSetting = _dialogResult select 3;
_rainbowSetting = if ((_dialogResult select 4) == 0) then {1} else {0};
_windForce = (_dialogResult select 5) * 30;
_windDirection = (_dialogResult select 6) * 45;
_windSetting = [-_windForce * sin _windDirection,-_windForce * cos _windDirection,true];
_wavesSetting = _dialogResult select 7;
_fogSetting = _dialogResult select 8;
_fogDecaySetting = SMOOTH_DECAY_VALUE + ((SHARP_DECAY_VALUE - SMOOTH_DECAY_VALUE) * (_dialogResult select 9));
_fogBaseSetting = _altitudes select (_dialogResult select 10);

Ares_var_Weather_Settings = [_rendered,_cloudSetting, _rainSetting, _rainbowSetting, _lightningSetting, _windSetting, _wavesSetting, [_fogSetting, _fogDecaySetting, _fogBaseSetting]];
publicVariable "Ares_var_Weather_Settings";

if (isNil "Ares_Weather_Function") then
{
	Ares_Weather_Function =
	{
		sleep 1;
		while {true} do
		{
			_settings = Ares_var_Weather_Settings;
			_delay = if ((_settings select 0) == 0) then {0} else {30};
			0 setOvercast (_settings select 1);
			_delay setRain (_settings select 2);
			0 setLightnings (_settings select 4);
			sleep 1;
		};
	};
	publicVariable "Ares_Weather_Function";
	remoteExec ["Ares_Weather_Function",0,true];
	Ares_Change_Weather_Function =
	{
		_settings = Ares_var_Weather_Settings;
		_delay = if ((_settings select 0) == 0) then {0} else {30};
		0 setOvercast (_settings select 1);
		_delay setRain (_settings select 2);
		0 setLightnings (_settings select 4);
		_delay setFog (_settings select 7);
		
		0 setRainbow (_settings select 3);
		setWind (_settings select 5);
		_delay setWaves (_settings select 6);
		
		if ((_settings select 0) == 0) then {forceWeatherChange;};
	};
	publicVariable "Ares_Change_Weather_Function";
};

remoteExec ["Ares_Change_Weather_Function",0];

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
