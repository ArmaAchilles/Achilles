/*
	File: fn_moduleEffectsFire.sqf
	Author: Borivoj Hlava, modified by CreepPork_LV

	Description:
	Module function. Creates fire on position of module.

	Parameter(s):
	_this select 0 (Object) - Module logic.
	
	Returned value:
	None.
*/

params ["_logic"];

// Create our dialog to show all the data
private _dialogResult = [
	localize "STR_AMAE_EFFECTS_CUSTOM_FIRE",
	[
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ColorRed_0", "", "0.5"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ColorGreen_0", "", "0.5"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ColorBlue_0", "", "0.5"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_Timeout_0", "", "0"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_FireDamage_0", "", "1"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_EffectSize_0", "", "1"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleDensity_0", "", "25"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleLifeTime_0", "", "0.6"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleSize_0", "", "1"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleSpeed_0", "", "1"],
		[localize "STR_A3_CfgVehicles_ModuleEffectsFire_F_Arguments_ParticleOrientation_0", "", "0"]
	]
] call Ares_fnc_ShowChooseDialog;

// If user pressed cancel
if (_dialogResult isEqualTo []) exitWith {deleteVehicle _logic};

// Send the function to everyone
if (isNil "Achilles_var_moduleEffectFireInit") then
{
	Achilles_var_moduleEffectFireInit = true;
	publicVariable "Achilles_fnc_effectFire";
};

// Create dummy logic because some users may not have Achilles.
private _dummyLogic = _logic call Achilles_fnc_createDummyLogic;

private _source = "#particlesource" createVehicle (getPos _logic);
_dummyLogic setVariable ["effectEmitter",[_source],true];

private _emitter = (_dummyLogic getVariable "effectEmitter") select 0;
_emitter setPos (getPos _logic);

// Get the data
_dialogResult params 
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
	"_orientation"
];

// Convert the strings to numbers
_colorRed = parseNumber _colorRed;
_colorGreen = parseNumber _colorGreen;
_colorBlue = parseNumber _colorBlue;
_timeout = parseNumber _timeout;
_damage = parseNumber _damage;
_effectSize = parseNumber _effectSize;
_particleDensity = parseNumber _particleDensity;
_particleLifeTime = parseNumber _particleLifeTime;
_particleSize = parseNumber _particleSize;
_particleSpeed = parseNumber _particleSpeed;
_orientation = parseNumber _orientation;

if (_colorRed > 1) then {_colorRed = 1};
if (_colorRed < 0) then {_colorRed = 0};
if (_colorGreen > 1) then {_colorGreen = 1};
if (_colorGreen < 0) then {_colorGreen = 0};
if (_colorBlue > 1) then {_colorBlue = 1};
if (_colorBlue < 0) then {_colorBlue = 0};

// Attach the emitter so it moves when the curator's module is adjusted.
_emitter attachTo [_dummyLogic];

// Run the code for everyone on the server
[_colorRed, _colorGreen, _colorBlue, _timeout, _damage, _effectSize, _particleDensity, _particleLifeTime, _particleSize, _particleSpeed, _orientation, _emitter, _dummyLogic, player] remoteExecCall ["Achilles_fnc_effectFire", 0, _dummyLogic]