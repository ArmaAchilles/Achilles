/*
	Function:
		Achilles_fnc_advancedPlaneCAS
	
	Authors:
		Kex
	
	Description:
		Forces a plane to perform a CAS run.
		This function has to be executed in the scheduled environment on the machine the unit is local.
		It seems that the function doesn't work on machines without an interface (e.g. sever or HC)
	
	Parameters:
		_aircraft						- <OBJECT> The plane that performs the CAS run
		_target							- <OBJECT> The target object (has to be a logic)
		_weaponMuzzleMagazineIdx		- <ARRAY> of <INTEGER>
											_weapIdx	- <INTEGER> Weapon index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
											_muzzleIdx	- <INTEGER> Muzzle index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
											_magIdx		- <INTEGER> Magazine index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
		_offsetCustom					- <ARRAY> [0] Target offset in meters that will be added to the weapon's offset
											Can be used for fine-tuning the targeting
											E.g. -25 means the plane will target 25 m in front of the target.
	
	Returns:
		_success						- <BOOLEAN> True if the CAS run was completed without occurring exception
	
	Examples:
		(begin example)
		// Perform CAS with _jet on _target with the first weapon returned by Achilles_fnc_getWeaponsMuzzlesMagazines.
		[_jet, _target, [0,0,0]] call Achilles_fnc_advancedBlackfishCAS;
		(end)
*/

// General params
#define AVG_GRAV_ACC_EARTH			9.807
#define MIN_MAX_ACC_AIRCRAFT		5
// Aircraft limits
#define BANKED_TURN_PERIOD			30
#define BANK_PERIOD					10
#define PITCH_PERIOD				22
// The maximal climbing angle is only a crude constraint!
// The maximal climbing angle is limited to ]-90,90[ by the definition of a function
#define MAX_CLIMBING_ANGLE			30
// CAS trajectory params
#define MIN_DIST_2D_PITCHED_TURN	300
#define RADIUS_AO					1500
#define DELTA_Z_TRAVEL				500
#define SPEED_CAS					(400 / 3.6)
#define DIST_CAS_START				1000
#define PITCH_CAS					(-atan (1/3))
// Weapon params
#define ROCKES_PER_STRIKE			6
#define MISSILES_PER_STRIKE			1
// Precalculations
#define RADIUS_CAS_START			(DIST_CAS_START * cos(PITCH_CAS))
#define RADIUS_BANKED_TURN			(SPEED_CAS*BANKED_TURN_PERIOD/2/pi)
#define ANGLE_BANKED_TURN			(atan (SPEED_CAS / (BANKED_TURN_PERIOD/2/pi*AVG_GRAV_ACC_EARTH)))
params
[
	"_aircraft",
	"_target",
	"_weaponMuzzleMagazineIdx",
	["_offsetCustom", 0, [0]]
];
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
private _classNameAircraft = typeOf _aircraft;
private _speedMax = getNumber (configfile >> "CfgVehicles" >> _classNameAircraft >> "maxSpeed");
private _accMax = (14.5*(selectMax getArray (configfile >> "CfgVehicles" >> _classNameAircraft >> "thrustCoef")) - 11.5) max MIN_MAX_ACC_AIRCRAFT;

