////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/25/17
//	VERSION: 1.0
//  DESCRIPTION: THIS FUNCTION HAS TO BE EXECUTED ON THE PLAYER'S MACHINE!!!
//				 this function adds the breach door action to the player
//
//	ARGUMENTS:
//	nothing
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	call Achilles_fnc_addBreachDoorAction;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[
	player,			
	"Set demo charge",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca",			
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca",			
	"({player distance _x < 2 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines player or {""rhsusf_m112_mag"" in magazines player}}",	
	"({player distance _x < 2 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines player or {""rhsusf_m112_mag"" in magazines player}}",	
	{},			
	{},			
	{
		_sourceObject = objNull;
		{if(player distance _x < 2) exitWith {_sourceObject = _x}} forEach Achilles_var_breachableDoors;
		if (isNull _sourceObject) exitWith {};
		{
			if (_x == "rhsusf_m112_mag") exitWith {
				player removeMagazineGlobal "rhsusf_m112_mag";
			};
			if (_x == "DemoCharge_Remote_Mag") exitWith {
				player removeMagazineGlobal "DemoCharge_Remote_Mag";
			};
		} forEach (magazines player);
		_charge = "DemoCharge_Remote_Ammo_Scripted" createVehicle [0,0,0];
		_charge attachTo [_sourceObject, [0,0,0]];
		_dirVec = (position _sourceObject) vectorFromTo (position player);
		_dirVec set [2, 0];
		[_charge, [[0,0,1],_dirVec]] remoteExecCall ["setVectorDirAndUp",0,_charge];
		player setVariable ["breach", _charge];
		_sourceObject setVariable ["occupied",true];
		_action_id = player addAction ["Touch off (breach)", 
		{
			player removeAction (_this select 2);
			(_this select 3) params ["_charge"];
			_sourceObject = attachedTo _charge;
			_logic = attachedTo _sourceObject;
			(_logic getVariable "lock_params") params ["_building", "_lock_var", "_trigger_pos", "_source"];
			_position = position _charge;
			"SmallSecondary" createVehicle _position;
			deleteVehicle _logic;
			deleteVehicle _sourceObject;
			deleteVehicle _charge;
			_building animateSource [_source, 1, true];
			[_position] remoteExec ["SAF_fnc_breachStun"];
		}, [_charge], 20];
		_killed_id = player addEventHandler ["killed", {_charge = player getVariable "breach"; (attachedTo _charge) setVariable ["occupied",nil]; deleteVehicle _charge}];
		_charge addEventHandler ["Deleted", format ["player removeEventHandler [""killed"", %1]; player removeAction %2", _killed_id, _action_id]];
	},	
	{},			
	[],			
	7,	
	20,			
	false,		
	false		
] call BIS_fnc_holdActionAdd;
