/*
	Author: CreepPork_LV

	Description:
		Sets the animation of the captive unit and actual surrendering of the unit. Function should be executed where the unit is local.

	Parameters:
		0: OBJECT - Unit to surrender
		1: BOOL - Should the unit be surrendered?
		2: SIDE - To which side the unit should be released to
		3: STRING <"releaseAndLead", "releaseNotLead", "tie"> - Action to preform when the hold action is completed
		4: STRING <"SURRENDER", "CAPTURED_SIT"> - Ambient animation to play for the unit (Optional)
		5: OBJECT - Unit that released the captive unit (Optional)

	Returns:
		Nothing
*/

params
[
	["_unit", objNull, [objNull]],
	["_surrenderUnit", false, [false]],
	["_releasedUnitSide", civilian, [west]],
	["_actionToPreform", "releaseNotLead", [""]],
	["_ambientAnimation", "", [""]],
	["_unitReleaser", objNull, [objNull]]
];

if (isNull _unit || !local _unit) exitWith {};

if (_surrenderUnit) then
{
	// Set the unit to be captive
	_unit setCaptive true;

	[_unit, _ambientAnimation, false] call Achilles_fnc_ambientAnim;

	private _actionName = switch (_actionToPreform) do
	{
		case "tie": {isLocalized "STR_AMAE_TIE_UNIT" ? localize "STR_AMAE_TIE_UNIT" : "Tie Unit"};
		default {isLocalized "STR_AMAE_TIE_UNIT" ? localize "STR_AMAE_RELEASE_UNIT" : "Release Unit"};
	};

	[
		_unit,
		_actionName,
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
		"_this distance _target < 3",
		"_caller distance _target < 3",
		{},
		{},
		{
			params["_unit", "_caller", "_id", "_arguments"];
			_arguments params ["_releasedUnitSide", "_actionToPreform"];

			[_unit, false, _releasedUnitSide, _actionToPreform, "", _caller] remoteExecCall ["Achilles_fnc_surrenderUnit", _unit];
		},
		{},
		[_releasedUnitSide, _actionToPreform],
		7,
		20,
		true,
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _unit];
}
else
{
	// Release the unit
	_unit setCaptive false;

	// Remove from JIP queue
	remoteExecCall ["", _unit];

	_unit remoteExecCall ["RemoveAllActions", 0];

	private _animationState = animationState _unit;

	[_unit, "TERMINATE", false] call Achilles_fnc_ambientAnim;

	// Variable cleanup
	_unit setVariable ["Achilles_var_isUnitSurrendered", nil];
	_unit setVariable ["Achilles_var_getUnitSurrenderedSide", nil];

	switch (_actionToPreform) do
	{
		case "releaseAndLead":
		{
			if (! isNull _unitReleaser) then
			{
				// Delay is needed because the unit can get stuck in the animation and be unable to move
				[_unit, _unitReleaser, _animationState] spawn
				{
					params ["_unit", "_unitReleaser", "_animationState"];

					waitUntil {sleep 1; (!alive _unit || (_animationState != animationState _unit))};
					[_unit] join _unitReleaser;
				};
			};
		};
		case "releaseNotLead":
		{
			[_unit, _releasedUnitSide] call Achilles_fnc_changeSide_local;
		};
		case "tie":
		{
			[_unit, true, _releasedUnitSide, "releaseNotLead", "CAPTURED_SIT"] call Achilles_fnc_surrenderUnit;
		};
	};
};