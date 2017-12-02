////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR:			Kex
//	DATE: 			7/22/17
//	VERSION: 		AMAE001
//	DESCRIPTION:	Spawns given code
//					If target is a remote machine, the code is remote executed, but only Zeus players are allowed to make use of it
//					If target is the local machine (default), then the code is directly executed (unlike remoteExec)
//
//	ARGUMENTS:		0: ARRAY - arguments for the script
//					1: CODE - the script
//					2: SCALAR/ARRAY/OBJECT/GROUP - (optional) target - same argument as in remoteExec (default: client's machine)
//					3: BOOL/STRING/OBJECT - (optional) jip - same argument as in remoteExec (default: false)
//
//	RETURNS:		STRING - Nil in case of error. String otherwise. If JIP is not requested this is an empty string, if JIP is requested, it is the JIP ID.
//
//	Example:		[[_message], {systemChat _this}, -2] call Achilles_fnc_spawn;	// send system chat message to every player
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_args", ["_code", {}, [{}]], ["_target", clientOwner, [0, [], objNull, grpNull]], ["_jip", false, [false, "", objNull]]];

private _jip_id = "";

if((_target isEqualType 0 and {_target == clientOwner}) or {_target isEqualTypeAny [grpNull, objNull] and {local _target}}) then
{
	// if target is the local machine only
	_args spawn _code;
} else
{
	// send code to the server for remote execution
	_jip_id = [_args, _code, _target, _jip] remoteExecCall ["Achilles_fnc_spawn_remote", 2];
};
_jip_id;
