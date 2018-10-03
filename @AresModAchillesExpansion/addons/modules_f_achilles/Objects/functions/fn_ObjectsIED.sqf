/*
	Author: CreepPork_LV, shay_gman

	Description:
	 Sets a object to be a IED

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon

  Returns:
    Nothing
*/

#include "\achilles\modules_f_ares\module_header.inc"

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

// Gets Module placed object.
private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// Displays error message if no object or unit has been selected.
if (isNull _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

// Displays error message if the module has been placed on top of a player.
if (isPlayer _object || isPlayer driver _object) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage};

// Displays error message if module has been placed on top of another IED
if (_object getVariable ["isIED", false]) exitWith {[localize "STR_AMAE_ENYO_OBJECT_IS_IED"] call Achilles_fnc_ShowZeusErrorMessage};

if (_object getVariable ["isSB", false]) exitWith {[localize "STR_AMAE_ENYO_UNIT_IS_SB"] call Achilles_fnc_ShowZeusErrorMessage};

// Sets IED functionality
if (_object isKindOf "Man") then
{
  [localize "STR_AMAE_ENYO_UNITS_NOT_ALLOWED"] call Achilles_fnc_ShowZeusErrorMessage;
}
else
{
  private _dialogResult =
  [
    localize "STR_AMAE_ENYO_SET_OBJECT_AS_IED",
    [
      [localize "STR_AMAE_ENYO_EXPLOSION_SIZE", [localize "STR_AMAE_ENYO_EXPLOSION_SIZE_SMALL", localize "STR_AMAE_ENYO_EXPLOSION_SIZE_MEDIUM", localize "STR_AMAE_ENYO_EXPLOSION_SIZE_LARGE"]],
      [localize "STR_AMAE_ENYO_EXPLOSION_EFFECT", [localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_DEADLY", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_DISABLING", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_FAKE", localize "STR_AMAE_ENYO_EXPLOSION_EFFECT_NONE"]],
      [localize "STR_AMAE_ENYO_CAN_BE_DISARMED", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
      [localize "STR_AMAE_ENYO_DISARM_TIME", "", "10"],
      [localize "STR_AMAE_ENYO_ACTIVATION_TYPE", [localize "STR_AMAE_ENYO_ACTIVATION_TYPE_MANUAL", localize "STR_AMAE_ENYO_ACTIVATION_TYPE_PROXIMITY", localize "STR_AMAE_ENYO_ACTIVATION_TYPE_RADIO"], 1],
      [localize "STR_AMAE_ENYO_IS_JAMMABLE", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
      [localize "STR_AMAE_ENYO_ACTIVATION_DISTANCE", "", "10"],
      [localize "STR_AMAE_ENYO_ACTIVATION_SIDE", "SIDE", 2]
    ]
  ] call Ares_fnc_showChooseDialog;

  if (isNil "_dialogResult") exitWith {};
  if (_dialogResult isEqualTo []) exitWith {};

  _object setVariable ["isIED", true, true];

  _dialogResult params
  [
    "_explosionSize",
    "_explosionEffect",
    "_canBeDefused",
    "_disarmTime",
    "_activationType",
    "_isJammable",
    "_activationDistance",
    "_activationSide"
  ];

  [_object, _explosionSize, _explosionEffect, _activationDistance, _activationSide, _activationType, _isJammable, _disarmTime, _canBeDefused] remoteExec ["Achilles_fnc_createIED", 2, false];
};

#include "\achilles\modules_f_ares\module_footer.inc"
