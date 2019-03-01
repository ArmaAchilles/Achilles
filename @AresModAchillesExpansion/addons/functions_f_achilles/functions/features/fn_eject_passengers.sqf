////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR:			Kex
// DATE:			7/16/17
// VERSION: 		AMAE002
// DESCRIPTION: 	THIS FUNCTION HAS TO BE EXECUTED SERVER SIDE!!!
//				 	force passengers in vehicle to eject;
//				 	in case of flying choppers passengers will be paradroped
//
//	ARGUMENTS:		_this: ARRAY - array of vehicles
//
//	RETURNS:		nothing
//
//	Example:		_vehicle_array call Achilles_fnc_eject_passengers;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


params ["_vehicles"];

{
	private _vehicle = _x;
	private _crew = crew _vehicle;
	private _passenger = _crew select {(assignedVehicleRole _x) select 0 == "CARGO"};
	{
		private _unit = _x;
		if ((getPos _vehicle select 2) > 40) then
		{
			if (local _unit) then
			{
				[_unit, _forEachIndex] spawn Achilles_fnc_chute;
			}
			else
			{
				[_unit, _forEachIndex] remoteExec ["Achilles_fnc_chute", _unit];
			};
		}
		else
		{
			if (isPlayer _unit) then
			{
				if (local _unit) then
				{
					unassignVehicle _unit;
					_unit action ["Eject", vehicle _unit];
				}
				else
				{
					_unit remoteExecCall ["unassignVehicle", _unit];
					[_unit, ["Eject", vehicle _unit]] remoteExecCall ["action", _unit];
				};
			}
			else
			{
				if (local _unit) then
				{
					unassignVehicle _unit;
					_unit action ["Eject", vehicle _unit];
				}
				else
				{
					_unit remoteExecCall ["unassignVehicle", _unit];
					[[_unit], false] remoteExecCall ["orderGetIn", _unit];
				};
			};
		};
	} forEach _passenger;

	if ((getPos _vehicle select 2) > 40) then
	{
		[_vehicle] remoteExec ["rhs_fnc_vehPara",_vehicle];
	};

	if (! (getVehicleCargo _vehicle isEqualTo [])) then
	{
		_vehicle setVehicleCargo objNull;
	};
} forEach (_vehicles select {_x isKindOf "LandVehicle" || _x isKindOf "Air"});
