/*
	Function:
		Achilles_fnc_advancedBlackfishCAS
	
	Authors:
		Kex
	
	Description:
		Forces a Blackfish to perform a CAS run.
		This function has to be executed in the scheduled environment on the machine the unit is local.
		It seems that the function doesn't work on machines without an interface (e.g. sever or HC)
	
	Parameters:
		_aircraft						- <OBJECT> The helicopter that performs the CAS run
		_target							- <OBJECT> The target object (has to be a logic)
		_weaponMuzzleMagazineIdx		- <ARRAY> of <INTEGER>
											_weapIdx	- <INTEGER> Weapon index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
											_muzzleIdx	- <INTEGER> Muzzle index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
											_magIdx		- <INTEGER> Magazine index (derived from Achilles_fnc_getWeaponsMuzzlesMagazines)
		_offset_custom					- <ARRAY> [0] Target offset in meters that will be added to the weapon's offset
											Can be used for fine-tuning the targeting
											E.g. -25 means the helicopter will target 25 m in front of the target.
	
	Returns:
		_success						- <BOOLEAN> True if the CAS run was completed without occurring exception
	
	Exampes:
		(begin example)
		// Perform CAS with _blackfish on _target with the first weapon returned by Achilles_fnc_getWeaponsMuzzlesMagazines.
		[_blackfish, _target, [0,0,0]] call Achilles_fnc_advancedBlackfishCAS;
		(end)
*/
params
[
	"_aircraft",
	"_target",
	"_weaponMuzzleMagazineIdx",
	["_offset_custom", 0, [0]]
];
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
private _targetPos = getPos _target;
private _aircraftGroup = group effectiveCommander _aircraft;
private _wpHeli01 = [_aircraftGroup, currentWaypoint _aircraftGroup];
if (waypointType _wpHeli01 != "LOITER") then
{
	private _allWps = waypoints _aircraftGroup;
	reverse _allWps;
	{deleteWaypoint _x} forEach _allWps;
	_wpHeli01 = _aircraftGroup addWaypoint [_targetPos, 0];
	_wpHeli01 setWaypointType "Loiter";
}
else
{
	_wpHeli01 setWaypointPosition [_targetPos, 0];
};
_wpHeli01 setWaypointLoiterType "CIRCLE_L";
_wpHeli01 setWaypointLoiterRadius 400;

_aircraft flyInHeight 500;
_aircraftGroup allowFleeing 0;
private _prevBehaviour = behaviour _aircraft;
_aircraft setBehaviour "CARELESS";
_aircraft disableAI "TARGET";
_aircraft disableAI "AUTOTARGET";

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
_reloadTime = _reloadTime min 1;
// Get offset
private _offset_weapon = switch (_muzzle) do
{
	case "cannon_105mm_VTOL_01": {[0 + _offset_custom, -65, 0]};
	case "AP": {[5 + _offset_custom, -55, 0]};
	default {[15 + _offset_custom, -85, 0]}
};

private _data = [0,0,0,0,1e6];
private _i = 0;
waitUntil
{
	private _dir = _aircraft getDir _target;
	private _pos = ASLToAGL ((getPosASL _target) vectorAdd ([[[sin(_dir),cos(_dir),0],[cos(_dir),-sin(_dir),0],[0,0,1]], _offset_weapon] call CBA_fnc_vectMap3D));
	_gunner doWatch _pos;
	_gunner lookAt _pos;
	private _distXY_cur = _aircraft distance2D _targetPos;
	_data set [_i, _distXY_cur];
	_i = (_i+1)%5;
	sleep 1;
	(_distXY_cur < 1000 && ([_data] call Achilles_fnc_arrayStdDev < 5)) || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0
};
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
// Start firing
private _time = time;
private _endTime = _time + 3;
private _i_fire = 1;
waitUntil {
	private _dir = _aircraft getDir _target;
	private _pos = ASLToAGL ((getPosASL _target) vectorAdd ([[[sin(_dir),cos(_dir),0],[cos(_dir),-sin(_dir),0],[0,0,1]], _offset_weapon] call CBA_fnc_vectMap3D));
	_gunner doWatch _pos;
	_gunner lookAt _pos;
	_gunner lookAt _pos;
	_aircraft selectWeaponTurret [_muzzle, _turretPath];
	_aircraft setWeaponReloadingTime [_gunner, _muzzle, 0];
	[_target, _gunner, _muzzle, _magazine, _aircraft, _turretPath] call Achilles_fnc_forceWeaponFire;
	_i_fire = _i_fire + 1;
	sleep _reloadTime;
	_endTime  < time || !canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0
};
if (!canMove _aircraft || !alive driver _aircraft || fuel _aircraft == 0) exitWith {false};
_aircraft setBehaviour _prevBehaviour;
_aircraft enableAI "TARGET";
_aircraft enableAI "AUTOTARGET";
true
