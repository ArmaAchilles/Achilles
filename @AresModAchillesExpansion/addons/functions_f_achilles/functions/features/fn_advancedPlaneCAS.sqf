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
		_offset_custom					- <ARRAY> [0] Target offset in meters that will be added to the weapon's offset
											Can be used for fine-tuning the targeting
											E.g. -25 means the plane will target 25 m in front of the target.
	
	Returns:
		_success						- <BOOLEAN> True if the CAS run was completed without occurring exception
	
	Exampes:
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
	["_offset_custom", 0, [0]]
];
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
private _className_aircraft = typeOf _aircraft;
private _speed_max = getNumber (configfile >> "CfgVehicles" >> _className_aircraft >> "maxSpeed");
private _acc_max = (14.5*(selectMax getArray (configfile >> "CfgVehicles" >> _className_aircraft >> "thrustCoef")) - 11.5) max MIN_MAX_ACC_AIRCRAFT;

// Get the initial state of the aircraft
private _pos_start = _aircraft modelToWorldVisualWorld [0,0,0];
// The usage of angles instead of vectors is more suitable for trajectories
([_aircraft] call Achilles_fnc_getDirPitchBank) params ["_dir_start", "_pitch_start", "_bank_start"];
private _vectDir_start = vectorDirVisual _aircraft;
// Estimate velocity vector in rendered time, as there is not velocityVisual command
private _vel_start = _vectDir_start vectorMultiply (vectorMagnitude velocity _aircraft);
private _speed_start = vectorMagnitude _vel_start;
private _speedXY_start = vectorMagnitude [_vel_start#0, _vel_start#1, 0];
private _speedZ_start = _vel_start#2;

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
private _offset_weapon = _offset_custom;
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
		_offset_weapon = _offset_weapon + 40;
		_maxRounds = MISSILES_PER_STRIKE;
	};
	default 
	{
		// for bomb runs
		_offset_weapon = _offset_weapon + 170;
		_maxRounds = 1;
	};
};

// Target location
private _pos_target = _target modelToWorldVisualWorld [0,0,0];

