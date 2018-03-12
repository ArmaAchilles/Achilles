////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/7/17
//	VERSION: 3.0
//  DESCRIPTION: Executes when curator editable object is moved or rotated
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _handled_object = param [1,objNull,[objNull]];

if (isNull _handled_object) exitWith {};

switch (true) do
{
	case (_handled_object isKindOf "logic"):
	{
		if (toLower typeOf _handled_object == "module_f") then
		{
			// hanlde logic for simple objects on first edit
			/*
			_jip_id = _handled_object getVariable "needInit";
			if (not isNil "_jip_id") then
			{
				_jip_id = _handled_object getVariable "needInit";
				remoteExecCall ["", _jip_id];
				_handled_object setVariable ["needInit", nil];
			};
			*/
		};
		systemChat str [1, typeOf _handled_object, _handled_object];
		if(!isNull (_handled_object getVariable ["slave", objNull])) then
		{
			private _slave = _handled_object getVariable "slave";
			systemChat str [1, typeOf _slave, _slave, isNull _slave];
			_slave setPosATL getPosATL _handled_object;
			[_slave, [vectorDir _handled_object, vectorUp _handled_object]] remoteExecCall ["setVectorDirAndUp", 0, _slave];
		};
	};

	case (!isNil {_handled_object getVariable "Achilles_var_groupAttributes"}):
	{
		// if object is a center object of a group => correct position and orientation for other objects of the group
		private _group_attributes = _handled_object getVariable "Achilles_var_groupAttributes";
		private _center_pos = getPosWorld _handled_object;

		// define internal basis
		private _vector_dir = vectorDir _handled_object;
		private _vector_up =  vectorUp _handled_object;
		private _vector_perpendicular = _vector_dir vectorCrossProduct _vector_up;

		// define transformation matrix
		private _standard_to_internal = [_vector_dir, _vector_up, _vector_perpendicular];
		private _internal_to_standard = [_standard_to_internal] call Achilles_fnc_matrixTranspose;

		{
			_x params ["_object"];

			// reposition
			private _vector_center_object = [_internal_to_standard, _x select 1] call Achilles_fnc_vectorMap;
			_object setPosWorld (_vector_center_object vectorAdd _center_pos);

			// reorientation
			private _vectors_dir_up = (_x select [2,2]) apply {	[_internal_to_standard, _x] call Achilles_fnc_vectorMap; };

			[_object ,_vectors_dir_up] remoteExec ["setVectorDirAndUp",0,_object];

		} forEach _group_attributes;
	};
	case (_handled_object isKindOf "Man" && ((group _handled_object) getVariable ["Achilles_var_inGarrison", false])):
	{
		// enables rotation of individual units in garrisons
		_handled_object doWatch (ASLtoATL eyePos _handled_object vectorAdd vectorDir _handled_object);
	};
	// does not yet work properly: e.g. catapults
	/*
	case (_handled_object isKindOf "Land_Carrier_01_base_F"):
	{
		[_handled_object] remoteExecCall ["BIS_fnc_Carrier01PosUpdate", 2];
	};
	*/
};
