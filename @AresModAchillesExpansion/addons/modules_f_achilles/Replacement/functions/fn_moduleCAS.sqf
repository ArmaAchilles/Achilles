_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

//--- Terminate on client (unless it's curator who created the module)
if (!isserver && {local _x} count (objectcurators _logic) == 0) exitwith {};

if (_activated) then {
	
	//--- Wait for params to be set
	if (_logic call bis_fnc_isCuratorEditable) then {
		waituntil {!isnil {_logic getvariable "vehicle"} || isnull _logic};
	};
	if (isnull _logic) exitwith {};

	//--- Show decal
	if ({local _x} count (objectcurators _logic) > 0) then {
		//--- Reveal the circle to curators
		_logic hideobject false;
		_logic setpos position _logic;
	};
	if !(isserver) exitwith {};

	_planeClass = _logic getvariable ["vehicle","B_Plane_CAS_01_F"];
	_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
	if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

	//--- Restore custom direction
	_dirVar = _fnc_scriptname + typeof _logic;
	_logic setdir (missionnamespace getvariable [_dirVar,direction _logic]);

	//--- Get weapons
	_weaponTypesID = _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")];
	_weaponTypes = switch _weaponTypesID do
	{
		case 0: {["machinegun"]};
		case 1: {["missilelauncher"]};
		case 2: {["machinegun","missilelauncher"]};
		case 3: {["bomblauncher"]};
		default {[]};
	};
	_gunner_is_driver = _logic getvariable ["gunnerIsDriver",0];
	_weapons = _logic getvariable ["weapons",[]];
	
	_posATL = getposatl _logic;
	_pos = +_posATL;
	_pos set [2,(_pos select 2) + getterrainheightasl _pos];
	_dir = direction _logic;

	_dis = 3000;
	_alt = 1000;
	_pitch = atan (_alt / _dis);
	_speed = 400 / 3.6;
	_duration = ([0,0] distance [_dis,_alt]) / _speed;

	//--- Create plane
	_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
	_planePos set [2,(_pos select 2) + _alt];
	_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
	_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
	_plane = _planeArray select 0;
	_plane setposasl _planePos;
	_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
	_plane disableai "move";
	_plane disableai "target";
	_plane disableai "autotarget";
	_plane setcombatmode "blue";

	_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
	_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
	_plane setvectordir _vectorDir;
	[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
	_vectorUp = vectorup _plane;

	//--- Remove all other weapons;
	_currentWeapons = weapons _plane;
	{
		if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
			_plane removeweapon _x;
		};
	} foreach _currentWeapons;

	//--- Cam shake
	_ehFired = _plane addeventhandler [
		"fired",
		{
			_this spawn {
				_plane = _this select 0;
				_plane removeeventhandler ["fired",_plane getvariable ["ehFired",-1]];
				_projectile = _this select 6;
				waituntil {isnull _projectile};
				[[0.005,4,[_plane getvariable ["logic",objnull],200]],"bis_fnc_shakeCuratorCamera"] call bis_fnc_mp;
			};
		}
	];
	_plane setvariable ["ehFired",_ehFired];
	if (_gunner_is_driver == 0) then
	{
		_plane setvariable ["gunner", gunner _plane];
	};
	_plane setvariable ["logic",_logic];

	//--- Show hint
	[[["Curator","PlaceOrdnance"],nil,nil,nil,nil,nil,nil,true],"bis_fnc_advHint",objectcurators _logic] call bis_fnc_mp;

	//--- Play radio
	[_plane,"CuratorModuleCAS"] call bis_fnc_curatorSayMessage;

	//--- Debug - visualize tracers
	if (false) then {
		BIS_draw3d = [];
		//{deletemarker _x} foreach allmapmarkers;
		_m = createmarker [str _logic,_pos];
		_m setmarkertype "mil_dot";
		_m setmarkersize [1,1];
		_m setmarkercolor "colorgreen";
		_plane addeventhandler [
			"fired",
			{
				_projectile = _this select 6;
				[_projectile,position _projectile] spawn {
					_projectile = _this select 0;
					_posStart = _this select 1;
					_posEnd = _posStart;
					_m = str _projectile;
					_mColor = "colorred";
					_color = [1,0,0,1];
					if (speed _projectile < 1000) then {
						_mColor = "colorblue";
						_color = [0,0,1,1];
					};
					while {!isnull _projectile} do {
						_posEnd = position _projectile;
						sleep 0.01;
					};
					createmarker [_m,_posEnd];
					_m setmarkertype "mil_dot";
					_m setmarkersize [1,1];
					_m setmarkercolor _mColor;
					BIS_draw3d set [count BIS_draw3d,[_posStart,_posEnd,_color]];
				};
			}
		];
		if (isnil "BIS_draw3Dhandler") then {
			BIS_draw3Dhandler = addmissioneventhandler ["draw3d",{{drawline3d _x;} foreach (missionnamespace getvariable ["BIS_draw3d",[]]);}];
		};
	};

	//--- Approach
	_fire = [] spawn {waituntil {false}};
	_fireNull = true;
	_time = time;
	_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
	waituntil {
		_fireProgress = _plane getvariable ["fireProgress",0];

		//--- Update plane position when module was moved / rotated
		if ((getposatl _logic distance _posATL > 0 || direction _logic != _dir) && _fireProgress == 0) then {
			_posATL = getposatl _logic;
			_pos = +_posATL;
			_pos set [2,(_pos select 2) + getterrainheightasl _pos];
			_dir = direction _logic;
			missionnamespace setvariable [_dirVar,_dir];

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


			//--- Create laser target
			_target = ((position _logic nearEntities ["LaserTarget",250])) param [0,objnull];
			if (isnull _target) then {
				_target = createvehicle ["LaserTargetC",position _logic,[],0,"none"];
			};
			_plane reveal lasertarget _target;
			_plane dowatch lasertarget _target;
			_plane dotarget lasertarget _target;

			_fireNull = false;
			terminate _fire;
			_fire = [_plane,_weapons,_target,_weaponTypesID] spawn
			{
				_plane = _this select 0;
				_gunner = _plane getvariable ["gunner", driver _plane];
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
		deletevehicle _logic;
		waituntil {_plane distance _pos > _dis || !alive _plane};
	};

	//--- Delete plane
	if (alive _plane) then
	{
		_group = group _plane;
		_crew = crew _plane;
		deletevehicle _plane;
		{deletevehicle _x} foreach _crew;
		deletegroup _group;
	};
};