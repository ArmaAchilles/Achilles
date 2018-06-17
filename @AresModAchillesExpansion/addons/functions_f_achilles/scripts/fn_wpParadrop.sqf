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

_vehsGroup params ["_firstVeh"];
_vehsType = typeOf _firstVeh;
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
	_radius = 1000;
} else
{
	_vector = [0,0,0];
	_radius = 0;
};
private _wp_pos = _end_pos vectorAdd _vector;

// adjust distance for deployment according to crew count and velocity
private _speed = getNumber (configfile >> "CfgVehicles" >> _vehsType >> "maxSpeed");
private _coefName = ["normalSpeedForwardCoef", "limitedSpeedCoef"] select (speedMode _group == "LIMITED");
_speed = _speed * getNumber (configfile >> "CfgVehicles" >> _vehsType >> _coefName);
// every second a unit ejects. We want the middle unit right above the location
private _crew = crew _firstVeh;
private _passengerCount = {(assignedVehicleRole _x) select 0 == "CARGO"} count _crew;
_radius = _radius + _passengerCount/2 * _speed/3.6;
// account for speed displacement
if (getPos _firstVeh select 2 > 150) then
{
	// fitted function for HALO
	_radius = _radius + 4.2e-4 * _speed^3 * (1 - 1/(1 + (75/_speed)^2.2));
}
else
{
	// fitted function for HAHO
	_radius = _radius + 0.338 * _speed;
};

[_vehsGroup,_wp_pos,_radius] spawn
{
	params ["_vehsGroup", "_wp_pos", "_radius"];
	private _vehsRdy = false;
	waituntil
	{
		private _aliveCount = 0;
		{
			private _veh = _x;
			_aliveCount = _aliveCount + 1;
			if ((position _veh) distance2D _wp_pos < _radius) exitWith
			{
				[_vehsGroup] call Achilles_fnc_eject_passengers;
				_vehsRdy = true;
			};
		} forEach (_vehsGroup select {alive _x});
		if (_aliveCount == 0) then {_vehsRdy = true};
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
