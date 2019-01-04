/*
	Function:
		Achilles_fnc_transferOwnership
	
	Authors:
		Kex
	
	Description:
		Changest the ownership of the past objects and groups
		Provides a workaround for the loss of loadout bug after the transfer
		This function has to be executed in scheduled environment and is completed as soon as it can confirm that the transfer was completed.
	
	Parameters:
		_object_list	- <ARRAY> of <OBJECT> Objects to transfer
		_group_list		- <ARRAY> of <GROUP> Groups to transfer
		_ownerID		- <INTEGER> [clientOwner] The owner ID of the machine the objects and groups should be transfered to
							By default they are transfered to this machine
	
	Returns:
		nothing
	
	Exampes:
		(begin example)
		(end)
*/
params ["_object_list", "_group_list", ["_ownerID", clientOwner, [0]]];

// filter groups with players
_group_list = _group_list select {(units _x) findIf {isPlayer _x} < 0};

if (_ownerID > 0 && (_ownerID != clientOwner)) then
{
	// transfer ownership to server
	// save the unit loadout
	{
		{
			if (alive _x) then
			{
				_x setVariable ["Achilles_var_tmpLoadout", getUnitLoadout _x, true];
			};
		} forEach units _x;
	} forEach _group_list;
	[
		[_ownerID,_object_list,_group_list],
		{
			params ["_ownerID","_object_list", "_group_list"];
			// change ownership
			{_x setOwner _ownerID} forEach _object_list;
			{_x setGroupOwner _ownerID} forEach _group_list;
			// reset the unit loadout as soon as they have become local
			waitUntil {sleep 1; ({not local _x} count _group_list == 0) or {({not isNull _x} count _group_list == 0) or {{{alive _x} count units _x > 0} count _group_list == 0}}};
			{
				{
					private _loadout = _x getVariable ["Achilles_var_tmpLoadout", []];
					if !(_loadout isEqualTo []) then
					{
						_x setUnitLoadout _loadout;
					};
					_x setVariable ["Achilles_var_tmpLoadout", nil, true];
				} forEach units _x;
			} forEach _group_list;
		}, 2
	] call Achilles_fnc_spawn;
}
else
{
	// transfer ownership to Zeus
	[
		[clientOwner,_object_list,_group_list],
		{
			params ["_ownerID", "_object_list", "_group_list"];
			// save the unit loadout
			{
				{
					if (alive _x) then
					{
						_x setVariable ["Achilles_var_tmpLoadout", getUnitLoadout _x, true];
					};
				} forEach units _x;
			} forEach _group_list;
			// change ownership
			{_x setOwner _ownerID} forEach _object_list;
			{_x setGroupOwner _ownerID} forEach _group_list;
		}, 2
	] call Achilles_fnc_spawn;
	// reset the unit loadout as soon as they have become local
	waitUntil {sleep 1; ({not local _x} count _group_list == 0) or {({not isNull _x} count _group_list == 0) or {{{alive _x} count units _x > 0} count _group_list == 0}}};
	{
		{
			private _loadout = _x getVariable ["Achilles_var_tmpLoadout", []];
			if !(_loadout isEqualTo []) then
			{
				_x setUnitLoadout _loadout;
			};
			_x setVariable ["Achilles_var_tmpLoadout", nil, true];
		} forEach units _x;
	} forEach _group_list;
};
