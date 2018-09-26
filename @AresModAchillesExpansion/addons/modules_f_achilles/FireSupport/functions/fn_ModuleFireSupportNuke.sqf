/*
	Function:
		Achilles_fnc_ModuleFireSupportNuke
	Authors:
		Moerderhoschi, Kex, BI (Arma 2)
*/
#include "\achilles\modules_f_ares\module_header.h"

private _center = getPos _logic;
private _dialogResults =
[
	localize "STR_AMAE_ATOMIC_BOMB",
	[
		[[localize "STR_AMAE_RADIUS", localize "STR_AMAE_METER"] joinString "", "", "300"],
		[localize "STR_AMAE_DESTROYED_OBJECTS_PER_SECOND", "", "200"],
		[localize "STR_AMAE_COLOR_CORRECTION", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]]
	]
] call Ares_fnc_showChooseDialog;

if (count _dialogResults == 0) exitWith {};

_dialogResults params
[
	"_destructionRadius",
	"_destructionRate",
	"_doColorCorrection"
];
private _destructionRadius = parseNumber _destructionRadius;
private _destructionRate = round parseNumber _destructionRate;
_doColorCorrection = _doColorCorrection isEqualTo 0;

[[_center, _destructionRadius, _destructionRate, _doColorCorrection],
{
	params
	[
		"_center",
		"_destructionRadius",
		"_destructionRate",
		"_doColorCorrection"
	];
	if (isServer) exitWith
	{
		sleep 5;
		// big destruction
		if (_destructionRadius > 0 && _destructionRate > 0) then
		{
			private _objects = (nearestObjects [_center, [], _destructionRadius]);
			private _numberOfObjects = count _objects;
			private _n = ceil (_numberOfObjects/_destructionRate);
			for "_i" from 1 to _n do
			{
				private _idxStart = (_i-1)*_destructionRate;
				private _currentArrayLength = _numberOfObjects - _idxStart - 1; 
				_currentArrayLength = [_currentArrayLength, _destructionRate] select (_currentArrayLength > _destructionRate);
				{
					// Do not kill HCs and curators.
					if (isNull getAssignedCuratorLogic _x && !(_x isKindOf "HeadlessClient_F") && isNil {_x getVariable ["Achilles_var_switchUnit_data", nil]}) then
					{
						_x setDamage 1;
					};
				} forEach (_objects  select [_idxStart , _currentArrayLength]);
				sleep 1;
			};
			
		};
	};
	if !(hasInterface) exitWith {};
	
	// Mushroom cloud
	private _nukeSource = "Land_HelipadEmpty_F" createVehicleLocal _center;

	private _cone = "#particlesource" createVehicleLocal _center;
	_cone setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
					[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
					[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", _nukeSource];
	_cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_cone setParticleCircle [10, [-10, -10, 20]];
	_cone setDropInterval 0.005;

	private _top = "#particlesource" createVehicleLocal _center;
	_top setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _nukeSource];
	_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top setDropInterval 0.002;

	private _top2 = "#particlesource" createVehicleLocal _center;
	_top2 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", _nukeSource];
	_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top2 setDropInterval 0.002;

	private _smoke = "#particlesource" createVehicleLocal _center;
	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [40,15,120], 
					[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _nukeSource];
	_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke setDropInterval 0.002;

	private _wave = "#particlesource" createVehicleLocal _center;
	_wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _nukeSource];
	_wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_wave setParticleCircle [50, [-80, -80, 2.5]];
	_wave setDropInterval 0.0002;


	private _light = "#lightpoint" createVehicleLocal (_center vectorAdd [0,0,500]);
	_light setLightAmbient[1500, 1200, 1000];
	_light setLightColor[1500, 1200, 1000];
	_light setLightBrightness 100000.0;

	//*******************************************************************

	if (_doColorCorrection) then
	{
		// Color Correction
		"colorCorrections" ppEffectAdjust [2, 30, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
		"colorCorrections" ppEffectCommit 0;
		"colorCorrections" ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];  
		"colorCorrections" ppEffectCommit 3;
		"colorCorrections" ppEffectEnable true;
		"filmGrain" ppEffectEnable true; 
		"filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
		"filmGrain" ppEffectCommit 5;
	}
	else
	{
		// create a bright flash
		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [1];
		"dynamicBlur" ppEffectCommit 1;

		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 0.4;
		 
		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 3;

		[] spawn
		{
			sleep 1;
			"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
			"colorCorrections" ppEffectCommit 2;
		};


		"dynamicBlur" ppEffectAdjust [2];
		"dynamicBlur" ppEffectCommit 1;

		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 4;

		sleep 4.5;

		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 1; "colorCorrections" ppEffectEnable TRUE;
		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit 1;
	};

	// Suppress music
	0 fadeMusic 1;
	15 fadeMusic 0;

	// Earthquake
	[3] spawn BIS_fnc_earthquake;
	
	// Ash
	[] spawn {
		sleep 20;
		private _pos = position player;
		private _parray =
		[
			["A3\Data_F\ParticleEffects\Universal\Universal", 16, 12, 8, 1],
			"",
			"Billboard",
			1,
			4,
			[0,0,0],
			[0,0,0],
			1,
			0.000001,
			0,
			1.4,
			[0.05,0.05],
			[[0.1,0.1,0.1,1]],
			[0,1],
			0.2,
			1.2,
			"",
			"",
			vehicle player
		];
		private _snow = "#particlesource" createVehicleLocal _pos;  
		_snow setParticleParams _parray;
		_snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
		_snow setParticleCircle [0.0, [0, 0, 0]];
		_snow setDropInterval 0.01;
	};

	_wave setDropInterval 0.001;
	deletevehicle _top;
	deletevehicle _top2;

	enableCamShake true;
	addCamShake [5, 10, 25];

	sleep 4.5;

	private _i = 0;
	while {_i < 100} do
	{
		_light setLightBrightness 100.0 - _i;
		_i = _i + 1;
		sleep 0.1;
	};
	deleteVehicle _light;
	enableCamShake false;

	sleep 2;

	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 45], 0, 1.7, 1, 0, [40,25,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _nukeSource];

	_cone setDropInterval 0.01;
	_smoke setDropInterval 0.006;
	_wave setDropInterval 0.001;

	sleep 2;

	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 30], 0, 1.7, 1, 0, [40,25,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _nukeSource];
	_smoke setDropInterval 0.012;
	_cone setDropInterval 0.02;
	_wave setDropInterval 0.01;

	sleep 15;
	deleteVehicle _wave;
	deleteVehicle _cone;
	deleteVehicle _smoke;
	deleteVehicle _nukeSource;
}, 0] call Achilles_fnc_spawn;

#include "\achilles\modules_f_ares\module_footer.h"
