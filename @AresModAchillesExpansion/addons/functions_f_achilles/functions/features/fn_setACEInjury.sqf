////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/30/17
//	VERSION: 1.0
//  DESCRIPTION: Sets ACE damage on units
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- Unit that is injured
//	_this select 1:		STRING	- one of the possible ACE damage types e.g. "bullet"
//	_this select 2:		ARRAY	- check ACE injury module as an example
//
//	RETURNS:
//	nothing (procedure)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_unit","_injury_type","_injury_value_list","_hits"];

// Add vital loop if ace medical is pre-rewrite
if (!isNil "ace_medical_fnc_treatmentAdvanced_fullHeal") then {
    [_unit] call ace_medical_fnc_addVitalLoop;
};

{
	private _value = _injury_value_list select _forEachIndex;

    if (_value isEqualType {}) then	{_hits = [_unit] call _value} else {_hits = _value};

	for "_i" from 1 to _hits do
	{
		[_unit, 1, _x, _injury_type] call ace_medical_fnc_addDamageToUnit;
		sleep 0.1;
	};
} forEach ["head", "body", "hand_r", "hand_l","leg_r", "leg_l"];

(_injury_value_list select [6,4]) params ["_pain","_hearth_rate","_blood_pressure","_unconscious"];
_unit setVariable ["ace_medical_pain", _pain, true];
_unit setVariable ["ace_medical_heartRate", _hearth_rate, true];
_unit setVariable ["ace_medical_bloodVolume", _blood_pressure, true];
if (_unconscious) then {[_unit, true, 10e10, true] call ace_medical_fnc_setUnconscious;};
