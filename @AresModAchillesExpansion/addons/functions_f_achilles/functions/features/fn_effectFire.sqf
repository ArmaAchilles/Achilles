/*
	Author: Borivoj Hlava, CreepPork_LV

	Description:
	 Creates a fire effect.

  Parameters:
    _this select: 0 - NUMBER - Value of the Color Red
    _this select: 1 - NUMBER - Value of the Color Green
    _this select: 2 - NUMBER - Value of the Color Blue
    _this select: 3 - NUMBER - Timeout
    _this select: 4 - NUMBER - Damage
    _this select: 5 - NUMBER - Effect Size
    _this select: 6 - NUMBER - Particle Density
    _this select: 7 - NUMBER - Particle Life Time
    _this select: 8 - NUMBER - Particle Size
	_this select: 9 - NUMBER - Particle Speed
    _this select: 10 - NUMBER - Particle Orientation
	_this select: 11 - OBJECT - Effect Emitter
	_this select: 12 - OBJECT - (Dummy) Logic
    _this select: 13 - OBJECT - Unit who placed down the Fire Effect module

  Returns:
    Nothing
*/

params 
[
	"_colorRed",
	"_colorGreen",
	"_colorBlue",
	"_timeout",
	"_damage",
	"_effectSize",
	"_particleDensity",
	"_particleLifeTime",
	"_particleSize",
	"_particleSpeed",
	"_orientation",
	"_emitter",
	"_logic",
	"_curator"
];

hint "Something's happening!";
systemChat str (getPos _logic);
systemChat str (_logic);
diag_log (format ["Logic Pos: %1 - Logic ref: %2 - Emittor: %3", getPos _logic, _logic, _emitter]);

private _pos = getPos _logic;

//--- particle effect creation
_emitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32],"","billboard",1,_particleLifeTime,[0,0,0],[0,0,0.4*_particleSpeed],0,0.0565,0.05,0.03,[0.9*_particleSize,0],
						[[1*_colorRed,1*_colorGreen,1*_colorBlue,-0],[1*_colorRed,1*_colorGreen,1*_colorBlue,-1],[1*_colorRed,1*_colorGreen,1*_colorBlue,-1],[1*_colorRed,1*_colorGreen,1*_colorBlue,-1],[1*_colorRed,1*_colorGreen,1*_colorBlue,-1],[1*_colorRed,1*_colorGreen,1*_colorBlue,0]],
						[1], 0.01, 0.02, "", "", "",_orientation,false,-1,[[3,3,3,0]]];
_emitter setParticleRandom [_particleLifeTime/4, [0.15*_effectSize,0.15*_effectSize,0], [0.2,0.2,0], 0.4, 0, [0,0,0,0], 0, 0, 0.2];
if (_damage > 0) then {_emitter setParticleFire [0.6*_damage, 0.25*_damage, 0.1];};
_emitter setDropInterval (1/_particleDensity);

//--- light
private _lightSize = (_particleSize + _effectSize)/2;

private _light = createVehicle ["#lightpoint", (getPos _emitter), [], 0, "NONE"];
_light setPos [_pos select 0,_pos select 1,(_pos select 2) + 0.5];
_light setLightBrightness 1.0;
_light setLightColor [1,0.65,0.4];
_light setLightAmbient [0.15,0.05,0];
_light setLightIntensity (50 + 400*_lightSize);
_light setLightAttenuation [0,0,0,1];
_light setLightDayLight false;
_light attachTo [_logic];

_logic setVariable ["effectLight",[_light],true];

//--- timeout
if (_timeout != 0) then {
	[_logic,_timeout, _curator] spawn {
		scriptName "fn_moduleEffectsFire_timeoutLoop";
		params ["_logic", "_timeout", "_curator"];
		
		sleep _timeout;
		deleteVehicle ((_logic getVariable "effectEmitter") select 0);
		deleteVehicle ((_logic getVariable "effectLight") select 0);
		if (player == _curator) then {deleteVehicle (_logic getVariable ["Achilles_var_createDummyLogic_module", objNull])};
	};
}
else
{
	[_logic, ((_logic getVariable "effectEmitter") select 0), ((_logic getVariable "effectLight") select 0)] spawn
	{
		scriptName "fn_moduleEffectsFire_awaitDeletionLoop";
		params ["_logic", "_emitter", "_light"];
		
		// Wait until the logic is deleted and clean up the effects
		waitUntil {isNull _logic};
		deleteVehicle _emitter;
		deleteVehicle _light;
	};
};