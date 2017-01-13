///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/20/16
//	VERSION: 1.0
//	FILE: Achilles\functions_f_achilles\features\fn_ungroupObjects.sqf
//  DESCRIPTION: Ungroup a group of objects if center object is in input array
//
//	ARGUMENTS:
//	_this select 0:			ARRAY	- array of objects
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_center_object_1,_center_object_2,_center_object_3] call Achilles_fnc_ungroupObjects;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_object_list = param [0,[],[[]]];

if (count _object_list == 0) exitWith {};

{
	_center_object = _x;
	_group_attributes = _center_object getVariable ["Achilles_var_groupAttributes",nil];
	if (not isNil "_group_attributes") then
	{
		_objects = _group_attributes apply 
		{
			_object = _x select 0;
			if (_object getVariable ["enabledSimulation",true]) then
			{
				[_object,true] remoteExec ["enableSimulationGlobal",2];
			};
			_object;
		};
		[_objects, true] call Ares_fnc_AddUnitsToCurator;
		_center_object setVariable ["Achilles_var_groupAttributes",nil];
		if (_center_object getVariable ["enabledSimulation",true]) then
		{
			[_center_object,true] remoteExec ["enableSimulationGlobal",2];
		};
	};
} forEach _object_list;