#include "\ares_zeusExtensions\Ares\module_header.hpp"

/*
_unitUnderCursor = [_logic] call Ares_fnc_GetUnitUnderCursor;

_vehicle = vehicle _unitUnderCursor;
if (_vehicle isKindOf "Helicopter") then
{
	_groupUnderCursor = (group _unitUnderCursor);
	
	// Determine if there are any passengers to drop off in the vehicle.
	_hasAnyUnitsInCargo = false;
	{
		if (_vehicle getCargoIndex _x != -1) exitWith { _hasAnyUnitsInCargo = true; }
	} forEach crew _vehicle;

	_landingPos = (position _vehicle) findEmptyPosition [0, 500, (typeOf _vehicle)];
	if (count _landingPos > 0) then
	{
		// Remove other waypoints.
		while {(count (waypoints _groupUnderCursor)) > 0} do
		{
			deleteWaypoint ((waypoints _groupUnderCursor) select 0);
		};

		if (_hasAnyUnitsInCargo) then
		{
			_waypoint = _groupUnderCursor addWaypoint [_landingPos, 0];
			_waypoint setWaypointType "TR UNLOAD";
		}
		else
		{
			doStop _vehicle;
			_vehicle land "LAND";
		};
		_unitUnderCursor allowFleeing 0;
		
		[objnull, "Landing helicopter."] call bis_fnc_showCuratorFeedbackMessage;
	}
	else
	{
		[objnull, "Unable to find landing zone."] call bis_fnc_showCuratorFeedbackMessage;
	};
}
else
{
	[objnull, "Module must be placed on a helicopter."] call bis_fnc_showCuratorFeedbackMessage;
};
*/

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