// Pitched turn trajectory
private _dz_start = _pos_start#2 - (_pos_target#2);
private _dz_pitchedTurn = DELTA_Z_TRAVEL - _dz_start;
private _distXY_pitchedTurn = abs(_dz_pitchedTurn)/tan(MAX_CLIMBING_ANGLE);
_distXY_pitchedTurn = [MIN_DIST_2D_PITCHED_TURN, _distXY_pitchedTurn] select (_distXY_pitchedTurn > MIN_DIST_2D_PITCHED_TURN);
// Determine the start position for the banked turn
private _pos_bankedTurn_start = _pos_start vectorAdd [_distXY_pitchedTurn*cos(_dir_start),_distXY_pitchedTurn*sin(_dir_start),_dz_pitchedTurn];
if (_pos_target distance2D _pos_bankedTurn_start < (RADIUS_AO - _offset_weapon + 2*RADIUS_BANKED_TURN)) then
{
	// The aircraft is too close to the target. The quadratic equation below gives us the signed magnitude of the displacement vector that will move the plane sufficiently far away
	private _a = _vectDir_start#0^2 + _vectDir_start#1^2;
	private _b = 2*(_vectDir_start#0*_pos_bankedTurn_start#0 - _vectDir_start#0*_pos_target#0 + _vectDir_start#1*_pos_bankedTurn_start#1 - _vectDir_start#1*_pos_target#1);
	private _c = _pos_bankedTurn_start#0^2 - 2*_pos_bankedTurn_start#0*_pos_target#0 + _pos_bankedTurn_start#1^2 - 2*_pos_bankedTurn_start#1*_pos_target#1 + _pos_target#0^2 + _pos_target#1^2 - (RADIUS_AO - _offset_weapon + 2*RADIUS_BANKED_TURN)^2;
	// The displacement has to be in the direction of travel, hence we are only interested in the positive solution
	private _lambda = (sqrt (_b^2 - 4*_a*_c) - _b) / 2 / _a;
	_pos_bankedTurn_start = ([cos(_dir_start),sin(_dir_start),0] vectorMultiply _lambda) vectorAdd _pos_bankedTurn_start;
	// Update the distance
	_distXY_pitchedTurn = _distXY_pitchedTurn + vectorMagnitude (_vectDir_start vectorMultiply _lambda);
};
// Duration and acceleration in xy-plane
private _dt_pitchedTurn = 2*_distXY_pitchedTurn/(_speedXY_start + SPEED_CAS);
private _g_d2dt2_pitchedTurn = (SPEED_CAS - _speedXY_start)/_dt_pitchedTurn;
private _fnc_traj_pitchedTurn =
{
	params ["_t"];
	// _g is the traveled distance on the xy-plane
	private _g = 1/2*_g_d2dt2_pitchedTurn*_t^2 + _speedXY_start*_t;
	private _g_ddt = _g_d2dt2_pitchedTurn*_t + _speedXY_start;
	private _z = [_t, 0, _dz_pitchedTurn, _speedZ_start, 0, 0, _dt_pitchedTurn] call Achilles_fnc_interpolation_cubicBezier1D;
	private _z_ddt = [_t, 0, _dz_pitchedTurn, _speedZ_start, 0, 0, _dt_pitchedTurn] call Achilles_fnc_interpolation_cubicBezier1D_slope;
	private _pos = [_g*cos(_dir_start),_g*sin(_dir_start),_z] vectorAdd _pos_start;
	private _vel = [_g_ddt*cos(_dir_start),_g_ddt*sin(_dir_start),_z_ddt];
	private _pitch = atan(_z_ddt/_g_ddt);
	// Bank angle based on linear interpolation
	private _sign_bank = [-1,1] select (_bank_start >=0);
	private _bank_restorer = _bank_start - _sign_bank * 360/BANK_PERIOD * _t;
	private _bank = [0, _bank_restorer] select (_sign_bank * _bank_restorer > 0);
	([_dir_start, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dir_start,_pitch,_bank]
};

// Banked turn trajectory
// Get the circle
private _rotSign_bankedTurn = 1;
private _vectR_bankedTurn_start = ([cos(_dir_start),sin(_dir_start),0] vectorCrossProduct [0,0,1]) vectorMultiply RADIUS_BANKED_TURN;
if (_vectR_bankedTurn_start vectorDotProduct (_pos_target vectorDiff _pos_bankedTurn_start) > 0) then
{
	// Rotate in clockwise sense as it is shorter
	_rotSign_bankedTurn = -1;
	_vectR_bankedTurn_start = _vectR_bankedTurn_start vectorMultiply _rotSign_bankedTurn;
};
private _pos_bankedTurn_center = _pos_bankedTurn_start vectorDiff _vectR_bankedTurn_start;
private _angle_bankedTurn_start = _dir_start - _rotSign_bankedTurn*90;
// Get end position
private _alpha = _rotSign_bankedTurn * acos (RADIUS_BANKED_TURN / (_pos_target distance2D _pos_bankedTurn_center));
private _angle_bankedTurn_end = ([[1,0,0], _pos_target vectorDiff _pos_bankedTurn_center] call Achilles_fnc_vectAngleXY) - _alpha;
if (_rotSign_bankedTurn > 0) then
{
	if (_angle_bankedTurn_start > _angle_bankedTurn_end) then {_angle_bankedTurn_start = _angle_bankedTurn_start - 360};
}
else
{
	if (_angle_bankedTurn_start < _angle_bankedTurn_end) then {_angle_bankedTurn_start = _angle_bankedTurn_start + 360}	;
};
private _pos_bankedTurn_end = _pos_bankedTurn_center vectorAdd ([cos(_angle_bankedTurn_end), sin(_angle_bankedTurn_end), 0] vectorMultiply RADIUS_BANKED_TURN);
// Timing
private _t_start_bankedTurn = _dt_pitchedTurn;
private _dt_bankedTurn = abs (2*pi*RADIUS_BANKED_TURN * (_angle_bankedTurn_end - _angle_bankedTurn_start)/360) / _speed_start;
private _fnc_traj_bankedTurn =
{
	params["_t"];
	private _lambda = (_t - _t_start_bankedTurn) / _dt_bankedTurn;
	private _angle = (_angle_bankedTurn_end - _angle_bankedTurn_start)*_lambda + _angle_bankedTurn_start;
	private _vectR = [cos _angle, sin _angle, 0] vectorMultiply RADIUS_BANKED_TURN;
	private _pos = _vectR vectorAdd _pos_bankedTurn_center;
	private _dir = _angle + _rotSign_bankedTurn*90;
	private _pitch = 0;
	// Bank angle based on linear interpolation
	private _bank_starter = 360/BANK_PERIOD * (_t - _t_start_bankedTurn);
	private _bank_restorer = 360/BANK_PERIOD * (_t_start_approachAO - _t);
	private _bank = switch (true) do
	{
		case (_bank_starter > ANGLE_BANKED_TURN and _bank_restorer > ANGLE_BANKED_TURN): {ANGLE_BANKED_TURN};
		case (_bank_starter > _bank_restorer): {_bank_restorer};
		default {_bank_starter};
	};
	_bank = -_rotSign_bankedTurn*_bank;
	([_dir, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	private _vel = _vectDir vectorMultiply SPEED_CAS;
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dir_start,_pitch,_bank]
};

// Approach AO trajectory
private _dir_bankedTurn_end = _angle_bankedTurn_end + _rotSign_bankedTurn*90;
private _vectDir_bankedTurn_end = [cos(_dir_bankedTurn_end),sin(_dir_bankedTurn_end),0];
private _distXY_approachAO = (_pos_bankedTurn_end distance2D _pos_target) - RADIUS_AO + _offset_weapon;
private _pos_AO_start = _pos_bankedTurn_end vectorAdd (_vectDir_bankedTurn_end vectorMultiply _distXY_approachAO);
private _t_start_approachAO = _t_start_bankedTurn + _dt_bankedTurn;
private _g_d2dt2_max_approachAO = _acc_max;
private _dt_approachAO = 3*(sqrt(SPEED_CAS^2 + 2/3*_distXY_approachAO*_g_d2dt2_max_approachAO) - SPEED_CAS)/_g_d2dt2_max_approachAO;
private _g_ddt_max_approachAO = 1/4*_g_d2dt2_max_approachAO*_dt_approachAO + SPEED_CAS;
if(_g_ddt_max_approachAO > _speed_max) then
{
	_g_ddt_max_approachAO = _speed_max;
	_g_d2dt2_max_approachAO = 4/3*(2*_g_ddt_max_approachAO^2-_g_ddt_max_approachAO*SPEED_CAS-SPEED_CAS^2)/_distXY_approachAO;
	_dt_approachAO = 3*(sqrt(SPEED_CAS^2 + 2/3*_distXY_approachAO*_g_d2dt2_max_approachAO) - SPEED_CAS)/_g_d2dt2_max_approachAO;
};
_fnc_traj_approachAO =
{
	params ["_t"];
	private _t = _t - _t_start_approachAO;
	private _g = -1/3*_g_d2dt2_max_approachAO/_dt_approachAO*_t^3 + 0.5*_g_d2dt2_max_approachAO*_t^2 + SPEED_CAS*_t;
	private _g_ddt = -_g_d2dt2_max_approachAO/_dt_approachAO*_t^2 + _g_d2dt2_max_approachAO*_t + SPEED_CAS;
	private _pos = _pos_bankedTurn_end vectorAdd (_vectDir_bankedTurn_end vectorMultiply _g);
	private _vel = _vectDir_bankedTurn_end vectorMultiply _g_ddt;
	[_pos,_vel,_vectDir_bankedTurn_end,[0,0,1],_dir_bankedTurn_end,0,0]
};

// Pre-CAS trajectory
private _speedXY_cas = SPEED_CAS*cos(PITCH_CAS);
private _speedZ_cas = SPEED_CAS*sin(PITCH_CAS);
private _dz_cas_start = DIST_CAS_START * sin(PITCH_CAS);
private _dz_preCAS = - DELTA_Z_TRAVEL - _dz_cas_start;
private _distXY_preCAS = RADIUS_AO - RADIUS_CAS_START + _offset_weapon;
// Duration and acceleration in xy-plane
private _t_start_preCAS = _t_start_approachAO + _dt_approachAO;
private _dt_preCAS = 2*_distXY_preCAS/(_speedXY_cas + SPEED_CAS);
private _g_d2dt2_preCAS = (_speedXY_cas - SPEED_CAS)/_dt_preCAS;
private _fnc_traj_preCAS =
{
	params ["_t"];
	private _t = _t - _t_start_preCAS;
	// _g is the traveled distance on the xy-plane
	private _g = 1/2*_g_d2dt2_preCAS*_t^2 + SPEED_CAS*_t;
	private _g_ddt = _g_d2dt2_preCAS*_t + SPEED_CAS;
	private _z = [_t, 0, _dz_preCAS, 0, _speedZ_cas, 0, _dt_preCAS] call Achilles_fnc_interpolation_cubicBezier1D;
	private _z_ddt = [_t, 0, _dz_preCAS, 0, _speedZ_cas, 0, _dt_preCAS] call Achilles_fnc_interpolation_cubicBezier1D_slope;
	private _pos = [_g*cos(_dir_bankedTurn_end),_g*sin(_dir_bankedTurn_end),_z] vectorAdd _pos_AO_start;
	private _vel = [_g_ddt*cos(_dir_bankedTurn_end),_g_ddt*sin(_dir_bankedTurn_end),_z_ddt];
	private _pitch = atan(_z_ddt/_g_ddt);
	private _bank = 0;
	([_dir_bankedTurn_end, _pitch, _bank] call Achilles_fnc_vectDirUpFromDirPitchBank) params ["_vectDir", "_vectUp"];
	// Return
	[_pos,_vel,_vectDir,_vectUp,_dir_bankedTurn_end,_pitch,_bank]
};

// CAS trajectory (just the params for setVelocityTransformation)
private _t_start_cas = _t_start_preCAS + _dt_preCAS;
([_t_start_cas] call _fnc_traj_preCAS) params ["_pos_cas_start", "_vel_cas", "_vectDir_cas", "_vectUp_cas"];
private _pos_cas_end = _pos_cas_start vectorAdd (_vectDir_cas vectorMultiply DIST_CAS_START);
private _dt_cas = DIST_CAS_START/SPEED_CAS;

// Start the simulation
private _t_start = time;
_aircraft disableAI "MOVE";
waitUntil
{
	private _t = time - _t_start;
	private _fnc_curTraj = {};
	switch (true) do
	{
		case (_t > _t_start_preCAS):
		{
			(_t call _fnc_traj_preCAS) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		case (_t > _t_start_approachAO):
		{
			(_t call _fnc_traj_approachAO) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		case (_t > _t_start_bankedTurn): 
		{
			(_t call _fnc_traj_bankedTurn) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
		default
		{
			(_t call _fnc_traj_pitchedTurn) params ["_pos","_vel","_vectDir","_vectUp"];
			_aircraft setVelocityTransformation [_pos, _pos, _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, 1];
			_aircraft setVelocity _vel;
		};
	};
	sleep 0.01;
	(_t > _t_start_preCAS + _dt_preCAS) || !alive _aircraft || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0
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
	private _i_fire = 1;
	waitUntil {
		_aircraft selectWeaponTurret [_muzzle, _turretPath];
		_aircraft setWeaponReloadingTime [_gunner, _muzzle, 0];
		[_target, _gunner, _muzzle, _magazine, _aircraft, _turretPath] call Achilles_fnc_forceWeaponFire;
		sleep _reloadTime;
		_i_fire = _i_fire + 1;
		_time + 3 < time || _i_fire > _maxRounds || !alive _aircraft || !alive driver _aircraft
	};
	_aircraft enableAI "TARGET";
	_aircraft enableAI "AUTOTARGET";
};
// Approach the target while firing
// Would have been _fnc_traj_CAS, but we use setVelocityTransformation directly
private _time = time;
waitUntil
{
	_aircraft setVelocityTransformation [_pos_cas_start,_pos_cas_end,_vel_cas,_vel_cas,_vectDir_cas,_vectDir_cas,_vectUp_cas,_vectUp_cas,(time - _time)/_dt_cas];
	_aircraft setVelocity _vel_cas;
	sleep 0.01;
	scriptDone _fireHandle || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0;
};
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
_aircraft enableAI "MOVE";
true;
