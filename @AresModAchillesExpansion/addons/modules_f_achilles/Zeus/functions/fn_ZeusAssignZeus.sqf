/*
	Author: CreepPork_LV, Kex, Talya

	Description:
	 Sets a unit to be a Curator.

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

_player = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// mission designer can disallow usage of execute code module, but it will still be available for logged-in admins
if (not (missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true]) and not (serverCommandAvailable "#kick")) exitWith
{
	["This module has been disabled by the mission creator."] call Ares_fnc_ShowZeusMessage;
};

if (isNull _player) exitWith {[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};
if (!isPlayer _player) exitWith {[localize "STR_NO_object_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};
if (!isNull getAssignedCuratorLogic _player) exitWith {[localize "STR_UNIT_IS_ALREADY_PROMOTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

[[_player, getPos _player],
{
  params ["_player", "_playerPos"];
  
  private _moderatorModule = (createGroup sideLogic) createUnit ["ModuleCurator_F", _playerPos, [], 0, ""];
  _player assignCurator _moderatorModule;
  _player setVariable ["Achilles_var_promoZeusModule", _moderatorModule, true];
}] remoteExecCall ["call", 2];

["You are now a Curator!"] remoteExecCall ["hint", _player];

// Loose curator rights if killed
_eh_id = _player addEventHandler ["killed", 
{
	params ["_unit"];
	
	private _module =  _unit getVariable ["Achilles_var_promoZeusModule", objNull];
	if (not isNull _module) then {(group _module) deleteGroupWhenEmpty true; deleteVehicle _module};
	_unit removeEventHandler ["killed", _unit getVariable "Achilles_var_promoZeusModuleEHID"];
	["You lost your Curator rights!"] remoteExecCall ["hint", _unit];
}];
_player setVariable ["Achilles_var_promoZeusModuleEHID", _eh_id];

#include "\achilles\modules_f_ares\module_footer.hpp"
