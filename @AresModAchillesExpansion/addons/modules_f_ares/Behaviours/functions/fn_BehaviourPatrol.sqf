private ["_logic", "_units", "_activated"];
#include "\achilles\modules_f_ares\module_header.hpp"

private ["_groupUnderCursor"];
["BehaviourPatrol: Getting group under cursor"] call Achilles_fnc_logMessage;
_groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;
["BehaviourPatrol: Got group under cursor"] call Achilles_fnc_logMessage;

if (isNull _logic) then
{
	["Null logic passed to patrol behaviour!"] call Achilles_fnc_logMessage;
};
if ((position _logic) select 0 == 0 && (position _logic) select 1 == 0 && (position _logic) select 2 == 0) then
{
	["Logic is at [0,0,0]!"] call Achilles_fnc_logMessage;
};
if (isNull _groupUnderCursor) then
{
	["No unit under cursor!!"] call Achilles_fnc_logMessage;
};

if (not isNull _groupUnderCursor) then
{
	
	_doesGroupContainAnyPlayer = false;
	{
		if (isPlayer _x) exitWith { _doesGroupContainAnyPlayer = true; };
	} forEach (units _groupUnderCursor);
	
	if (not _doesGroupContainAnyPlayer) then
	{
		private ["_dialogResult"];
		["BehaviourPatrol: Group under cursor was not null - showing prompt"] call Achilles_fnc_logMessage;
		_dialogResult =
			[localize "STR_PATROL_LOITER",
					[
						[(localize "STR_RADIUS") + " [m]", "", "100"],
						[localize "STR_GROUP_BEHAVIOUR", [localize "STR_RELAXED", localize "STR_CAUTIOUS", localize "STR_COMBAT"]],
						[localize "STR_DIRECTION", [localize "STR_CLOCKWISE", localize "STR_COUNTERCLOCKWISE"],1],
						[localize "STR_DELAY_AT_WP", ["None", "15s", "30s", "1m"]]
					]
			] call Ares_fnc_ShowChooseDialog;
			
		["BehaviourPatrol: Prompt complete!"] call Achilles_fnc_logMessage;
		if (count _dialogResult > 0) then
		{
			_radius = parseNumber (_dialogResult select 0);
			
			switch (_dialogResult select 1) do
			{
				// Case0 and default
				default
				{
					// Relaxed
					_groupUnderCursor setBehaviour "SAFE";
					_groupUnderCursor setSpeedMode "LIMITED";
				};
				case 1:
				{
					// Cautious
					_groupUnderCursor setBehaviour "AWARE";
					_groupUnderCursor setSpeedMode "LIMITED";
				};
				case 2:
				{
					// Searching
					_groupUnderCursor setBehaviour "COMBAT";
					_groupUnderCursor setSpeedMode "NORMAL";
				};
			};
			private ["_moveClockwise", "_delay", "_numberOfWaypoints", "_degreesPerWaypoint", "_centerPoint", "_waypoint"];
			_moveClockwise = (_dialogResult select 2) == 0;

			_delay = [0, 0, 0];
			switch (_dialogResult select 3) do
			{
				default {}; // Already set default (0) values
				case 1:
				{
					// 15s
					_delay = [12, 15, 17];
				};
				case 2:
				{
					// 30s
					_delay = [20, 30, 40];
				};
				case 3:
				{
					// 1m
					_delay = [45, 60, 75];
				};
			};
			
			// Remove other waypoints.
			while {(count (waypoints _groupUnderCursor)) > 0} do
			{
				deleteWaypoint ((waypoints _groupUnderCursor) select 0);
			};
			_leader_vehicle = vehicle (leader _groupUnderCursor);
			if (_leader_vehicle isKindOf "Air") then
			{
				// aircrafts: Loiter in the area
				_centerPoint = position _leader_vehicle;
				_centerPoint set [2,0];
				_wp_id = 0;
				if (not isEngineOn _leader_vehicle) then
				{
					_waypoint = _groupUnderCursor addWaypoint [_centerPoint vectorAdd ((vectorDir _leader_vehicle) vectorMultiply 300), _wp_id];
					_wp_id = 1;
				};
				_waypoint = _groupUnderCursor addWaypoint [_centerPoint, _wp_id];
				_waypoint setWaypointType "LOITER";
				_waypoint setWaypointLoiterRadius _radius;
				if (not _moveClockwise) then
				{
					_waypoint setWaypointLoiterType "CIRCLE_L";
				};
			} else
			{
				// ground forces: Patrol the area
				// Make a circle with the unit's current location at the center.
				_numberOfWaypoints = 6;
				_degreesPerWaypoint =  360 / _numberOfWaypoints;
				if (!_moveClockwise) then
				{
					_degreesPerWaypoint = _degreesPerWaypoint * -1;
				};
				_centerPoint = position _logic;
				for "_waypointNumber" from 0 to (_numberOfWaypoints - 1) do
				{
					private ["_currentDegrees"];
					_currentDegrees = _degreesPerWaypoint * _waypointNumber;
					_waypoint = _groupUnderCursor addWaypoint [[_centerPoint, _radius, _currentDegrees] call BIS_fnc_relPos, 5];
					_waypoint setWaypointTimeout _delay;
				};
				
				// Add a waypoint at the location of the first WP. We started at 0 degrees.
				// We don't delay the cycle WP since then we'd have double-time before moving.
				_waypoint = _groupUnderCursor addWaypoint [[_centerPoint, _radius, 0] call BIS_fnc_relPos, 5];
				_waypoint setWaypointType "CYCLE";
				
				[objnull, "Circular patrol path setup for units."] call bis_fnc_showCuratorFeedbackMessage;
			};
		}
		else
		{
			// Cancelled
		};
	}
	else
	{
		[objnull, "Cannot add patrol for player units."] call bis_fnc_showCuratorFeedbackMessage;
	};
}
else
{
	[objnull, "No group under cursor."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
