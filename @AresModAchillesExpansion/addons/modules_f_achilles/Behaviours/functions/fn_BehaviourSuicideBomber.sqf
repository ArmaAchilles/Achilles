/*
	Author: CreepPork_LV, shay_gman

	Description:
	 Sets a unit to be an suicide bomber

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

if(isNil "Achilles_var_ied_init_done") then
{
	publicVariableServer "Achilles_fnc_createIED";
	publicVariableServer "Achilles_fnc_createSuicideBomber";
	publicVariableServer "Achilles_fnc_IED_DamageHandler";
	publicVariableServer "Achilles_fnc_fakeExplosion";
	publicVariableServer "Achilles_fnc_disablingExplosion";
	publicVariableServer "Achilles_fnc_deadlyExplosion";

	Achilles_var_ied_init_done = true;
};

// Gets the object that the module was placed upon
private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// Displays error message if no object or unit has been selected.
if (isNull _object) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

// Displays error message if the module has been placed on top of a player.
if (isPlayer _object || isPlayer driver _object) exitWith {[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

// Displays error message if module has been placed on top of another IED
if (_object getVariable ["isIED", false]) exitWith {[localize "STR_AMAE_ENYO_OBJECT_IS_IED"] call Achilles_fnc_ShowZeusErrorMessage};

if (_object getVariable ["isSB", false]) exitWith {[localize "STR_AMAE_ENYO_UNIT_IS_SB"] call Achilles_fnc_ShowZeusErrorMessage};

// Sets Suicide Bomber functionality
if (_object isKindOf "Man") then
{
  private _dialogResult =
  [
    localize "STR_AMAE_ENYO_SET_UNIT_AS_SB",
    [
      [localize "STR_AMAE_ENYO_EXPLOSION_SIZE", [localize "STR_AMAE_ENYO_EXPLOSION_SIZE_SMALL", localize "STR_AMAE_ENYO_EXPLOSION_SIZE_MEDIUM", localize "STR_AMAE_ENYO_EXPLOSION_SIZE_LARGE"]],
      [localize "STR_AMAE_ENYO_EXPLOSION_EFFECT", [localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_DEADLY", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_DISABLING", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_FAKE", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_NONE"]],
			[localize "STR_AMAE_ENYO_ADD_SB_VEST", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
			[localize "STR_AMAE_ENYO_ACTIVATION_DISTANCE", "", "10"],
      [localize "STR_AMAE_ENYO_PATROL_RADIUS", "", "100"],
      [localize "STR_AMAE_ENYO_ACTIVATION_SIDE", "SIDE", 2]
    ]
  ] call Ares_fnc_showChooseDialog;

  if (isNil "_dialogResult") exitWith {};
  if (_dialogResult isEqualTo []) exitWith {};

  _dialogResult params ["_explosionSize", "_explosionEffect", "_addVest", "_activationDistance", "_patrolRadius", "_activationSide"];

  _activationSide = switch (_activationSide) do
  {
  	case 1:	{east};
  	case 2:	{west};
  	case 3:	{resistance};
    case 4: {civilian};
  	default {west};
  };

	_addVest = switch (_addVest) do
	{
		case 0: {true};
		case 1: {false};
	};

  if (side _object == _activationSide) exitWith {[localize "STR_AMAE_ENYO_ACTIVATION_SIDE_CANNOT_MATCH"] call Achilles_fnc_ShowZeusErrorMessage};

  _object setVariable ["isSB", true, true];

  _activationSide = [_activationSide];

  [_object, _explosionSize, _explosionEffect, _activationSide, _patrolRadius, _activationDistance, _addVest] remoteExec ["Achilles_fnc_createSuicideBomber", _object, false];
}
else
{
  [localize "STR_AMAE_ENYO_OBJECTS_NOT_ALLOWED"] call Achilles_fnc_ShowZeusErrorMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
