////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/7/17
//	VERSION: 3.0
//  DESCRIPTION: Executes when curator editable object is deleted
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_handled_object = param [1,objNull,[objNull]];

if (isNull _handled_object) exitWith {};

if (_handled_object isKindOf "logic") then
{
	switch (true) do
	{
		case (not isNull (_handled_object getVariable ["slave", objNull])):
		{
			_slave = _handled_object getVariable "slave";
			deleteVehicle _slave;
		};	
		case (not isNil {_handled_object getVariable "lock_params"}):
		{
			(_handled_object getVariable "lock_params") params ["_building", "_lock_var"];
			_building setVariable [_lock_var, 0, true];
			{deleteVehicle _x} forEach (attachedObjects _handled_object);
			_logic_group = group _handled_object;
			_logic_group deleteGroupWhenEmpty true;
		};
		case (count attachedObjects _handled_object > 0):
		{
			{deleteVehicle _x} forEach (attachedObjects _handled_object);
		};			
		default {};
	};
};