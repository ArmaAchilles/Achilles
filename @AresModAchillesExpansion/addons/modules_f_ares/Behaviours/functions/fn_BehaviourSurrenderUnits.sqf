#include "\achilles\modules_f_ares\module_header.inc"

//Broadcast surrender function
if (isNil "Achilles_var_surrender_init_done") then
{
	publicVariable "Ares_fnc_surrenderUnit";
	STR_AMAE_RELEASE_OPTIONS = [localize "STR_AMAE_RELEASE_UNIT",localize "STR_AMAE_RELEASE_UNIT",localize "STR_AMAE_TIE_UNIT"];
	publicVariable "STR_AMAE_RELEASE_OPTIONS";
	Achilles_var_zeusLanguage = language;
	publicVariable "Achilles_var_zeusLanguage";
	Achilles_var_surrender_init_done = true;
};
//Broadcast animation function
if (isNil "Achilles_var_animation_init_done") then
{
	publicVariable "Achilles_fnc_ambientAnimGetParams";
	publicVariable "Achilles_fnc_ambientAnim";
	Achilles_var_animation_init_done = true;
};

private _unitsToSurrender = [[_logic] call Ares_fnc_GetUnitUnderCursor];

// selection option
if (isNull (_unitsToSurrender select 0)) then {	_unitsToSurrender = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits };
if (isNil "_unitsToSurrender") exitWith {};
if (_unitsToSurrender isEqualTo []) exitWith {};

private _nextCaptureStateDialogResult = nil;
{
	private _unitToSurrender = _x;
	// Determine if we've already captured the unit in the past
	private _surrenderState = _unitToSurrender getVariable ["AresCaptureState", -1];
	if (_surrenderState == -1) then
	{
		//Not yet surrendered

		// open dialog only once
		if (isNil "_nextCaptureStateDialogResult") then
		{
			_nextCaptureStateDialogResult =
			[
				localize "STR_AMAE_SURRENDER_UNIT",
				[
					[localize "STR_AMAE_AMBIENT_ANIMATION", [localize "STR_AMAE_SURRENDER_UNIT", localize "STR_AMAE_TIE_UNIT"]],
					[localize "STR_AMAE_INTERACTION", [localize "STR_AMAE_RELEASE_N_LEAD_UNIT", localize "STR_AMAE_RELEASE_UNIT", localize "STR_AMAE_TIE_UNIT"]]
				]
			] call Ares_fnc_ShowChooseDialog;
			// terminate script
			if (_nextCaptureStateDialogResult isEqualTo []) exitWith {deleteVehicle _logic; breakOut MAIN_SCOPE_NAME};
		};
		[_unitToSurrender,objNull,_nextCaptureStateDialogResult] remoteExec ["Ares_fnc_surrenderUnit",_unitToSurrender];
	} else
	{
		[_unitToSurrender,objNull,[-1,-1]] remoteExec ["Ares_fnc_surrenderUnit",_unitToSurrender];
	};
} forEach (_unitsToSurrender select {alive _x});

#include "\achilles\modules_f_ares\module_footer.inc"
