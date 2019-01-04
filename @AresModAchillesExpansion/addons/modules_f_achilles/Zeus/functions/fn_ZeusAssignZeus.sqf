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

private _player = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// mission designer can disallow usage of execute code module, but it will still be available for logged-in admins
if (!(missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true]) and !(serverCommandAvailable "#kick")) exitWith
{
	["This module has been disabled by the mission creator."] call Ares_fnc_ShowZeusMessage;
};

if (isNull _player) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};
if (!isPlayer _player) exitWith {[localize "STR_AMAE_NO_PLAYER_IN_SELECTION"] call Achilles_fnc_ShowZeusErrorMessage};
if (!isNull getAssignedCuratorLogic _player) exitWith {[localize "STR_AMAE_UNIT_IS_ALREADY_PROMOTED"] call Achilles_fnc_ShowZeusErrorMessage};

[[_player, getPos _player],
{
  params ["_player", "_playerPos"];

  private _moderatorModule = (createGroup sideLogic) createUnit ["ModuleCurator_F", _playerPos, [], 0, ""];
  _player assignCurator _moderatorModule;
  _player setVariable ["Achilles_var_promoZeusModule", _moderatorModule, true];
}, 2] call Achilles_fnc_spawn;

["You are now a Curator!"] remoteExecCall ["hint", _player];

// Loose curator rights if killed
private _eh_id = _player addEventHandler ["killed",
{
	params ["_unit"];

	private _module =  _unit getVariable ["Achilles_var_promoZeusModule", objNull];
	if (!isNull _module) then {(group _module) deleteGroupWhenEmpty true; deleteVehicle _module};
	_unit removeEventHandler ["killed", _unit getVariable "Achilles_var_promoZeusModuleEHID"];
	["You lost your Curator rights!"] remoteExecCall ["hint", _unit];
}];
_player setVariable ["Achilles_var_promoZeusModuleEHID", _eh_id];

#include "\achilles\modules_f_ares\module_footer.hpp"
