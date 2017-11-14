////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//AUTHOR:			Kex
// DATE: 			7/22/17
// VERSION: 		AMAE002
// DESCRIPTION:		Remote helper function for Achilles_fnc_spawn
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_args", ["_code", {}, [{}]], ["_target", 0, [0, [], objNull, grpNull, sideUnknown]], ["_jip", false, [false, "", objNull]]];

private _rc_owner = remoteExecutedOwner;
// execute code if rc owner is server
if (_rc_owner == 2) exitWith
{
	_args call _code;
};

private _jip_id = "";

if (isServer) then
{
	private _curator_owners = allCurators apply {owner _x};
	if (_rc_owner in _curator_owners) then
	{
		if((typeName _target == typeName 0 and {_target == 2}) or {typeName _target in [typeName grpNull, typeName objNull] and {local _target}}) then
		{
			// if target is server
			_args call _code;
		} else
		{
			// send code to targets => rc owner switches to server
			_jip_id = [_args, _code] remoteExec ["Achilles_fnc_spawn", _target, _jip];
		};
	} else
	{
		// log unauthorized call
		private "_player";
		{
			if (owner _x == _rc_owner) exitWith {_player = _x};
		} forEach allPlayers;
		diag_log format ["Warning: %1 (UID: %2) tried to use Achilles_fnc_spawn without permission!", name _player, getPlayerUID _player];
	};
};

_jip_id;
