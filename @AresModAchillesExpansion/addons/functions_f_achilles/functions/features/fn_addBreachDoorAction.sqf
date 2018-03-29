////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			12/27/17
// VERSION: 		AMAE.1.0.0
// DESCRIPTION: 	THIS FUNCTION HAS TO BE EXECUTED ON THE PLAYER'S MACHINE!!!
//				 	this function adds the breach door action to the player
//
// ARGUMENTS:		nothing
//
// RETURNS:			SCALAR - Returnvalue of BIS_fnc_holdActionAdd (ID of the action)
//
// Example:
// call Achilles_fnc_addBreachDoorAction;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];
if (isNull _unit) exitWith {diag_log "Error in Achilles_fnc_addBreachDoorAction: Passed objNull!"};
private _actionName = if (isLocalized "STR_AMAE_SET_A_BREACHING_CHARGE") then
{
	localize "STR_AMAE_SET_A_BREACHING_CHARGE";
}
else
{
	STR_AMAE_SET_A_BREACHING_CHARGE;
};
private _id = [
	_unit,
	_actionName,
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca",
	"({_this distance _x < 3 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines _this or {""rhsusf_m112_mag"" in magazines _this}}",
	"({_this distance _x < 3 and {isNil {_x getVariable ""occupied""}}} count Achilles_var_breachableDoors > 0) and {""DemoCharge_Remote_Mag"" in magazines _this or {""rhsusf_m112_mag"" in magazines _this}}",
	{},
	{},
	{
		// get grass cutter (= source object)
		private _sourceObject = objNull;
		private _nearSourceObjects = (getPosATL _caller) nearEntities [["Land_ClutterCutter_small_F"], 3];
		if (_nearSourceObjects isEqualTo []) exitWith {};
		_sourceObject = _nearSourceObjects select 0;
		// remove charge from inventory and attach it to the door (grass cutter)
		{
			if (_x == "rhsusf_m112_mag") exitWith {
				_caller removeMagazineGlobal "rhsusf_m112_mag";
			};
			if (_x == "DemoCharge_Remote_Mag") exitWith {
				_caller removeMagazineGlobal "DemoCharge_Remote_Mag";
			};
		} forEach (magazines _caller);
		private _charge = "DemoCharge_Remote_Ammo_Scripted" createVehicle [0,0,0];
		_charge attachTo [_sourceObject, [0,0,0]];
		private _source_pos = position _sourceObject;
		private _dirVec = _source_pos vectorFromTo (position _caller);
		_dirVec set [2, 0];
		[_charge, [[0,0,1],_dirVec]] remoteExecCall ["setVectorDirAndUp",0,_charge];
		// set variables and event handlers
		_caller setVariable ["breach", _charge];
		_sourceObject setVariable ["occupied",true];
		private _actionName = if (isLocalized "STR_AMAE_TOUCH_OFF_BREACH") then
		{
			localize "STR_AMAE_TOUCH_OFF_BREACH";
		}
		else
		{
			STR_AMAE_TOUCH_OFF_BREACH;
		};
		private _action_id = _caller addAction [_actionName,
		{
			params ["_", "_caller", "_ID", "_arguments"];
			_caller removeAction _ID;
			_arguments params ["_charge"];
			private _explosion_pos = position _charge;
			_sourceObject = attachedTo _charge;
			private _logic = attachedTo _sourceObject;
			(_logic getVariable "lock_params") params ["_building", "_lock_var", "_trigger_pos", "_source"];
			"SmallSecondary" createVehicle _explosion_pos;
			deleteVehicle _logic;
			deleteVehicle _sourceObject;
			deleteVehicle _charge;
			[_building,_source] spawn {sleep 1; params ["_building","_source"]; _building animateSource [_source, 1, true]};
			[_explosion_pos] remoteExec ["Achilles_fnc_breachStun",0];
		}, [_charge], 20];
		private _killed_id = _caller addEventHandler ["killed", {params ["_caller"]; _charge = _caller getVariable "breach"; (attachedTo _charge) setVariable ["occupied",nil]; deleteVehicle _charge}];
		_charge addEventHandler ["Deleted", format ["player removeEventHandler [""killed"", %1]; _caller removeAction %2", _killed_id, _action_id]];
		// event handler for defused charge
		[_caller, _charge,_sourceObject,_killed_id,_action_id] spawn
		{
			params ["_caller","_charge","_sourceObject","_killed_id","_action_id"];
			while {!isNull _sourceObject} do
			{
				uiSleep 1;
				if(isNull _charge) exitWith
				{
					_sourceObject setVariable ["occupied",nil];
					_caller removeAction _action_id;
					_caller removeEventHandler ["killed", _killed_id];
				};
			};
		};
	},
	{},
	[],
	7,
	20,
	false,
	false
] call BIS_fnc_holdActionAdd;
_id;