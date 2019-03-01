/*
	Author: CreepPork_LV

	Description:
		Surrenders a unit and forces a animation and allows players to free the captive unit.

	Parameters:
		None

	Returns:
		Nothing

*/

#include "\achilles\modules_f_ares\module_header.inc.sqf"

private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// If no unit was selected then initiate Select Units feature
private _selectedUnits = if (isNull _unitUnderCursor) then
{
	[localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
}
else
{
	[_unitUnderCursor];
};

// If Select was canceled
if (isNil "_selectedUnits") exitWith {};

// If nothing was selected then exit
if (_selectedUnits isEqualTo []) exitWith { [localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_showZeusErrorMessage; };

// If any players are selected then exit
{
	if (_x in _selectedUnits) exitWith { [localize "STR_AMAE_SELECT_NON_PLAYER_UNITS"] call Achilles_fnc_ShowZeusErrorMessage; };
} forEach allPlayers;

//Broadcast surrender functions
if (isNil "Achilles_var_surrender_units_init_done") then
{
	if (isNil "Achilles_var_animation_init_done") then
	{
		publicVariable "Achilles_fnc_ambientAnimGetParams";
		publicVariable "Achilles_fnc_ambientAnim";
		Achilles_var_animation_init_done = true;
	};

	publicVariable "Achilles_fnc_surrenderUnit";
	publicVariable "Achilles_fnc_changeSide_local";
	Achilles_var_surrender_units_init_done = true;
};

{
	private _unit = _x;

	if (_unit getVariable ["Achilles_var_isUnitSurrendered", false]) then
	{
		private _releasedUnitSide = _unit getVariable ["Achilles_var_getUnitSurrenderedSide", civilian];

		// Release captive unit
		if (local _unit) then
		{
			[_unit, false, _releasedUnitSide, "releaseNotLead"] call Achilles_fnc_surrenderUnit;
		}
		else
		{
			[_unit, false, _releasedUnitSide, "releaseNotLead"] remoteExecCall ["Achilles_fnc_surrenderUnit", _unit];
		};
	}
	else
	{
		// Show dialog to set the unit to be captive
		private _dialogResult =
		[
			localize "STR_AMAE_SURRENDER_UNIT",
			[
				[localize "STR_AMAE_AMBIENT_ANIMATION", [localize "STR_AMAE_SURRENDER_UNIT", localize "STR_AMAE_TIE_UNIT"]],
				[localize "STR_AMAE_INTERACTION", [localize "STR_AMAE_RELEASE_N_LEAD_UNIT", localize "STR_AMAE_RELEASE_UNIT", localize "STR_AMAE_TIE_UNIT"]],
				[localize "STR_AMAE_DISARM_UNIT", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]],
				[localize "STR_AMAE_RELEASE_SIDE", "SIDE", ([side _unit] call BIS_fnc_sideID) + 1]
			]
		] call Ares_fnc_ShowChooseDialog;

		if (_dialogResult isEqualTo []) exitWith {};

		_unit setVariable ["Achilles_var_isUnitSurrendered", true];

		_dialogResult params ["_ambientAnimation", "_actionToPreform", "_disarmUnit", "_releasedUnitSide"];

		_ambientAnimation = switch (_ambientAnimation) do
		{
			case 0: {"SURRENDER"};
			case 1: {"CAPTURED_SIT"};
		};

		_actionToPreform = switch (_actionToPreform) do
		{
			case 0: {"releaseAndLead"};
			case 1: {"releaseNotLead"};
			case 2: {"tie"};
		};

		// Remove all weapons from the captive unit
		if (_disarmUnit isEqualTo 0) then
		{
			if (local _unit) then
			{
				removeAllWeapons _unit;
			}
			else
			{
				[_unit] remoteExecCall ["removeAllWeapons", _unit];
			};
		};

		private _releasedUnitSide = [_releasedUnitSide - 1] call BIS_fnc_sideType;

		_unit setVariable ["Achilles_var_getUnitSurrenderedSide", _releasedUnitSide];

		// Surrender the unit
		if (local _unit) then
		{
			[_unit, true, _releasedUnitSide, _actionToPreform, _ambientAnimation] call Achilles_fnc_surrenderUnit;
		}
		else
		{
			[_unit, true, _releasedUnitSide, _actionToPreform, _ambientAnimation] remoteExecCall ["Achilles_fnc_surrenderUnit", _unit];
		};
	};
} forEach _selectedUnits;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"