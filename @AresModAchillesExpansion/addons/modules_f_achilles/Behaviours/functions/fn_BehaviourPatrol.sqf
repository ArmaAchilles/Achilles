/*
	Author: CreepPork_LV

	Description:
		Makes a group of units patrol around the surrounding area or if an aircraft then make it loiter.

	Parameters:
		None

	Returns:
		Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

// Get a single unit that was selected
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// If no unit was selected then initiate Select Units feature
private _selectedUnits = if (isNull _unitUnderCursor) then
{
	[localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
}
else
{
	[_unitUnderCursor];
};

// If Select was canceled
if (isNil "_selectedUnits") exitWith {};

// If nothing was selected then exit
if (_selectedUnits isEqualTo []) exitWith { [localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_showZeusErrorMessage; };

// If any players are selected then exit
{
	if (_x in _selectedUnits) exitWith { [localize "STR_AMAE_SELECT_NON_PLAYER_UNITS"] call Achilles_fnc_ShowZeusErrorMessage; };
} forEach allPlayers;

// As we have individual units, we want to get unique groups from those units
private _selectedGroups = [];

{
	_selectedGroups pushBackUnique (group _x);
} forEach _selectedUnits;

private _dialogResult =
[
	localize "STR_AMAE_PATROL_LOITER", 
	[
		["TEXT", localize "STR_AMAE_RADIUS", [], "100"],
		["COMBOBOX", localize "STR_AMAE_GROUP_BEHAVIOUR", [localize "STR_AMAE_RELAXED", localize "STR_AMAE_CAUTIOUS", localize "STR_AMAE_COMBAT"]],
		["COMBOBOX", localize "STR_AMAE_DIRECTION", [localize "STR_AMAE_CLOCKWISE", localize "STR_AMAE_COUNTERCLOCKWISE"], 1],
		["TEXT", localize "STR_AMAE_DELAY_AT_WP", [], "0"]
	]
] call Achilles_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
	"_radius",
	"_behaviour",
	"_direction",
	"_delay"
];

_radius = parseNumber _radius;
_delay = parseNumber _delay;

private _moveClockwise = _direction == 0;

{
	// Set the group behaviour
	switch (_behaviour) do
	{
		case 0:
		{
			// Relaxed
			_x setBehaviour "SAFE";
			_x setSpeedMode "LIMITED";
		};

		case 1:
		{
			// Cautious
			_x setBehaviour "AWARE";
			_x setSpeedMode "LIMITED";
		};

		case 2:
		{
			// Combat
			_x setBehaviour "COMBAT";
			_x setSpeedMode "NORMAL";
		};
	};

	// Delete all existing waypoints
	while { (count (waypoints _x)) > 0} do
	{
		deleteWaypoint ((waypoints _x) select 0);
	};

	private _leaderVehicle = vehicle (leader _x);

	private _center = getPos _leaderVehicle;

	// Set the Z axis to 0 to make the waypoint spawn on the ground
	_center set [2, 0];

	// If is an aircraft then loiter around the module
	if (_leaderVehicle isKindOf "Air") then
	{
		private _waypointNumber = 0;

		// Make the unit move and to turn it's engine on
		if (! isEngineOn _leaderVehicle) then
		{
			_x addWaypoint [_center vectorAdd ((vectorDir _leaderVehicle) vectorMultiply 300), 0];
			_waypointNumber = 1;
		};

		// Create the loiter waypoint
		private _loiterWaypoint = _x addWaypoint [_center, _waypointNumber];
		_loiterWaypoint setWaypointType "LOITER";
		_loiterWaypoint setWaypointLoiterRadius _radius;

		// Set the loiter direction
		if (! _moveClockwise) then
		{
			_loiterWaypoint setWaypointType "CIRCLE_L";
		};
	}
	// Ground units
	else
	{
		private _degreesPerWaypoint = 360 / 6 // (6 = waypoint count)

		if (! _moveClockwise) then
		{
			_degreesPerWaypoint = _degreesPerWaypoint * -1;
		};

		// 6 waypoints
		for "_i" from 0 to 5 do
		{
			private _currentDegrees = _degreesPerWaypoint * _i;

			private _waypoint = _x addWaypoint [_center getPos [_radius, _currentDegrees], 5];

			_waypoint setWaypointTimeout [_delay - 3, _delay, _delay + 3];
		};

		// Add the cycle waypoint; Don't delay this waypoint.
		private _cycleWaypoint = _x addWaypoint [_center getPos [_radius, 0], 5];

		_cycleWaypoint setWaypointType "CYCLE";
	};
} forEach _selectedGroups;

[localize "STR_AMAE_CIRCULAR_PATROL_SETUP"] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"