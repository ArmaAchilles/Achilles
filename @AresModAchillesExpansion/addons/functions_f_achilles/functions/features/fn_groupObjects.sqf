///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/20/16
//	VERSION: 1.0
//	FILE: Achilles\functions_f_achilles\features\fn_groupObjects.sqf
//  DESCRIPTION: Group given objects
//
//	ARGUMENTS:
//	_this select 0:			ARRAY	- array of objects; first element is the center object
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_center_object,_object_1,_object_2] call Achilles_fnc_groupObjects;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _object_list = param [0,[],[[]]];
private _center_object = _object_list param [0,objNull,[objNull]];
_object_list = _object_list - [_center_object];

if (isNull _center_object or (_object_list isEqualTo [])) exitWith {};
if (!isNil {_center_object getVariable ["Achilles_var_groupAttributes",nil]}) exitWith {};

private _center_pos = getPosWorld _center_object;

// define internal basis
private _vector_dir = vectorDir _center_object;
private _vector_up =  vectorUp _center_object;
private _vector_perpendicular = _vector_dir vectorCrossProduct _vector_up;

// define transformation matrices
private _standard_to_internal = [_vector_dir, _vector_up, _vector_perpendicular];

[_center_object,false] remoteExec ["enableSimulationGlobal",2];
private _group_attributes = [];

{
	// save object vectors in internal basis
	private _object = _x;
	private _object_pos = getPosWorld _object;
	private _vector_center_object = _object_pos vectorDiff _center_pos;
	private _attributes = [_vector_center_object, vectorDir _object, vectorUp _object] apply
	{
		private _return = [_standard_to_internal, _x] call CBA_fnc_vectMap3D;
		_return;
	};
	_group_attributes pushBack ([_object] + _attributes);

	[_object,false] remoteExec ["enableSimulationGlobal",2];
} forEach _object_list;

[_object_list, false] call Ares_fnc_AddUnitsToCurator;

_center_object setVariable ["Achilles_var_groupAttributes",_group_attributes];
