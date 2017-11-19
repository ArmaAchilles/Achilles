////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/3/16
//	VERSION: 1.0
//	FILE: Achilles\modules\Objects\fn_ObjectsAttachTo.sqf
//  DESCRIPTION: Function for the module "Attach To"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _object_to_attach = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNull _object_to_attach) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
if (isNull (_object_to_attach getVariable ['attached', objNull])) then
{
	private _object_to_attach_to = ([localize "STR_OBJECT", true] call Achilles_fnc_SelectUnits);
	if (isNil "_object_to_attach_to") exitWith {};
	if (isNull _object_to_attach_to) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
	private _phi_zero = direction _object_to_attach_to;
	private _phi = direction _object_to_attach;
	_object_to_attach attachTo [_object_to_attach_to];
	[_object_to_attach, (_phi - _phi_zero)] remoteExec ['setDir',0,true];
	_object_to_attach setVariable ['attached', _object_to_attach_to];

	// If the object trying to get attached has a dummy logic
	if (_object_to_attach getVariable ["Achilles_var_createDummyLogic_isAttached", false]) then 
	{
		(_object_to_attach getVariable ["Achilles_var_createDummyLogic_dummyObject", objNull]) attachTo [_object_to_attach_to];
	};

	[localize "STR_OBJECT_ATTCHED"] call Ares_fnc_ShowZeusMessage;
} else {
	detach _object_to_attach;
	_object_to_attach setVariable ['attached', objNull];

	// If the object trying to get dettached has a dummy logic
	if (_object_to_attach getVariable ["Achilles_var_createDummyLogic_isAttached", false]) then 
	{
		detach (_object_to_attach getVariable ["Achilles_var_createDummyLogic_dummyObject", objNull]);
	};

	[localize "STR_OBJECT_DETACHED"] call Ares_fnc_ShowZeusMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
