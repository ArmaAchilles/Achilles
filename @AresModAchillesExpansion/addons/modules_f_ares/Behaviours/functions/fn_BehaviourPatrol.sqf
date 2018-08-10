private ["_logic", "_units", "_activated"];
#include "\achilles\modules_f_ares\module_header.h"

private ["_groupUnderCursor"];
["BehaviourPatrol: Getting group under cursor"] call Achilles_fnc_log;
_groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;
["BehaviourPatrol: Got group under cursor"] call Achilles_fnc_log;

if (isNull _logic) then
{
	["Null logic passed to patrol behaviour!"] call Achilles_fnc_log;
};
if (position _logic isEqualTo [0, 0, 0]) then
{
	["Logic is at [0,0,0]!"] call Achilles_fnc_log;
};
if (isNull _groupUnderCursor) then
{
	["No unit under cursor!!"] call Achilles_fnc_log;
};

if (!isNull _groupUnderCursor) then
{

	private _doesGroupContainAnyPlayer = !(((units _groupUnderCursor) select {isPlayer _x}) isEqualTo []);

	if (!_doesGroupContainAnyPlayer) then
	{
		private ["_dialogResult"];
		["BehaviourPatrol: Group under cursor was not null - showing prompt"] call Achilles_fnc_log;
		_dialogResult =
			[localize "STR_AMAE_PATROL_LOITER",
					[
						[localize "STR_AMAE_RADIUS", "", "100"],
						[localize "STR_AMAE_GROUP_BEHAVIOUR", [localize "STR_AMAE_RELAXED", localize "STR_AMAE_CAUTIOUS", localize "STR_AMAE_COMBAT"]],
						[localize "STR_AMAE_DIRECTION", [localize "STR_AMAE_CLOCKWISE", localize "STR_AMAE_COUNTERCLOCKWISE"],1],
						[localize "STR_AMAE_DELAY_AT_WP", [localize "STR_AMAE_NONE", ["15",localize "STR_AMAE_SECONDS"] joinString " ", ["30",localize "STR_AMAE_SECONDS"] joinString " ", ["1",localize "STR_AMAE_MINUTE"] joinString " "]]
					]
			] call Ares_fnc_ShowChooseDialog;

		["BehaviourPatrol: Prompt complete!"] call Achilles_fnc_log;
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

			_delay = switch (_dialogResult select 3) do
			{
				case 1:
				{
					// 15s
					[12, 15, 17]
				};
				case 2:
				{
					// 30s
					[20, 30, 40]
				};
				case 3:
				{
					// 1m
					[45, 60, 75]
				};
                default {
                    [0, 0, 0]
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
				if (!isEngineOn _leader_vehicle) then
				{
					_waypoint = _groupUnderCursor addWaypoint [_centerPoint vectorAdd ((vectorDir _leader_vehicle) vectorMultiply 300), _wp_id];
					_wp_id = 1;
				};
				_waypoint = _groupUnderCursor addWaypoint [_centerPoint, _wp_id];
				_waypoint setWaypointType "LOITER";
				_waypoint setWaypointLoiterRadius _radius;
				if (!_moveClockwise) then
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

				[objnull, localize "STR_AMAE_CIRCULAR_PATROL_SETUP"] call bis_fnc_showCuratorFeedbackMessage;
			};
		};
	}
	else
	{
		[objnull, localize "STR_AMAE_CANNOT_ADD_PATROL_PLAYERS"] call bis_fnc_showCuratorFeedbackMessage;
	};
}
else
{
	[objnull, localize "STR_AMAE_NO_GROUP_UNDER_CURSOR"] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.h"
