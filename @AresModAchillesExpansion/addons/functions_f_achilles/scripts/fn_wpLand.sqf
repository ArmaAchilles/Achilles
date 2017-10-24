/*
	Author: Karel Moricky, modified by Kex

	Description:
	Let group members land at the waypoint position

	Parameters:
		0: GROUP
		1: ARRAY - waypoint position
		2: OBJECT - target to which waypoint is attached to

	Returns:
	BOOL
*/

private ["_group","_pos","_target","_wp"];
_group = _this param [0,grpnull,[grpnull]];
_pos = _this param [1,[],[[]],3];
_target = _this param [2,objnull,[objnull]];
_wp = [_group,currentwaypoint _group];
_wp setwaypointdescription localize "STR_A3_CfgWaypoints_Land";

private ["_vehsMove","_vehsLand"];
_vehsMove = [];
_vehsLand = [];

// Kex: create LZ
private _lz = "Land_HelipadEmpty_F" createVehicleLocal _pos;
_group setVariable ["Achilles_WP_LZobject", _lz];

// Kex: prevent pilot from being stupid
_group allowFleeing 0;

waituntil 
{
	private ["_countReady","_vehsGroup"];
	_countReady = 0;
	_vehsGroup = [];

	//--- Check state of group members
	{
		private ["_veh"];
		_veh = vehicle _x;
		if (_x == effectivecommander _x) then {
			if (!(_veh in _vehsMove)) then {

				//--- Move to landing position
				_veh domove _pos;
				
				// Kex: prevent pilot from being stupid
				private _pilot = driver _veh;
				_pilot setSkill 1;
				
				_vehsMove set [count _vehsMove,_veh];
			} else {
				if !(istouchingground _veh) then {
					if (unitready _veh && !(_veh in _vehsLand)) then {

						//--- van 't Land
						_veh land "land";
						_vehsLand set [count _vehsLand,_veh];
					};
				} else {
					//--- Ready (keep the engine running)
					_veh engineon true;
					_countReady = _countReady + 1;
				};
			};
			_vehsGroup set [count _vehsGroup,_veh];
		};
	} foreach units _group;
	
	// adjust LZ position
	_lz setPos (waypointPosition _wp);

	//--- Remove vehicles which are no longer in the group
	_vehsMove = _vehsMove - (_vehsMove - _vehsGroup);
	_vehsLand = _vehsLand - (_vehsLand - _vehsGroup);

	sleep 1;
	count _vehsGroup == _countReady
};

// Kex: delete LZ
deleteVehicle _lz;
_group setVariable ["Achilles_WP_LZ_object", nil];

true
