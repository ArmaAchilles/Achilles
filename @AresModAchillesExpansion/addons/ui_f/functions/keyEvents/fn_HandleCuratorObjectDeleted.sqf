////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/7/17
//	VERSION: 3.0
//  DESCRIPTION: Executes when curator editable object is deleted
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _handled_object = param [1,objNull,[objNull]];

if (isNull _handled_object) exitWith {};

switch (true) do
{
	case (_handled_object isKindOf "logic"):
	{
		switch (true) do
		{
			case (!isNull (_handled_object getVariable ["slave", objNull])):
			{
				private _slave = _handled_object getVariable "slave";
				deleteVehicle _slave;
			};
			case (!isNil {_handled_object getVariable "lock_params"}):
			{
				(_handled_object getVariable "lock_params") params ["_building", "_lock_var"];
				_building setVariable [_lock_var, 0, true];
				{deleteVehicle _x} forEach (attachedObjects _handled_object);
			};
			case (count attachedObjects _handled_object > 0):
			{
				{deleteVehicle _x} forEach (attachedObjects _handled_object);
			};
			default {};
		};
		private _logic_group = group _handled_object;
		_logic_group deleteGroupWhenEmpty true;
	};
	case (_handled_object isKindOf "Land_Carrier_01_base_F"):
	{
		// {deleteVehicle _x} forEach (nearestObjects [position _handled_object, ["Land_Carrier_01_hull_GEO_Base_F","Land_Carrier_01_hull_base_F","DynamicAirport_01_F"], 200, true]);
		private _carrierPartsArray = _handled_object getVariable ["bis_carrierParts", []];
		{
			deleteVehicle (_x param [0,objNull]);
		} foreach _carrierPartsArray;
	};
	case (_handled_object isKindOf "Land_Destroyer_01_base_F"):
	{
		private _destroyerPartsArray = _handled_object getVariable ["bis_carrierParts", []];
		{
			deleteVehicle (_x param [0,objNull]);
		} foreach _destroyerPartsArray;
	};
};
