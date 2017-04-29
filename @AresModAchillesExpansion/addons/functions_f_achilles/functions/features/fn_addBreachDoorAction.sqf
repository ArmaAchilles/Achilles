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
	"({player distance _x < 3 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines player or {""rhsusf_m112_mag"" in magazines player}}",	
	"({player distance _x < 3 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines player or {""rhsusf_m112_mag"" in magazines player}}",	
	{},			
	{},			
	{
		// get grass cutter (= source object)
		_sourceObject = objNull;
		_nearSourceObjects = nearestObjects [getPosATL player, ["Land_ClutterCutter_small_F"], 3];
		if (count _nearSourceObjects == 0) exitWith {};
		_sourceObject = _nearSourceObjects select 0;
		// remove charge from inventory and attach it to the door (grass cutter)
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
		_source_pos = position _sourceObject;
		_dirVec = _source_pos vectorFromTo (position player);
		_dirVec set [2, 0];
		[_charge, [[0,0,1],_dirVec]] remoteExecCall ["setVectorDirAndUp",0,_charge];
		// set variables and event handlers
		player setVariable ["breach", _charge];
		_sourceObject setVariable ["occupied",true];
		_action_id = player addAction ["Touch off (breach)", 
		{
			player removeAction (_this select 2);
			(_this select 3) params ["_charge"];
			_explosion_pos = position _charge;
			_sourceObject = attachedTo _charge;
			_logic = attachedTo _sourceObject;
			(_logic getVariable "lock_params") params ["_building", "_lock_var", "_trigger_pos", "_source"];
			"SmallSecondary" createVehicle _explosion_pos;
			deleteVehicle _logic;
			deleteVehicle _sourceObject;
			deleteVehicle _charge;
			[_building,_source] spawn {sleep 1; params ["_building","_source"]; _building animateSource [_source, 1, true];};
			[_explosion_pos] remoteExec ["Achilles_fnc_breachStun",0];
		}, [_charge], 20];
		_killed_id = player addEventHandler ["killed", {_charge = player getVariable "breach"; (attachedTo _charge) setVariable ["occupied",nil]; deleteVehicle _charge}];
		_charge addEventHandler ["Deleted", format ["player removeEventHandler [""killed"", %1]; player removeAction %2", _killed_id, _action_id]];
		// event handler for defused charge
		[_charge,_sourceObject,_killed_id,_action_id] spawn
		{
			params ["_charge","_sourceObject","_killed_id","_action_id"];
			while {not isNull _sourceObject} do 
			{
				uiSleep 1;
				if(isNull _charge) exitWith 
				{
					_sourceObject setVariable ["occupied",nil];
					player removeAction _action_id;
					player removeEventHandler ["killed", _killed_id];
				}
			};
		}
	},	
	{},			
	[],			
	7,	
	20,			
	false,		
	false		
] call BIS_fnc_holdActionAdd;
