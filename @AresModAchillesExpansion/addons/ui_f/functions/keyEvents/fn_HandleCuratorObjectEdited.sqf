////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 20/11/16
//	VERSION: 1.0
//	FILE: Achilles\ui_f\functions\keyEvents\fn_HandleCuratorObjectEdited.sqf
//  DESCRIPTION: Executes when curator editable object is moved or rotated
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_handled_object = param [1,objNull,[objNull]];

if (isNull _handled_object) exitWith {};

if (_handled_object isKindOf "logic") then
{
	if (toLower typeOf _handled_object == "module_f") then
	{
		// hanlde logic for simple objects on first edit
		_jip_id = _handled_object getVariable "needInit";
		if (not isNil "_jip_id") then
		{
			_jip_id = _handled_object getVariable "needInit";
			remoteExecCall ["", _jip_id];
			_handled_object setVariable ["needInit", nil];
		};
	};
	if(not isNull (_handled_object getVariable ["slave", objNull])) then
	{
		_slave = _handled_object getVariable "slave";
		_slave setPosATL getPosATL _handled_object;
		[_slave, direction _handled_object] remoteExecCall ["setDir", 0];
		[_slave, [vectorDir _handled_object, vectorUp _handled_object]] remoteExecCall ["setVectorDirAndUp", 0, _slave];
	};
};

// if object is a center object of a group => correct position and orientation for other objects of the group
_group_attributes = _handled_object getVariable ["Achilles_var_groupAttributes",nil];
if (not isNil "_group_attributes") then
{
	_center_pos = getPosWorld _handled_object;
	
	// define internal basis
	_vector_dir = vectorDir _handled_object;
	_vector_up =  vectorUp _handled_object;
	_vector_perpendicular = _vector_dir vectorCrossProduct _vector_up;

	// define transformation matrix
	_standard_to_internal = [_vector_dir, _vector_up, _vector_perpendicular];
	_internal_to_standard = [_standard_to_internal] call Achilles_fnc_matrixTranspose;
	
	{
		_object = _x select 0;
		
		// reposition
		_vector_center_object = [_internal_to_standard, _x select 1] call Achilles_fnc_vectorMap;
		_object setPosWorld (_vector_center_object vectorAdd _center_pos);
		
		// reorientation
		_vectors_dir_up = (_x select [2,2]) apply 
		{
			_return = [_internal_to_standard, _x] call Achilles_fnc_vectorMap;
			_return;
		};
		
		[_object ,_vectors_dir_up] remoteExec ["setVectorDirAndUp",0,_object];
		
	} forEach _group_attributes;
};