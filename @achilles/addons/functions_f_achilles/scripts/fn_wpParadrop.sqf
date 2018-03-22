/*
	Kex

	Description:
	Paradrop passengers

	Parameters:
		0: GROUP
		1: ARRAY - waypoint position
		2: OBJECT - target to which waypoint is attached to

	Returns:
	BOOL
*/
params [["_group", grpNull, [grpNull]], ["_end_pos", [], [[]], 3], ["_target", objNull, [objNull]]];

//////////////////////////////////////
// executed on second script call
if (!isNil {_group getVariable ["Achilles_var_paradrop",nil]}) exitWith
{
	_group setVariable ["Achilles_var_paradrop",nil];
	true
};
//
//////////////////////////////////////

// initialize required functions
if (isNil "Achilles_var_eject_init_done") then
{
	publicVariable "Achilles_fnc_chute";
	publicVariableServer "Achilles_fnc_eject_passengers";
	Achilles_var_eject_init_done = true;
};
private _wp_index = currentwaypoint _group;
private _wp = [_group,_wp_index];
_wp setwaypointdescription localize "STR_AMAE_PARADROP";
_wp setWaypointName localize "STR_AMAE_PARADROP";

private _vehsGroup = [];
private _vehsType = "";

{
    private _veh = vehicle _x;
    if (!(_veh in _vehsGroup)) then
    {
        _vehsGroup pushBack _veh;

    	// Kex: prevent pilot from being stupid
    	private _pilot = driver _veh;
    	_pilot setSkill 1;
    };
} foreach (units _group);

// Kex: prevent pilot from being stupid
_group allowFleeing 0;

_vehsType = typeOf (_vehsGroup select 0);
private _radius = 0;
private _vector = [];
// displace effective target position for flyby
private _start_pos = position leader _group;
if (_vehsType isKindOf "Helicopter") then
{
	_vector = _end_pos vectorDiff _start_pos;
	_vector set [2,0];
	_vector = vectorNormalized _vector;
	_vector = _vector vectorMultiply 1000;
	_radius = 1200;
} else
{
	_vector = [0,0,0];
	_radius = 100;
};
private _wp_pos = _end_pos vectorAdd _vector;

[_vehsGroup,_wp_pos,_radius] spawn
{
	waituntil
	{
		params ["_vehsGroup","_wp_pos","_radius"];
		private "_veh";
		private _vehsRdy = false;
		{
			_veh = _x;
			if ((position _veh) distance2D _wp_pos < _radius and !_vehsRdy) then
			{
				[_vehsGroup] call Achilles_fnc_eject_passengers;
				_vehsRdy = true;
			};
		} forEach (_vehsGroup select {alive _x});

		sleep 1;
		_vehsRdy;
	};
};

_group setVariable ["Achilles_var_paradrop",true];

[_group,_wp_index,_wp_pos] spawn
{
	params ["_group","_wp_index","_wp_pos"];
	_group addWaypoint [_wp_pos, 100, _wp_index];
};
