params ["_curator", "_logic", "_weaponTypesID", "_planeClass", "_weapons", "_gunner_is_driver"];

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

//--- Restore custom direction
_logic setdir (missionnamespace getvariable ["Achilles_var_CAS_dir", direction _logic]);

//--- Get weapons
private _weaponTypes = switch _weaponTypesID do
{
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun","missilelauncher"]};
	case 3: {["bomblauncher"]};
	default {[]};
};

private _posATL = getposatl _logic;
private _pos = +_posATL;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];
private _dir = direction _logic;

private _dis = 3000;
private _alt = 1000;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
private _planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];
private _planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
private _planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
private _plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorup _plane;

//--- Remove all other weapons;
private _currentWeapons = weapons _plane;
{
	_plane removeweapon _x;
} foreach (_currentWeapons select {!(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"]))});

//--- Cam shake
private _ehFired = _plane addeventhandler [
	"fired",
	{
		_this spawn {
			_plane = _this select 0;
			_plane removeeventhandler ["fired",_plane getvariable ["ehFired",-1]];
			private _projectile = _this select 6;
			waituntil {isnull _projectile};
			[0.005,4,[_plane getvariable ["logic",objnull],200]] remoteExec ["bis_fnc_shakeCuratorCamera", 0];
		};
	}
];
_plane setvariable ["ehFired",_ehFired];
if (!_gunner_is_driver) then { _plane setvariable ["gunner", gunner _plane] };
_plane setvariable ["logic",_logic];

//--- Show hint
[["Curator","PlaceOrdnance"],nil,nil,nil,nil,nil,nil,true] remoteExec ["bis_fnc_advHint",_curator];

//--- Play radio
[effectiveCommander _plane,"CuratorModuleCAS"] remoteExec ["bis_fnc_curatorSayMessage", _curator];

//--- Approach
private _fire = [] spawn {waituntil {false}};
private _fireNull = true;
private _time = time;
private _offset = [0, 20] select ({_x == "missilelauncher"} count _weaponTypes > 0);
waituntil {
	private _fireProgress = _plane getvariable ["fireProgress",0];

	//--- Update plane position when module was moved / rotated
	if ((getposatl _logic distance _posATL > 0 || direction _logic != _dir) && _fireProgress == 0) then {
		_posATL = getposatl _logic;
		_pos = +_posATL;
		_pos set [2,(_pos select 2) + getterrainheightasl _pos];
		_dir = direction _logic;
		missionnamespace setvariable ["Achilles_var_CAS_dir", _dir, true];

		_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
		_planePos set [2,(_pos select 2) + _alt];
		_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
		_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
		_plane setvectordir _vectorDir;
		//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorup _plane;

		_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
	};

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setvelocity velocity _plane;

	//--- Fire!
	if ((getposasl _plane) distance _pos < 1000 && _fireNull) then {
		//--- Fire CM
		[_plane, [5, 1.1]] call Achilles_fnc_LaunchCM;
		//--- Create laser target
		private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
		_target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
		if (isnull _target) then {
			_target = createvehicle [_targetType,position _logic,[],0,"none"];
		};
		_plane reveal lasertarget _target;
		_plane dowatch lasertarget _target;
		_plane dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons,_target,_weaponTypesID] spawn
		{
			_plane = _this select 0;
			private _gunner = _plane getvariable ["gunner", driver _plane];
			_weapons = _this select 1;
			_target = _this select 2;
			_weaponTypesID = _this select 3;
			_duration = 3;
			_time = time + _duration;
			waituntil
			{
				{
					//_plane selectweapon (_x select 0);
					//_gunner forceweaponfire _x;
					_gunner fireattarget [_target,(_x select 0)];
				} foreach _weapons;
				_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || _weaponTypesID == 3 || isnull _plane //--- Shoot only for specific period or only one bomb
			};
			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire || isnull _logic || isnull _plane
};
_plane setvelocity velocity _plane;
_plane flyinheight _alt;

if !(isnull _logic) then
{
	sleep 1;
	private _master = _logic getvariable ["master", objnull];
	if (!isNull _master) then {deleteVehicle _master};
	deletevehicle _logic;
	waituntil {_plane distance _pos > _dis || !alive _plane};
};

//--- Delete plane
if (alive _plane) then
{
	private _group = group _plane;
	private _crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};
