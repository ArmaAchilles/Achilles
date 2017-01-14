////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/15/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_eject_passengers.sqf
//  DESCRIPTION: THIS FUNCTION HAS TO BE EXECUTED SERVER SIDE!!!
//				 force passengers in vehicle to eject;
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


params ["_vehicles"];

{
	_vehicle = _x;
	if (_vehicle isKindOf "LandVehicle" or _vehicle isKindOf "Air") then
	{
		_crew = crew _vehicle;
		_passenger = _crew select {(assignedVehicleRole _x) select 0 == "CARGO"};
		{
			if ((getPos _vehicle select 2) > 40) then
			{
				[_x, _forEachIndex] remoteExec ["Achilles_fnc_chute",_x];
			} else
			{
				if (isPlayer _x) then
				{
					[_x,{
						unassignVehicle _this;
						_this action ["Eject", vehicle _this];
					}] remoteExec ["BIS_fnc_spawn",_x];
				} else
				{
					[_x,{
						unassignVehicle _this;
						[_this] orderGetIn false;
					}] remoteExec ["BIS_fnc_spawn",_x];
				};
			};
		} forEach _passenger;
		if ((getPos _vehicle select 2) > 40) then {[_vehicle] remoteExec ["rhs_fnc_vehPara",_vehicle]};
	}
} forEach _vehicles;