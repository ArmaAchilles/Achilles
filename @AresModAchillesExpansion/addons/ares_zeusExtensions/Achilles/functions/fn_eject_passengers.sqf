////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/15/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_eject_passengers.sqf
//  DESCRIPTION: force passengers in vehicle to eject;
//				 in case of flying choppers passengers will be paradroped
//
//	ARGUMENTS:
//	_this:			ARRAY	- array of vehicles
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	_vehicle_array call Achilles_fnc_eject_passengers;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_vehicles = _this;

{
	_vehicle = _x;
	if (_vehicle isKindOf "LandVehicle" or _vehicle isKindOf "Air") then
	{
		_crew = crew _vehicle;
		_passenger = [{(assignedVehicleRole _this) select 0 == "CARGO"}, _crew] call Achilles_fnc_filter;
		{
			if ((getPos _vehicle select 2) > 40) then
			{
				[_x, _forEachIndex] spawn Achilles_fnc_chute;
			} else
			{
				if (isPlayer _x) then
				{
					unassignVehicle _x;
					_x action ["Eject", _vehicle];
				} else
				{
					unassignVehicle _x;
					[_x] orderGetIn false;
				};
			};
		} forEach _passenger;
		if ((getPos _vehicle select 2) > 40) then {[_vehicle] spawn rhs_fnc_vehPara};
	}
} forEach _vehicles;