// Get the initial state of the aircraft
private _posStart = _aircraft modelToWorldVisualWorld [0,0,0];
// The usage of angles instead of vectors is more suitable for trajectories
([_aircraft] call Achilles_fnc_getDirPitchBank) params ["_dirStart", "_pitchStart", "_bankStart"];
private _vectDirStart = vectorDirVisual _aircraft;
// Estimate velocity vector in rendered time, as there is not velocityVisual command
private _velStart = _vectDirStart vectorMultiply (vectorMagnitude velocity _aircraft);
private _speedStart = vectorMagnitude _velStart;
private _speedXYStart = vectorMagnitude [_velStart#0, _velStart#1, 0];
private _speedZStart = _velStart#2;

// get weapon, muzzle, magazine info and unpack it
_weaponMuzzleMagazineIdx params ["_weapIdx", "_muzzleIdx", "_magIdx"];
private _weaponsAndMuzzlesAndMagazines = [_aircraft] call Achilles_fnc_getWeaponsMuzzlesMagazines;
if (_weaponsAndMuzzlesAndMagazines isEqualTo []) exitWith {false};
if (count _weaponsAndMuzzlesAndMagazines <= _weapIdx) then {_weapIdx = 0};
(_weaponsAndMuzzlesAndMagazines select _weapIdx) params [["_weaponAndTurret","",["",[]]], ["_muzzlesAndMagazines",[""],[[]]]];
// get the weapon and gunner
_weaponAndTurret params [["_weapon","",[""]], ["_turretPath",[],[[]]]];
private _gunner = if (_turretPath isEqualTo []) then {_aircraft} else {_aircraft turretUnit _turretPath};
// cease fire if group mate is too close to line of fire
// get the muzzle and magazines
if (count _muzzlesAndMagazines <= _muzzleIdx) then {_muzzleIdx = 0};
(_muzzlesAndMagazines select _muzzleIdx) params [["_muzzle","",[""]], ["_magazines",[""],[[]]]];
if (count _magazines <= _magIdx) then {_magIdx = 0};
private _magazine = _magazines select _magIdx;
// get the correct muzzle
private _muzzleCfg = configNull;
if (_muzzle == "this") then
{
	_muzzle = _weapon;
	_muzzleCfg = (configFile >> "CfgWeapons" >> _weapon);
}
else
{
	_muzzleCfg = (configFile >> "CfgWeapons" >> _weapon >> _muzzle);
};	
// get the weapon mode
_aircraft selectWeaponTurret [_muzzle, _turretPath];
_aircraft loadMagazine [_turretPath, _muzzle, _magazine];
reload _aircraft;
private _mode = (weaponState [_aircraft, _turretPath, _weapon])select 2;
// get the reload time
private _reloadTime = 0.1;
if (_mode == "this") then
{
	_reloadTime = getNumber (_muzzleCfg >> "reloadTime");
}
else
{
	_reloadTime = getNumber (_muzzleCfg >> _mode >> "reloadTime");
};
// Get max rounds and offset
private _weaponType = getText (configFile >> "cfgWeapons" >> _weapon >> "nameSound");
private _offsetWeapon = _offsetCustom;
private _maxRounds = -1;
switch (_weaponType) do
{
	case "cannon":
	{
		_maxRounds = 1e9;
	};
	case "rockets": 
	{
		_maxRounds = ROCKES_PER_STRIKE;
	};
	case "MissileLauncher":
	{
		_offsetWeapon = _offsetWeapon + 40;
		_maxRounds = MISSILES_PER_STRIKE;
	};
	default 
	{
		// for bomb runs
		_offsetWeapon = _offsetWeapon + 170;
		_maxRounds = 1;
	};
};

// Target location
private _posTarget = _target modelToWorldVisualWorld [0,0,0];

// Pitched turn trajectory
private _dzStart = _posStart#2 - (_posTarget#2);
private _dzPitchedTurn = DELTA_Z_TRAVEL - _dzStart;
private _distXYPitchedTurn = abs(_dzPitchedTurn)/tan(MAX_CLIMBING_ANGLE);
_distXYPitchedTurn = [MIN_DIST_2D_PITCHED_TURN, _distXYPitchedTurn] select (_distXYPitchedTurn > MIN_DIST_2D_PITCHED_TURN);
// Determine the start position for the banked turn
private _posBankedTurnStart = _posStart vectorAdd [_distXYPitchedTurn*cos(_dirStart),_distXYPitchedTurn*sin(_dirStart),_dzPitchedTurn];
if (_posTarget distance2D _posBankedTurnStart < (RADIUS_AO - _offsetWeapon + 2*RADIUS_BANKED_TURN)) then
{
	// The aircraft is too close to the target. The quadratic equation below gives us the signed magnitude of the displacement vector that will move the plane sufficiently far away
	private _a = _vectDirStart#0^2 + _vectDirStart#1^2;
	private _b = 2*(_vectDirStart#0*_posBankedTurnStart#0 - _vectDirStart#0*_posTarget#0 + _vectDirStart#1*_posBankedTurnStart#1 - _vectDirStart#1*_posTarget#1);
	private _c = _posBankedTurnStart#0^2 - 2*_posBankedTurnStart#0*_posTarget#0 + _posBankedTurnStart#1^2 - 2*_posBankedTurnStart#1*_posTarget#1 + _posTarget#0^2 + _posTarget#1^2 - (RADIUS_AO - _offsetWeapon + 2*RADIUS_BANKED_TURN)^2;
	// The displacement has to be in the direction of travel, hence we are only interested in the positive solution
	private _lambda = (sqrt (_b^2 - 4*_a*_c) - _b) / 2 / _a;
	_posBankedTurnStart = ([cos(_dirStart),sin(_dirStart),0] vectorMultiply _lambda) vectorAdd _posBankedTurnStart;
	// Update the distance
	_distXYPitchedTurn = _distXYPitchedTurn + vectorMagnitude (_vectDirStart vectorMultiply _lambda);
};
// Duration and acceleration in xy-plane
private _dtPitchedTurn = 2*_distXYPitchedTurn/(_speedXYStart + SPEED_CAS);
private _gd2dt2PitchedTurn = (SPEED_CAS - _speedXYStart)/_dtPitchedTurn;
private _fncTrajPitchedTurn =
{
	params ["_t"];
	// _g is the traveled distance on the xy-plane
	private _g = 1/2*_gd2dt2PitchedTurn*_t^2 + _speedXYStart*_t;
	private _gddt = _gd2dt2PitchedTurn*_t + _speedXYStart;
	private _z = [_t, 0, _dzPitchedTurn, _speedZStart, 0, 0, _dtPitchedTurn] call Achilles_fnc_interpolation_cubicBezier1D;
	private _zddt = [_t, 0, _dzPitchedTurn, _speedZStart, 0, 0, _dtPitchedTurn] call Achilles_fnc_interpolation_cubicBezier1D_slope;
	private _pos = [_g*cos(_dirStart),_g*sin(_dirStart),_z] vectorAdd _posStart;
	private _vel = [_gddt*cos(_dirStart),_gddt*sin(_dirStart),_zddt];
	private _pitch = atan(_zddt/_gddt);
	// Bank angle based on linear interpolation
	private _signBank = [-1,1] select (_bankStart >=0);
	private _bankRestorer = _bankStart - _signBank * 360/BANK_PERIOD * _t;
	private _bank = [0, _bankRestorer] select (_signBank * _bankRestorer > 0);
	([_dirStart, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dirStart,_pitch,_bank]
};

// Banked turn trajectory
// Get the circle
private _rotSignBankedTurn = 1;
private _vectRBankedTurnStart = ([cos(_dirStart),sin(_dirStart),0] vectorCrossProduct [0,0,1]) vectorMultiply RADIUS_BANKED_TURN;
if (_vectRBankedTurnStart vectorDotProduct (_posTarget vectorDiff _posBankedTurnStart) > 0) then
{
	// Rotate in clockwise sense as it is shorter
	_rotSignBankedTurn = -1;
	_vectRBankedTurnStart = _vectRBankedTurnStart vectorMultiply _rotSignBankedTurn;
};
private _posBankedTurnCenter = _posBankedTurnStart vectorDiff _vectRBankedTurnStart;
private _angleBankedTurnStart = _dirStart - _rotSignBankedTurn*90;
// Get end position
private _alpha = _rotSignBankedTurn * acos (RADIUS_BANKED_TURN / (_posTarget distance2D _posBankedTurnCenter));
private _angleBankedTurnEnd = ([[1,0,0], _posTarget vectorDiff _posBankedTurnCenter] call Achilles_fnc_vectAngleXY) - _alpha;
if (_rotSignBankedTurn > 0) then
{
	if (_angleBankedTurnStart > _angleBankedTurnEnd) then {_angleBankedTurnStart = _angleBankedTurnStart - 360};
}
else
{
	if (_angleBankedTurnStart < _angleBankedTurnEnd) then {_angleBankedTurnStart = _angleBankedTurnStart + 360}	;
};
private _posBankedTurnEnd = _posBankedTurnCenter vectorAdd ([cos(_angleBankedTurnEnd), sin(_angleBankedTurnEnd), 0] vectorMultiply RADIUS_BANKED_TURN);
// Timing
private _tStartBankedTurn = _dtPitchedTurn;
private _dtBankedTurn = abs (2*pi*RADIUS_BANKED_TURN * (_angleBankedTurnEnd - _angleBankedTurnStart)/360) / _speedStart;
private _fncTrajBankedTurn =
{
	params["_t"];
	private _lambda = (_t - _tStartBankedTurn) / _dtBankedTurn;
	private _angle = (_angleBankedTurnEnd - _angleBankedTurnStart)*_lambda + _angleBankedTurnStart;
	private _vectR = [cos _angle, sin _angle, 0] vectorMultiply RADIUS_BANKED_TURN;
	private _pos = _vectR vectorAdd _posBankedTurnCenter;
	private _dir = _angle + _rotSignBankedTurn*90;
	private _pitch = 0;
	// Bank angle based on linear interpolation
	private _bankStarter = 360/BANK_PERIOD * (_t - _tStartBankedTurn);
	private _bankRestorer = 360/BANK_PERIOD * (_tStartApproachAO - _t);
	private _bank = switch (true) do
	{
		case (_bankStarter > ANGLE_BANKED_TURN and _bankRestorer > ANGLE_BANKED_TURN): {ANGLE_BANKED_TURN};
		case (_bankStarter > _bankRestorer): {_bankRestorer};
		default {_bankStarter};
	};
	_bank = -_rotSignBankedTurn*_bank;
	([_dir, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	private _vel = _vectDir vectorMultiply SPEED_CAS;
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dirStart,_pitch,_bank]
};

// Approach AO trajectory
private _dirBankedTurnEnd = _angleBankedTurnEnd + _rotSignBankedTurn*90;
private _vectDirBankedTurnEnd = [cos(_dirBankedTurnEnd),sin(_dirBankedTurnEnd),0];
private _distXYApproachAO = (_posBankedTurnEnd distance2D _posTarget) - RADIUS_AO + _offsetWeapon;
private _posAOStart = _posBankedTurnEnd vectorAdd (_vectDirBankedTurnEnd vectorMultiply _distXYApproachAO);
private _tStartApproachAO = _tStartBankedTurn + _dtBankedTurn;
private _gd2dt2MaxApproachAO = _accMax;
private _dtApproachAO = 3*(sqrt(SPEED_CAS^2 + 2/3*_distXYApproachAO*_gd2dt2MaxApproachAO) - SPEED_CAS)/_gd2dt2MaxApproachAO;
private _gddtMaxApproachAO = 1/4*_gd2dt2MaxApproachAO*_dtApproachAO + SPEED_CAS;
if(_gddtMaxApproachAO > _speedMax) then
{
	_gddtMaxApproachAO = _speedMax;
	_gd2dt2MaxApproachAO = 4/3*(2*_gddtMaxApproachAO^2-_gddtMaxApproachAO*SPEED_CAS-SPEED_CAS^2)/_distXYApproachAO;
	_dtApproachAO = 3*(sqrt(SPEED_CAS^2 + 2/3*_distXYApproachAO*_gd2dt2MaxApproachAO) - SPEED_CAS)/_gd2dt2MaxApproachAO;
};
_fncTrajApproachAO =
{
	params ["_t"];
	private _t = _t - _tStartApproachAO;
	private _g = -1/3*_gd2dt2MaxApproachAO/_dtApproachAO*_t^3 + 0.5*_gd2dt2MaxApproachAO*_t^2 + SPEED_CAS*_t;
	private _gddt = -_gd2dt2MaxApproachAO/_dtApproachAO*_t^2 + _gd2dt2MaxApproachAO*_t + SPEED_CAS;
	private _pos = _posBankedTurnEnd vectorAdd (_vectDirBankedTurnEnd vectorMultiply _g);
	private _vel = _vectDirBankedTurnEnd vectorMultiply _gddt;
	[_pos,_vel,_vectDirBankedTurnEnd,[0,0,1],_dirBankedTurnEnd,0,0]
};

// Pre-CAS trajectory
private _speedXYCas = SPEED_CAS*cos(PITCH_CAS);
private _speedZCas = SPEED_CAS*sin(PITCH_CAS);
private _dzCasStart = DIST_CAS_START * sin(PITCH_CAS);
private _dzPreCAS = - DELTA_Z_TRAVEL - _dzCasStart;
private _distXYPreCAS = RADIUS_AO - RADIUS_CAS_START + _offsetWeapon;
// Duration and acceleration in xy-plane
private _tStartPreCAS = _tStartApproachAO + _dtApproachAO;
private _dtPreCAS = 2*_distXYPreCAS/(_speedXYCas + SPEED_CAS);
private _gd2dt2PreCAS = (_speedXYCas - SPEED_CAS)/_dtPreCAS;
private _fncTrajPreCAS =
{
	params ["_t"];
	private _t = _t - _tStartPreCAS;
	// _g is the traveled distance on the xy-plane
	private _g = 1/2*_gd2dt2PreCAS*_t^2 + SPEED_CAS*_t;
	private _gddt = _gd2dt2PreCAS*_t + SPEED_CAS;
	private _z = [_t, 0, _dzPreCAS, 0, _speedZCas, 0, _dtPreCAS] call Achilles_fnc_interpolation_cubicBezier1D;
	private _zddt = [_t, 0, _dzPreCAS, 0, _speedZCas, 0, _dtPreCAS] call Achilles_fnc_interpolation_cubicBezier1D_slope;
	private _pos = [_g*cos(_dirBankedTurnEnd),_g*sin(_dirBankedTurnEnd),_z] vectorAdd _posAOStart;
	private _vel = [_gddt*cos(_dirBankedTurnEnd),_gddt*sin(_dirBankedTurnEnd),_zddt];
	private _pitch = atan(_zddt/_gddt);
	private _bank = 0;
	([_dirBankedTurnEnd, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dirBankedTurnEnd,_pitch,_bank]
};

// CAS trajectory (just the params for setVelocityTransformation)
private _tStartCas = _tStartPreCAS + _dtPreCAS;
([_tStartCas] call _fncTrajPreCAS) params ["_posCasStart", "_velCas", "_vectDirCas", "_vectUpCas"];
private _posCasEnd = _posCasStart vectorAdd (_vectDirCas vectorMultiply DIST_CAS_START);
private _dtCas = DIST_CAS_START/SPEED_CAS;

// Start the simulation
private _tStart = time;
_aircraft disableAI "MOVE";
waitUntil
{
	private _t = time - _tStart;
	private _fncCurTraj = {};
	switch (true) do
	{
		case (_t > _tStartPreCAS):
		{
			(_t call _fncTrajPreCAS) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		case (_t > _tStartApproachAO):
		{
			(_t call _fncTrajApproachAO) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		case (_t > _tStartBankedTurn): 
		{
			(_t call _fncTrajBankedTurn) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		default
		{
			(_t call _fncTrajPitchedTurn) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
	};
	sleep 0.01;
	(_t > _tStartPreCAS + _dtPreCAS) || !alive _aircraft || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0
};
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};

// Start firing

private _fireHandle = [_aircraft, _gunner, _muzzle, _magazine, _turretPath, _reloadTime, _maxRounds, _target] spawn
{
	params ["_aircraft", "_gunner", "_muzzle", "_magazine", "_turretPath", "_reloadTime", "_maxRounds", "_target"];
	// Launch flares
	[_aircraft, [5, 1.1]] call Achilles_fnc_LaunchCM;
	// Create a laser target if non exits
	private _targetType = if (side _aircraft getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
	private _laserTarget = ((position _target nearEntities [_targetType,250])) param [0,objnull];
	if (isnull _laserTarget) then {
		_laserTarget = createvehicle [_targetType,position _target,[],0,"none"];
	};
	// prevent AI from launching a bomb automatically
	_aircraft disableAI "TARGET";
	_aircraft disableAI "AUTOTARGET";
	_aircraft reveal laserTarget _laserTarget;
	_aircraft doWatch laserTarget _laserTarget;
	_aircraft doTarget laserTarget _laserTarget;
	// Start firing
	private _time = time;
	private _iFire = 1;
	waitUntil {
		_aircraft selectWeaponTurret [_muzzle, _turretPath];
		_aircraft setWeaponReloadingTime [_gunner, _muzzle, 0];
		[_target, _gunner, _muzzle, _magazine, _aircraft, _turretPath] call Achilles_fnc_forceWeaponFire;
		sleep _reloadTime;
		_iFire = _iFire + 1;
		_time + 3 < time || _iFire > _maxRounds || !alive _aircraft || !alive driver _aircraft
	};
	_aircraft enableAI "TARGET";
	_aircraft enableAI "AUTOTARGET";
};
// Approach the target while firing
// Would have been _fncTrajCAS, but we use setVelocityTransformation directly
private _time = time;
waitUntil
{
	_aircraft setVelocityTransformation [_posCasStart,_posCasEnd,_velCas,_velCas,_vectDirCas,_vectDirCas,_vectUpCas,_vectUpCas,(time - _time)/_dtCas];
	_aircraft setVelocity _velCas;
	sleep 0.01;
	scriptDone _fireHandle || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0;
};
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
_aircraft enableAI "MOVE";
true;
