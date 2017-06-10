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

// Gets the object that the module was placed upon
_object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// Displays error message if no object or unit has been selected.
if (isNull _object) exitWith {[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

// Displays error message if the module has been placed on top of a player.
if (isPlayer _object || isPlayer driver _object) exitWith {[localize "STR_NO_UNIT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

// Displays error message if module has been placed on top of another IED
if (_object getVariable ["isIED", false]) exitWith {[localize "STR_ENYO_OBJECT_IS_IED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

if (_object getVariable ["isSB", false]) exitWith {[localize "STR_ENYO_UNIT_IS_SB"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

// Sets Suicide Bomber functionality
if (_object isKindOf "Man") then
{
  _dialogResult =
  [
    localize "STR_ENYO_SET_UNIT_AS_SB",
    [
      [localize "STR_ENYO_EXPLOSION_SIZE", [localize "STR_ENYO_EXPLOSION_SIZE_SMALL", localize "STR_ENYO_EXPLOSION_SIZE_MEDIUM", localize "STR_ENYO_EXPLOSION_SIZE_LARGE"]],
      [localize "STR_ENYO_EXPLOSION_EFFECT", [localize "STR_ENYO_EXPLOSION_EFFECT_DEADLY", localize "STR_ENYO_EXPLOSION_EFFECT_DISABLING", localize "STR_ENYO_EXPLOSION_EFFECT_FAKE", localize "STR_ENYO_EXPLOSION_EFFECT_NONE"]],
      [localize "STR_ENYO_ACTIVATION_DISTANCE", "", "10"],
      [localize "STR_ENYO_PATROL_RADIUS", "", "100"],
      [localize "STR_ENYO_ACTIVATION_SIDE", "SIDE"]
    ]
  ] call Ares_fnc_showChooseDialog;

  if (isNil "_dialogResult") exitWith {};
  if (count _dialogResult == 0) exitWith {};

  _explosionSize = _dialogResult select 0;
  _explosionEffect = _dialogResult select 1;
  _activationDistance = _dialogResult select 2;
  _patrolRadius = _dialogResult select 3;
  _activationSide = _dialogResult select 4;

  _activationSide = switch (_activationSide) do
  {
  	case 1:	{east};
  	case 2:	{west};
  	case 3:	{resistance};
    case 4: {civilian};
  	default {west};
  };

  if (side _object == _activationSide) exitWith {[localize "STR_ENYO_ACTIVATION_SIDE_CANNOT_MATCH"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

  _object setVariable ["isSB", true, true];

  _activationSide = [_activationSide];

  [_object, _explosionSize, _explosionEffect, _activationSide, _patrolRadius, _activationDistance] remoteExec ["Achilles_fnc_createSuicideBomber", _object, false];
}
else
{
  [localize "STR_ENYO_OBJECTS_NOT_ALLOWED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";
};

#include "\achilles\modules_f_ares\module_footer.hpp"
